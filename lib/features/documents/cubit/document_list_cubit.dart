import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/document_repository.dart';
import 'document_list_state.dart';

class DocumentListCubit extends Cubit<DocumentListState> {
  DocumentListCubit(this._repository) : super(const DocumentListLoading());

  final DocumentRepository _repository;
  StreamSubscription? _subscription;

  void watch(int vehicleId) {
    _subscription?.cancel();
    _subscription = _repository
        .watchForVehicle(vehicleId)
        .listen(
          (documents) => emit(DocumentListLoaded(documents)),
          onError: (Object error) =>
              emit(const DocumentListError('خطا در بارگذاری مدارک')),
        );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
