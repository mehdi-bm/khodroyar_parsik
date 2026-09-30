import '../../../core/utils/grouped_number_input.dart';

/// Input validation for the expense record form. Persian error messages,
/// matching the app's rule against exposing raw/technical errors. The
/// amount field uses [GroupedNumberInputFormatter], so its raw text is
/// grouped and in Persian digits — [ungroupDigits] converts it back before
/// parsing.
abstract final class ExpenseValidators {
  static String? amount(String? value) {
    final original = value?.trim() ?? '';
    if (original.isEmpty) return 'وارد کردن مبلغ الزامی است';
    final parsed = int.tryParse(ungroupDigits(original));
    if (parsed == null) return 'مبلغ باید عدد باشد';
    if (parsed <= 0) return 'مبلغ باید بیشتر از صفر باشد';
    return null;
  }
}
