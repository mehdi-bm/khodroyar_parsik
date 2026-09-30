import 'package:flutter/material.dart';

import '../utils/persian_date.dart';

/// A tappable date display styled like a form field, showing the picked
/// [date] in Jalali. Pass [onClear] to allow un-setting an optional date;
/// omit it for a required field (shows a calendar icon instead).
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.date,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: onClear != null
              ? IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'پاک کردن تاریخ',
                  onPressed: onClear,
                )
              : const Icon(Icons.calendar_today_outlined),
        ),
        child: Text(date == null ? 'انتخاب نشده' : formatJalaliDate(date!)),
      ),
    );
  }
}
