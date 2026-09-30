import '../../../core/database/app_database.dart';

sealed class DocumentListState {
  const DocumentListState();
}

class DocumentListLoading extends DocumentListState {
  const DocumentListLoading();
}

class DocumentListLoaded extends DocumentListState {
  const DocumentListLoaded(this.documents);
  final List<Document> documents;
}

class DocumentListError extends DocumentListState {
  const DocumentListError(this.message);
  final String message;
}
