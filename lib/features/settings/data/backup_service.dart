import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

import '../../../core/database/app_database.dart';

/// Consistent SQLite snapshots with embedded photos. Restoration imports data
/// into the live connection in one transaction, keeping all screens usable.
class BackupService {
  BackupService(this._db);
  final AppDatabase _db;
  static const _photoTables = [
    'vehicles',
    'maintenance_records',
    'expense_records',
    'documents',
  ];
  static const _maxBackupBytes = 256 * 1024 * 1024;
  bool _busy = false;

  Future<File> createBackup() async {
    if (_busy) throw StateError('Backup operation already running');
    _busy = true;
    File? output;
    try {
      final temp = await getTemporaryDirectory();
      output = File(
        p.join(
          temp.path,
          'khodroyar-backup-${DateTime.now().microsecondsSinceEpoch}.sqlite',
        ),
      );
      await _db.customStatement('VACUUM INTO ?', [output.path]);
      final snapshot = sqlite.sqlite3.open(output.path);
      try {
        snapshot.execute(
          'CREATE TABLE caryar_backup_media (original_path TEXT PRIMARY KEY, content BLOB NOT NULL)',
        );
        final paths = <String>{};
        for (final table in _photoTables) {
          for (final row in snapshot.select(
            'SELECT photo_path FROM "$table" WHERE photo_path IS NOT NULL',
          )) {
            paths.add(row['photo_path'] as String);
          }
        }
        for (final path in paths) {
          final photo = File(path);
          if (!await photo.exists()) continue;
          if (await photo.length() > 32 * 1024 * 1024) {
            throw const FormatException('Photo is too large');
          }
          snapshot.execute('INSERT INTO caryar_backup_media VALUES (?, ?)', [
            path,
            await photo.readAsBytes(),
          ]);
        }
      } finally {
        snapshot.close();
      }
      if (await output.length() > _maxBackupBytes) {
        throw const FormatException('Backup is too large');
      }
      return output;
    } catch (_) {
      if (output != null && await output.exists()) await output.delete();
      rethrow;
    } finally {
      _busy = false;
    }
  }

  /// Compatibility name; checks integrity and application schema, not just
  /// SQLite's header. Unrelated databases must never replace user data.
  Future<bool> looksLikeSqliteDatabase(File file) async {
    try {
      final source = await _openValidated(file);
      source.close();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<sqlite.Database> _openValidated(File file) async {
    final length = await file.length();
    if (length < 100 || length > _maxBackupBytes) {
      throw const FormatException('Invalid backup size');
    }
    final source = sqlite.sqlite3.open(
      file.path,
      mode: sqlite.OpenMode.readOnly,
    );
    try {
      source.execute('PRAGMA trusted_schema = OFF');
      final version =
          source.select('PRAGMA user_version').single.values.single as int;
      if (version < 1 ||
          version > _db.schemaVersion ||
          source.select('PRAGMA quick_check').single.values.single != 'ok' ||
          source.select('PRAGMA foreign_key_check').isNotEmpty) {
        throw const FormatException('Invalid or unsupported database');
      }
      final tables = source
          .select("SELECT name FROM sqlite_master WHERE type = 'table'")
          .map((r) => r['name'])
          .toSet();
      for (final table in _db.allTables) {
        if (!tables.contains(table.actualTableName)) {
          throw const FormatException('Missing table');
        }
        final columns = source
            .select('PRAGMA table_info("${table.actualTableName}")')
            .map((r) => r['name'])
            .toSet();
        for (final column in table.$columns) {
          if (version == 1 &&
              table.actualTableName == 'app_settings' &&
              column.$name == 'active_vehicle_id') {
            continue;
          }
          if (!columns.contains(column.$name)) {
            throw const FormatException('Missing column');
          }
        }
      }
      final settings = source.select('SELECT id FROM app_settings');
      if (settings.length != 1 || settings.single['id'] != 0) {
        throw const FormatException('Invalid settings');
      }
      return source;
    } catch (_) {
      source.close();
      rethrow;
    }
  }

  Future<void> restoreFromFile(File backupFile) async {
    if (_busy) throw StateError('Backup operation already running');
    _busy = true;
    sqlite.Database? source;
    Directory? importedPhotos;
    var committed = false;
    try {
      source = await _openValidated(backupFile);
      final rows = <String, List<Map<String, Object?>>>{};
      for (final table in _db.allTables) {
        final available = source
            .select('PRAGMA table_info("${table.actualTableName}")')
            .map((r) => r['name'])
            .toSet();
        final columns = table.$columns
            .map((c) => c.$name)
            .where(available.contains);
        rows[table.actualTableName] = source
            .select(
              'SELECT ${columns.map((c) => '"$c"').join(',')} FROM "${table.actualTableName}"',
            )
            .map((row) => Map<String, Object?>.from(row))
            .toList();
      }
      final hasMedia = source
          .select(
            "SELECT name FROM sqlite_master WHERE type='table' AND name='caryar_backup_media'",
          )
          .isNotEmpty;
      final docs = await getApplicationDocumentsDirectory();
      importedPhotos = Directory(
        p.join(docs.path, 'restored_${DateTime.now().microsecondsSinceEpoch}'),
      );
      final rewritten = <String, String?>{};
      var photoIndex = 0;
      for (final table in _photoTables) {
        for (final row in rows[table]!) {
          final oldPath = row['photo_path'] as String?;
          if (oldPath == null) continue;
          if (!rewritten.containsKey(oldPath)) {
            final media = hasMedia
                ? source.select(
                    'SELECT content FROM caryar_backup_media WHERE original_path = ?',
                    [oldPath],
                  )
                : null;
            if (media != null && media.isNotEmpty) {
              final bytes = media.single['content'];
              if (bytes is! List<int> || bytes.length > 32 * 1024 * 1024) {
                throw const FormatException('Invalid photo');
              }
              await importedPhotos.create(recursive: true);
              // Never extract a path supplied by the backup itself.
              final target = File(
                p.join(importedPhotos.path, '${photoIndex++}.image'),
              );
              await target.writeAsBytes(bytes, flush: true);
              rewritten[oldPath] = target.path;
            } else {
              // Old backups have paths only. Missing photos become empty avatars.
              rewritten[oldPath] =
                  p.isWithin(docs.path, oldPath) && await File(oldPath).exists()
                  ? oldPath
                  : null;
            }
          }
          row['photo_path'] = rewritten[oldPath];
        }
      }
      source.close();
      source = null;
      await _db.transaction(() async {
        await _db.customStatement('PRAGMA defer_foreign_keys = ON');
        for (final table in _db.allTables.toList().reversed) {
          await _db.customStatement('DELETE FROM "${table.actualTableName}"');
        }
        for (final name in [
          'vehicles',
          ...rows.keys.where((n) => n != 'vehicles' && n != 'app_settings'),
          'app_settings',
        ]) {
          for (final row in rows[name]!) {
            await _db.customStatement(
              'INSERT INTO "$name" (${row.keys.map((k) => '"$k"').join(',')}) VALUES (${List.filled(row.length, '?').join(',')})',
              row.values.toList(),
            );
          }
        }
        if ((await _db.customSelect('PRAGMA foreign_key_check').get())
            .isNotEmpty) {
          throw const FormatException('Broken references');
        }
        _db.notifyUpdates({
          for (final table in _db.allTables) TableUpdate(table.actualTableName),
        });
      });
      committed = true;
    } finally {
      source?.close();
      if (!committed &&
          importedPhotos != null &&
          await importedPhotos.exists()) {
        await importedPhotos.delete(recursive: true);
      }
      _busy = false;
    }
  }
}
