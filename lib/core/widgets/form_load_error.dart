import 'package:flutter/material.dart';

class FormLoadError extends StatelessWidget {
  const FormLoadError({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 40,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          const Text(
            'اطلاعات در دسترس نیست. ممکن است این مورد حذف شده باشد.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text('بازگشت به فهرست'),
          ),
        ],
      ),
    ),
  );
}
