import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/document_repository.dart';
import 'document_form_state.dart';

class DocumentFormCubit extends Cubit<DocumentFormState> {
  DocumentFormCubit(this._repository) : super(const DocumentFormIdle());

  final DocumentRepository _repository;

  Future<void> submit({
    int? id,
    required int vehicleId,
    required String title,
    required String type,
    DateTime? startDate,
    required DateTime expirationDate,
    String? photoPath,
    String? notes,
  }) async {
    if (isClosed || state is DocumentFormSubmitting) return;
    emit(const DocumentFormSubmitting());
    try {
      if (id == null) {
        await _repository.addDocument(
          vehicleId: vehicleId,
          title: title,
          type: type,
          startDate: startDate,
          expirationDate: expirationDate,
          photoPath: photoPath,
          notes: notes,
        );
      } else {
        await _repository.updateDocument(
          id: id,
          vehicleId: vehicleId,
          title: title,
          type: type,
          startDate: startDate,
          expirationDate: expirationDate,
          photoPath: photoPath,
          notes: notes,
        );
      }
      if (!isClosed) emit(const DocumentFormSuccess());
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('DocumentFormCubit.submit failed: $error\n$stackTrace');
      }
      if (!isClosed) {
        emit(const DocumentFormFailure('عملیات انجام نشد. دوباره تلاش کنید.'));
      }
    }
  }
}
