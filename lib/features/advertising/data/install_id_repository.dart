import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

const String _prefsKey = 'advertising_external_user_id';

/// The tiny bit of persistence [InstallIdRepository] needs — split out from
/// [SharedPreferencesAsync] so tests can supply an in-memory fake without
/// depending on `shared_preferences`'s own platform-mocking surface.
abstract interface class InstallIdStore {
  Future<String?> read();
  Future<void> write(String value);
}

class SharedPreferencesInstallIdStore implements InstallIdStore {
  SharedPreferencesInstallIdStore([SharedPreferencesAsync? preferences])
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  @override
  Future<String?> read() => _preferences.getString(_prefsKey);

  @override
  Future<void> write(String value) => _preferences.setString(_prefsKey, value);
}

/// Provides a random, anonymous, per-install identifier used only to
/// de-duplicate/attribute ad clicks server-side — never the Android ID,
/// IMEI, phone number, or any other hardware/personal identifier.
/// Generated once on first use and cached via [InstallIdStore] for the
/// lifetime of the install.
class InstallIdRepository {
  InstallIdRepository({InstallIdStore? store})
    : _store = store ?? SharedPreferencesInstallIdStore();

  final InstallIdStore _store;

  // Guards against two concurrent callers (e.g. the banner fetch and a
  // form submit racing on first launch) each generating and writing a
  // different id.
  Future<String>? _inFlight;

  Future<String> getOrCreate() {
    return _inFlight ??= _load().whenComplete(() => _inFlight = null);
  }

  Future<String> _load() async {
    final existing = await _store.read();
    if (existing != null && existing.isNotEmpty) return existing;

    final generated = _generateId();
    await _store.write(generated);
    return generated;
  }

  String _generateId() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
