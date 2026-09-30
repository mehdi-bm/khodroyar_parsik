sealed class DocumentFormState {
  const DocumentFormState();
}

class DocumentFormIdle extends DocumentFormState {
  const DocumentFormIdle();
}

class DocumentFormSubmitting extends DocumentFormState {
  const DocumentFormSubmitting();
}

class DocumentFormSuccess extends DocumentFormState {
  const DocumentFormSuccess();
}

class DocumentFormFailure extends DocumentFormState {
  const DocumentFormFailure(this.message);
  final String message;
}
