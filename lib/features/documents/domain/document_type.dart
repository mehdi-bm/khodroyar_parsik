/// Vehicle document types from the spec: insurance, technical inspection,
/// or other. Stored in the DB as the enum's `name` (free text column).
enum DocumentType {
  insurance,
  inspection,
  other;

  String get label => switch (this) {
    DocumentType.insurance => 'بیمه',
    DocumentType.inspection => 'معاینه فنی',
    DocumentType.other => 'سایر',
  };

  static DocumentType fromStorageKey(String key) {
    return DocumentType.values.firstWhere(
      (type) => type.name == key,
      orElse: () => DocumentType.other,
    );
  }
}
