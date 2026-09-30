import 'package:flutter_test/flutter_test.dart';

import 'package:caryar/features/advertising/data/install_id_repository.dart';

class _InMemoryInstallIdStore implements InstallIdStore {
  String? value;
  int writeCount = 0;

  @override
  Future<String?> read() async => value;

  @override
  Future<void> write(String value) async {
    writeCount++;
    this.value = value;
  }
}

void main() {
  group('InstallIdRepository', () {
    test('generates a 32-character hex id on first use', () async {
      final store = _InMemoryInstallIdStore();
      final repository = InstallIdRepository(store: store);

      final id = await repository.getOrCreate();

      expect(id.length, 32);
      expect(RegExp(r'^[0-9a-f]{32}$').hasMatch(id), isTrue);
      expect(store.writeCount, 1);
    });

    test(
      'returns the same id on subsequent calls without writing again',
      () async {
        final store = _InMemoryInstallIdStore();
        final repository = InstallIdRepository(store: store);

        final first = await repository.getOrCreate();
        final second = await repository.getOrCreate();

        expect(second, first);
        expect(store.writeCount, 1);
      },
    );

    test(
      'reuses an id already persisted by a previous install/session',
      () async {
        final store = _InMemoryInstallIdStore()..value = 'existing-id';
        final repository = InstallIdRepository(store: store);

        final id = await repository.getOrCreate();

        expect(id, 'existing-id');
        expect(store.writeCount, 0);
      },
    );

    test(
      'de-duplicates two concurrent first-use calls into one id/write',
      () async {
        final store = _InMemoryInstallIdStore();
        final repository = InstallIdRepository(store: store);

        final results = await Future.wait([
          repository.getOrCreate(),
          repository.getOrCreate(),
        ]);

        expect(results[0], results[1]);
        expect(store.writeCount, 1);
      },
    );
  });
}
