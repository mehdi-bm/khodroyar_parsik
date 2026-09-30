import 'package:flutter/material.dart';

/// One driving symptom with a short list of safe, generic first checks —
/// the kind of thing any car manual lists, never a real diagnosis. Every
/// symptom's detail page also shows a fixed disclaimer pointing to a
/// mechanic; see [TroubleshootingSymptom.steps] for the specific advice.
class TroubleshootingSymptom {
  const TroubleshootingSymptom({
    required this.id,
    required this.title,
    required this.icon,
    required this.steps,
  });

  final String id;
  final String title;
  final IconData icon;
  final List<String> steps;
}

const List<TroubleshootingSymptom> troubleshootingSymptoms = [
  TroubleshootingSymptom(
    id: 'wont-start',
    title: 'خودرو استارت نمی‌خورد',
    icon: Icons.power_settings_new,
    steps: [
      'چراغ‌های داشبورد را هنگام چرخاندن سوئیچ بررسی کنید — روشن نشدن آن‌ها معمولاً نشانه باتری خالی است.',
      'ترمینال‌های باتری را از نظر شل‌بودن یا خوردگی چک کنید.',
      'مطمئن شوید دنده در حالت پارک (یا خودروهای دنده‌دستی، کلاچ کاملاً فشرده) است.',
      'صدای «تیک‌تیک» هنگام چرخاندن سوئیچ معمولاً نشانه باتری ضعیف است، نه استارتر.',
      'اگر بو یا دود مشاهده کردید، خودرو را روشن نکنید و با امداد خودرو تماس بگیرید.',
    ],
  ),
  TroubleshootingSymptom(
    id: 'check-engine',
    title: 'چراغ چک موتور روشن شده',
    icon: Icons.warning_amber_outlined,
    steps: [
      'ابتدا مطمئن شوید درب باک بنزین کاملاً بسته است — گاهی همین باعث روشن‌شدن این چراغ می‌شود.',
      'ببینید چراغ ثابت است یا چشمک می‌زند؛ چشمک‌زدن یعنی مشکل فوری‌تر است و باید سرعت و شتاب‌گیری شدید را کم کنید.',
      'به علائم دیگر مثل افت قدرت موتور یا صدای غیرعادی توجه کنید.',
      'در اولین فرصت با دستگاه عیب‌یاب OBD-II کد خطا را بخوانید یا به تعمیرگاه مراجعه کنید.',
    ],
  ),
  TroubleshootingSymptom(
    id: 'strange-noise',
    title: 'صدای غیرعادی از موتور یا زیر خودرو',
    icon: Icons.graphic_eq,
    steps: [
      'نوع صدا را به‌خاطر بسپارید (تیک‌تیک، جیرجیر، تقه، سوت).',
      'سطح روغن موتور را بررسی کنید.',
      'توجه کنید صدا با دور موتور تغییر می‌کند یا با سرعت حرکت خودرو.',
      'اگر صدا ناگهانی و شدید است، در اولین فرصت امن توقف کنید و ادامه رانندگی ندهید.',
    ],
  ),
  TroubleshootingSymptom(
    id: 'brake-feel',
    title: 'ترمز حس عجیبی دارد (سفت، نرم یا صدادار)',
    icon: Icons.report_gmailerrorred_outlined,
    steps: [
      'سطح مایع ترمز را بررسی کنید.',
      'اگر پدال ترمز تا انتها فرو می‌رود، به‌هیچ‌وجه ادامه رانندگی ندهید.',
      'صدای جیرجیر هنگام ترمز معمولاً نشانه ساییده‌شدن لنت ترمز است.',
      'ترمز یک سیستم ایمنی حیاتی است — در صورت هرگونه شک، خودرو را نرانید و با تعمیرگاه یا امداد خودرو تماس بگیرید.',
    ],
  ),
  TroubleshootingSymptom(
    id: 'overheating',
    title: 'دمای موتور بالا رفته',
    icon: Icons.thermostat,
    steps: [
      'بخاری را روشن و پنجره‌ها را باز کنید — به کاهش موقت دمای موتور کمک می‌کند.',
      'در اولین فرصت امن توقف کنید و موتور را خاموش کنید.',
      'تا سرد شدن کامل موتور (حداقل چند ده دقیقه)، درب رادیاتور یا منبع انبساط را باز نکنید.',
      'سطح آب رادیاتور را فقط پس از سرد شدن کامل بررسی کنید.',
    ],
  ),
  TroubleshootingSymptom(
    id: 'battery-drains',
    title: 'باتری خودرو خیلی زود خالی می‌شود',
    icon: Icons.battery_alert_outlined,
    steps: [
      'مطمئن شوید چراغ‌ها یا وسایل برقی روشن نمانده‌اند.',
      'عمر باتری را بررسی کنید — معمولاً بین ۲ تا ۴ سال است.',
      'ترمینال‌های باتری را از خوردگی پاک کنید.',
      'اگر مشکل ادامه دارد، ممکن است دینام یا یک مصرف‌کننده پنهان مشکل داشته باشد؛ بررسی تعمیرکار لازم است.',
    ],
  ),
  TroubleshootingSymptom(
    id: 'burning-smell',
    title: 'بوی سوختگی یا بنزین می‌آید',
    icon: Icons.local_fire_department_outlined,
    steps: [
      'فوراً در اولین جای امن توقف و خودرو را خاموش کنید.',
      'از خودرو خارج شوید و در صورت بوی سوختگی، نزدیک قسمت موتور نشوید.',
      'فوراً با امداد خودرو تماس بگیرید.',
    ],
  ),
  TroubleshootingSymptom(
    id: 'tire-pressure-loss',
    title: 'لاستیک بادش زود خالی می‌شود',
    icon: Icons.tire_repair_outlined,
    steps: [
      'لاستیک را از نظر وجود میخ یا جسم خارجی بررسی کنید.',
      'رینگ را از نظر خمیدگی یا آسیب چک کنید.',
      'اگر همه لاستیک‌ها هم‌زمان کم‌باد شده‌اند، احتمالاً دلیل آن تغییر دما است نه نشتی.',
      'برای اطمینان کامل به یک لاستیک‌فروشی مراجعه کنید.',
    ],
  ),
];
