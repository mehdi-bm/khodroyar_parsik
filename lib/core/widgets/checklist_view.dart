import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../utils/persian_digits.dart';

class ChecklistItem {
  const ChecklistItem(this.label);

  final String label;
}

class ChecklistSection {
  const ChecklistSection(this.title, this.items);

  final String title;
  final List<ChecklistItem> items;
}

/// A grouped, checkbox checklist with a progress indicator and a reset
/// button — shared by the pre-trip and used-car-purchase checklists.
/// Deliberately not persisted: both are meant to be run fresh each time
/// (before a trip, or once per car you're inspecting), so in-memory state
/// that resets on reset/navigation is simpler and correct for the use
/// case — a saved history of checklist runs isn't part of the ask.
class ChecklistView extends StatefulWidget {
  const ChecklistView({super.key, required this.sections, this.footer});

  final List<ChecklistSection> sections;

  /// Extra content shown after the checklist (e.g. a free-text notes
  /// field), before the reset button.
  final Widget? footer;

  @override
  State<ChecklistView> createState() => _ChecklistViewState();
}

class _ChecklistViewState extends State<ChecklistView> {
  late List<List<bool>> _checked;

  @override
  void initState() {
    super.initState();
    _checked = _blankState();
  }

  List<List<bool>> _blankState() => [
    for (final section in widget.sections)
      List<bool>.filled(section.items.length, false),
  ];

  int get _totalCount =>
      widget.sections.fold(0, (sum, s) => sum + s.items.length);

  int get _checkedCount =>
      _checked.fold(0, (sum, list) => sum + list.where((c) => c).length);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = _totalCount;
    final checkedCount = _checkedCount;

    return ListView(
      padding: AppSpacing.page(context),
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.xs),
                child: LinearProgressIndicator(
                  value: total == 0 ? 0 : checkedCount / total,
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              toPersianDigits('$checkedCount از $total'),
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        for (var si = 0; si < widget.sections.length; si++) ...[
          Text(
            widget.sections[si].title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          for (var ii = 0; ii < widget.sections[si].items.length; ii++)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(widget.sections[si].items[ii].label),
              value: _checked[si][ii],
              onChanged: (value) =>
                  setState(() => _checked[si][ii] = value ?? false),
            ),
          const SizedBox(height: AppSpacing.md),
        ],
        if (widget.footer != null) widget.footer!,
        const SizedBox(height: AppSpacing.lg),
        OutlinedButton.icon(
          onPressed: () => setState(() => _checked = _blankState()),
          icon: const Icon(Icons.refresh),
          label: const Text('شروع دوباره'),
        ),
      ],
    );
  }
}
