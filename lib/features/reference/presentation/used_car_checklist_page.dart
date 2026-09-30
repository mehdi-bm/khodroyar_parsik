import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/checklist_view.dart';

const List<ChecklistSection> _usedCarSections = [
  ChecklistSection('بدنه و رنگ', [
    ChecklistItem('یکدستی رنگ در نور روز (نشانه تصادف/رنگ‌شدگی)'),
    ChecklistItem('درزهای بین قطعات بدنه'),
    ChecklistItem('زنگ‌زدگی زیر بدنه و گلگیرها'),
    ChecklistItem('عملکرد صحیح درها، صندوق و درب موتور'),
    ChecklistItem('شیشه‌ها از نظر ترک یا تعویض'),
  ]),
  ChecklistSection('موتور', [
    ChecklistItem('نشتی روغن یا آب زیر موتور'),
    ChecklistItem('رنگ و بوی روغن موتور'),
    ChecklistItem('صدای غیرعادی هنگام روشن بودن موتور'),
    ChecklistItem('دود اگزوز هنگام استارت و در دور بالا'),
    ChecklistItem('سلامت شلنگ‌ها و تسمه‌ها'),
  ]),
  ChecklistSection('گیربکس و کلاچ', [
    ChecklistItem('تعویض دنده نرم و بدون ضربه'),
    ChecklistItem('گرفتن صحیح کلاچ (دنده‌دستی)'),
    ChecklistItem('نبود لرزش یا تأخیر در گیربکس اتوماتیک'),
  ]),
  ChecklistSection('زیربندی و تعلیق', [
    ChecklistItem('صدای غیرعادی روی دست‌انداز'),
    ChecklistItem('یکنواختی سایش آج لاستیک‌ها'),
    ChecklistItem('راست بودن مسیر حرکت خودرو (بدون کشش به یک طرف)'),
    ChecklistItem('عملکرد ترمزها'),
  ]),
  ChecklistSection('داخل کابین و برق', [
    ChecklistItem('عملکرد کولر و بخاری'),
    ChecklistItem('سیستم صوتی و صفحه نمایش'),
    ChecklistItem('شیشه‌بالابرها و قفل مرکزی'),
    ChecklistItem('روشن نبودن چراغ‌های هشدار روی داشبورد'),
    ChecklistItem('وضعیت صندلی‌ها و روکش‌ها'),
  ]),
  ChecklistSection('مدارک', [
    ChecklistItem('مطابقت شماره شاسی و موتور با کارت خودرو'),
    ChecklistItem('نداشتن خلافی یا بازداشتی خودرو'),
    ChecklistItem('اعتبار بیمه شخص ثالث'),
    ChecklistItem('تاریخ معاینه فنی'),
    ChecklistItem('سابقه بیمه‌ای (استعلام خسارت)'),
  ]),
  ChecklistSection('تست رانندگی', [
    ChecklistItem('استارت سرد (در صورت امکان صبح زود)'),
    ChecklistItem('شتاب‌گیری و ترمزگیری در سرعت‌های مختلف'),
    ChecklistItem('فرمان‌گیری در دور زدن‌های تند'),
    ChecklistItem('رانندگی در سرعت بالا (بزرگراه در صورت امکان)'),
  ]),
];

class UsedCarChecklistPage extends StatelessWidget {
  const UsedCarChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('چک‌لیست خرید خودروی دست‌دوم')),
      body: ChecklistView(
        sections: _usedCarSections,
        footer: const _NotesField(),
      ),
    );
  }
}

class _NotesField extends StatelessWidget {
  const _NotesField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextField(
        maxLines: 4,
        decoration: const InputDecoration(
          labelText: 'یادداشت کلی (اختیاری)',
          hintText: 'مثلاً موارد نیازمند بررسی بیشتر یا توافق با فروشنده',
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
