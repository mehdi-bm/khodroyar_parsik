import 'package:flutter/material.dart';

/// How urgently the driver needs to react — drives the color used in the
/// UI. Matches the traffic-light convention most vehicle manuals use:
/// red = stop now, amber = needs attention soon, blue/green = informational.
enum WarningLightSeverity { critical, warning, info }

class WarningLight {
  const WarningLight({
    required this.title,
    required this.icon,
    required this.severity,
    required this.meaning,
    required this.action,
  });

  final String title;
  final IconData icon;
  final WarningLightSeverity severity;
  final String meaning;
  final String action;
}

/// A general reference list, not manufacturer-specific data — exact color
/// and shape vary between vehicles, which the guide's own page says
/// up front. Content is deliberately generic, widely-known car-manual-level
/// information; nothing here is a substitute for the vehicle's own manual
/// or a mechanic's diagnosis.
const List<WarningLight> warningLights = [
  WarningLight(
    title: 'دمای موتور',
    icon: Icons.thermostat,
    severity: WarningLightSeverity.critical,
    meaning: 'دمای آب موتور بیش از حد بالا رفته است.',
    action:
        'در اولین فرصت امن خودرو را متوقف و خاموش کنید. تا سرد شدن کامل '
        'موتور، درب رادیاتور را باز نکنید.',
  ),
  WarningLight(
    title: 'فشار روغن موتور',
    icon: Icons.oil_barrel_outlined,
    severity: WarningLightSeverity.critical,
    meaning: 'فشار روغن موتور پایین است — ادامه رانندگی می‌تواند به موتور آسیب برساند.',
    action: 'فوراً خودرو را متوقف و خاموش کنید و با امداد خودرو تماس بگیرید.',
  ),
  WarningLight(
    title: 'سیستم ترمز',
    icon: Icons.report_gmailerrorred_outlined,
    severity: WarningLightSeverity.critical,
    meaning: 'ممکن است سطح مایع ترمز پایین باشد یا ترمز دستی فعال باشد.',
    action:
        'ابتدا مطمئن شوید ترمز دستی پایین کشیده نشده. در غیر این صورت با '
        'احتیاط به تعمیرگاه مراجعه کنید و از رانندگی طولانی خودداری کنید.',
  ),
  WarningLight(
    title: 'شارژ باتری',
    icon: Icons.battery_alert_outlined,
    severity: WarningLightSeverity.critical,
    meaning: 'سیستم شارژ (دینام) باتری را به‌درستی شارژ نمی‌کند.',
    action: 'در اولین فرصت به تعمیرگاه مراجعه کنید؛ خودرو ممکن است خاموش شود.',
  ),
  WarningLight(
    title: 'کیسه هوا (ایربگ)',
    icon: Icons.airline_seat_recline_normal_outlined,
    severity: WarningLightSeverity.critical,
    meaning: 'مشکلی در سیستم کیسه هوا یا پیش‌کشنده کمربند تشخیص داده شده است.',
    action: 'در صورت تصادف ممکن است کیسه هوا باز نشود — هرچه زودتر بررسی کنید.',
  ),
  WarningLight(
    title: 'فرمان هیدرولیک/برقی',
    icon: Icons.settings_input_component_outlined,
    severity: WarningLightSeverity.critical,
    meaning: 'مشکلی در سیستم کمک‌فرمان وجود دارد — فرمان ممکن است سنگین شود.',
    action: 'با احتیاط رانندگی کنید و در اولین فرصت خودرو را بررسی کنید.',
  ),
  WarningLight(
    title: 'چک موتور',
    icon: Icons.warning_amber_outlined,
    severity: WarningLightSeverity.warning,
    meaning: 'کامپیوتر خودرو یک ایراد در موتور یا سیستم اگزوز ثبت کرده است.',
    action:
        'اگر چراغ چشمک می‌زند، فوراً سرعت را کم کنید و به تعمیرگاه بروید. اگر '
        'ثابت است، در روزهای آینده خودرو را بررسی کنید.',
  ),
  WarningLight(
    title: 'ترمز ضد قفل (ABS)',
    icon: Icons.disc_full_outlined,
    severity: WarningLightSeverity.warning,
    meaning: 'سیستم ABS غیرفعال شده — ترمز عادی کار می‌کند ولی بدون کنترل سرخوردگی.',
    action: 'در اولین فرصت به تعمیرگاه مراجعه کنید.',
  ),
  WarningLight(
    title: 'فشار باد لاستیک',
    icon: Icons.tire_repair_outlined,
    severity: WarningLightSeverity.warning,
    meaning: 'فشار باد یک یا چند لاستیک پایین‌تر از حد استاندارد است.',
    action: 'در اولین فرصت باد لاستیک‌ها را با فشار توصیه‌شده تنظیم کنید.',
  ),
  WarningLight(
    title: 'کنترل پایداری (ESP/ESC)',
    icon: Icons.control_camera_outlined,
    severity: WarningLightSeverity.warning,
    meaning: 'سیستم کنترل پایداری فعال شده یا غیرفعال است.',
    action: 'چشمک‌زدن هنگام رانندگی طبیعی است؛ روشن‌ماندن ثابت را بررسی کنید.',
  ),
  WarningLight(
    title: 'سطح مایع شیشه‌شوی',
    icon: Icons.water_drop_outlined,
    severity: WarningLightSeverity.warning,
    meaning: 'مخزن مایع شیشه‌شوی خالی یا در آستانه خالی‌شدن است.',
    action: 'مخزن را با مایع شیشه‌شوی مناسب پر کنید.',
  ),
  WarningLight(
    title: 'فیلتر ذرات دوده (DPF) — دیزل',
    icon: Icons.filter_alt_outlined,
    severity: WarningLightSeverity.warning,
    meaning: 'فیلتر ذرات دوده نیاز به تخلیه (رجنریشن) دارد.',
    action: 'طبق دفترچه راهنما چند دقیقه در سرعت ثابت جاده رانندگی کنید.',
  ),
  WarningLight(
    title: 'بنزین کم',
    icon: Icons.local_gas_station_outlined,
    severity: WarningLightSeverity.warning,
    meaning: 'سوخت باقی‌مانده باک به پایان نزدیک است.',
    action: 'در اولین فرصت سوخت‌گیری کنید.',
  ),
  WarningLight(
    title: 'کمربند ایمنی',
    icon: Icons.airline_seat_recline_extra_outlined,
    severity: WarningLightSeverity.warning,
    meaning: 'یکی از سرنشینان کمربند ایمنی را نبسته است.',
    action: 'کمربند ایمنی همه سرنشینان را قبل از حرکت ببندید.',
  ),
  WarningLight(
    title: 'درب باز',
    icon: Icons.sensor_door_outlined,
    severity: WarningLightSeverity.warning,
    meaning: 'یکی از درها، درب موتور یا صندوق عقب کاملاً بسته نیست.',
    action: 'قبل از حرکت مطمئن شوید همه درها کاملاً بسته‌اند.',
  ),
  WarningLight(
    title: 'چراغ نور بالا',
    icon: Icons.wb_incandescent_outlined,
    severity: WarningLightSeverity.info,
    meaning: 'نور بالای چراغ‌های جلو روشن است.',
    action: 'در مواجهه با خودروی مقابل، به نور پایین تغییر دهید.',
  ),
  WarningLight(
    title: 'راهنما',
    icon: Icons.turn_right_outlined,
    severity: WarningLightSeverity.info,
    meaning: 'چراغ راهنمای سمت راست یا چپ فعال است.',
    action: 'موردی نیاز نیست — پس از تغییر مسیر معمولاً خودکار خاموش می‌شود.',
  ),
  WarningLight(
    title: 'کروز کنترل',
    icon: Icons.speed_outlined,
    severity: WarningLightSeverity.info,
    meaning: 'تنظیم‌کننده سرعت ثابت (کروز کنترل) فعال است.',
    action: 'موردی نیاز نیست.',
  ),
  WarningLight(
    title: 'شمع پیش‌گرم — دیزل',
    icon: Icons.local_fire_department_outlined,
    severity: WarningLightSeverity.info,
    meaning: 'شمع‌های پیش‌گرم در حال آماده‌سازی موتور دیزل برای روشن‌شدن هستند.',
    action: 'صبر کنید تا چراغ خاموش شود، سپس موتور را روشن کنید.',
  ),
];
