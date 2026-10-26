/// One app of the Parsik suite, as listed on the developer's Cafe Bazaar
/// page (https://cafebazaar.ir/developer/parsikhesab).
class ParsikApp {
  const ParsikApp({required this.name, required this.packageName});

  final String name;
  final String packageName;

  String get iconAsset => 'assets/apps/$packageName.png';

  /// Opens the app's page inside the Bazaar client when it's installed.
  Uri get bazaarAppUri => Uri(
    scheme: 'bazaar',
    host: 'details',
    queryParameters: <String, String>{'id': packageName},
  );

  /// Web fallback for devices without the Bazaar client.
  Uri get bazaarWebUri => Uri.https('cafebazaar.ir', '/app/$packageName');
}

/// This app's own package name — filtered out of [kParsikApps] so the list
/// never advertises the app the user is already in.
const String kOwnPackageName = 'com.parsik.caryar';

/// The whole suite, in the order of the Bazaar developer page. Keep this
/// list identical in every Parsik app (each one filters itself out), and
/// update it — plus the matching icon in `assets/apps/` — in all of them
/// whenever an app's name, icon or Bazaar page changes.
const List<ParsikApp> kParsikApps = <ParsikApp>[
  ParsikApp(
    name: 'حسابیار پارسیک | مدیریت دخل و خرج',
    packageName: 'ir.parsik.hesabyar',
  ),
  ParsikApp(name: 'عادتینو', packageName: 'ir.parsikhesab.habitino'),
  ParsikApp(name: 'پارسیک اذان', packageName: 'ir.parsik.azan'),
  ParsikApp(name: 'پارسیک هرا', packageName: 'ir.parsik.parsik_hera'),
  ParsikApp(
    name: 'کارا | برنامه‌ریزی و مدیریت کارها',
    packageName: 'com.kara.app.kara_todo',
  ),
  ParsikApp(name: 'پارسیک اسکن', packageName: 'com.parsscan.parsscan'),
  ParsikApp(name: 'پارسیک هواشناسی', packageName: 'com.weather.weather_plus'),
  ParsikApp(name: 'لغت‌یار ۵۰۴', packageName: 'com.vocab.essential_words_504'),
  ParsikApp(name: 'تبدیل به متن', packageName: 'com.convert.text'),
  ParsikApp(name: 'پارسیک کدخوان', packageName: 'ir.parsik.parsik_code_reader'),
  ParsikApp(name: 'پارسیک فیت', packageName: 'com.parsikfit.parsik_fit'),
  ParsikApp(
    name: 'پارسیک دانلودر',
    packageName: 'com.parsikhesab.parsik_downloader',
  ),
  ParsikApp(name: 'پارسیک پلیر', packageName: 'com.parsik.parsik_player'),
  ParsikApp(name: 'مال‌من', packageName: 'ir.liteapp.malman'),
  ParsikApp(
    name: 'AnyCalc؛ ماشین‌حساب همه‌کاره',
    packageName: 'com.liteapp.anycalc',
  ),
  ParsikApp(name: 'حساب پارسیک', packageName: 'ir.parsik.hesab_parsik'),
  ParsikApp(name: 'پارسیک Pass', packageName: 'com.parsiksa.parsikpass'),
  ParsikApp(name: 'پارسیک Pomodoro', packageName: 'com.parsik.parsik_focus'),
  ParsikApp(name: 'جعبه‌ابزار پارسیک', packageName: 'com.parsik.toolbax'),
  ParsikApp(name: 'خودرویار پارسیک', packageName: 'com.parsik.caryar'),
  ParsikApp(name: 'پارسیک SOS', packageName: 'com.parsik.flash'),
  ParsikApp(name: 'یادیار پارسیک', packageName: 'com.yadyar.yadyar_app'),
  ParsikApp(name: 'رزومه یار پارسیک', packageName: 'com.parsik.resumeyar'),
];

/// The suite minus this app — what the "other apps" page shows.
final List<ParsikApp> kOtherParsikApps = List.unmodifiable(
  kParsikApps.where((app) => app.packageName != kOwnPackageName),
);
