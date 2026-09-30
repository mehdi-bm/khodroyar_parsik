sealed class ExpenseFormState {
  const ExpenseFormState();
}

class ExpenseFormIdle extends ExpenseFormState {
  const ExpenseFormIdle();
}

class ExpenseFormSubmitting extends ExpenseFormState {
  const ExpenseFormSubmitting();
}

class ExpenseFormSuccess extends ExpenseFormState {
  const ExpenseFormSuccess();
}

class ExpenseFormFailure extends ExpenseFormState {
  const ExpenseFormFailure(this.message);
  final String message;
}
