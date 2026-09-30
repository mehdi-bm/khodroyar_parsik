import '../../../core/utils/persian_digits.dart';

/// Allowed "notify N days before" choices (spec section 51's own examples
/// are 7/3/1 — 14 is added as a reasonable extra, not invented data, just
/// another round number on the same scale).
const List<int> reminderTimingOptionsDays = [14, 7, 3, 1];

String reminderTimingLabel(int days) => toPersianDigits('$days روز قبل');
