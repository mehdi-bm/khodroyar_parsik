import 'package:flutter/material.dart';

import '../../../core/widgets/checklist_view.dart';

const List<ChecklistSection> _pretripSections = [
  ChecklistSection('روغن و مایعات', [
    ChecklistItem('روغن موتور'),
    ChecklistItem('آب رادیاتور'),
    ChecklistItem('مایع شیشه‌شوی'),
    ChecklistItem('مایع ترمز'),
  ]),
  ChecklistSection('لاستیک و زاپاس', [
    ChecklistItem('باد لاستیک‌ها'),
    ChecklistItem('وضعیت آج لاستیک‌ها'),
    ChecklistItem('لاستیک زاپاس'),
    ChecklistItem('جک و آچار چرخ'),
  ]),
  ChecklistSection('چراغ‌ها و برف‌پاک‌کن', [
    ChecklistItem('چراغ‌های جلو'),
    ChecklistItem('چراغ‌های ترمز'),
    ChecklistItem('راهنماها'),
    ChecklistItem('برف‌پاک‌کن و مایع آن'),
  ]),
  ChecklistSection('ایمنی', [
    ChecklistItem('کمربندهای ایمنی'),
    ChecklistItem('جعبه کمک‌های اولیه'),
    ChecklistItem('مثلث خطر و جلیقه شبرنگ'),
    ChecklistItem('عملکرد ترمز دستی'),
  ]),
];

class PretripChecklistPage extends StatelessWidget {
  const PretripChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('چک‌لیست قبل از سفر')),
      body: const ChecklistView(sections: _pretripSections),
    );
  }
}
