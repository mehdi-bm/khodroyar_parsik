/// One chapter of the in-app video tutorial. Videos are screen recordings
/// with no narration, so [steps] carries the explanation shown under the
/// player.
class TutorialVideo {
  const TutorialVideo({
    required this.id,
    required this.title,
    required this.summary,
    required this.steps,
    required this.fileName,
  });

  final String id;
  final String title;
  final String summary;
  final List<String> steps;
  final String fileName;

  Uri get url => Uri.parse('$tutorialVideosBaseUrl$fileName');
}

/// Public GitHub repo hosting the recordings — streamed on demand so they
/// don't bloat the APK. raw.githubusercontent.com is reachable from Iran
/// without a VPN.
const String tutorialVideosBaseUrl =
    'https://raw.githubusercontent.com/mehdi-bm/khodroyar-parsik-tutorials/main/videos/';

const List<TutorialVideo> tutorialVideos = [
  TutorialVideo(
    id: 'getting-started',
    title: 'شروع کار و افزودن خودرو',
    summary: 'اولین قدم: ثبت خودرو و مشخصات قطعات مصرفی آن.',
    steps: [
      'در صفحه خانه روی «افزودن خودرو» بزنید.',
      'نام خودرو و کیلومتر فعلی را وارد کنید (عکس، برند، مدل و پلاک اختیاری است).',
      'در بخش «مشخصات قطعات مصرفی» نوع روغن، سایز لاستیک و… را ثبت کنید تا موقع خرید دنبالشان نگردید.',
      'با زدن «افزودن خودرو» داشبورد خودرو نمایش داده می‌شود.',
    ],
    fileName: '01-getting-started.mp4',
  ),
  TutorialVideo(
    id: 'service',
    title: 'ثبت سرویس و یادآور سرویس بعدی',
    summary: 'ثبت تعویض روغن و تعمیرات، و تعیین موعد سرویس بعدی.',
    steps: [
      'از «ثبت سریع» روی «ثبت سرویس» بزنید.',
      'عنوان، دسته‌بندی و هزینه را وارد کنید؛ کیلومتر خودکار پر می‌شود.',
      'در «سرویس بعدی» کیلومتر یا تاریخ سرویس بعدی را بدهید تا برنامه یادآوری کند.',
      'وضعیت سرویس بعدی در کارت «وضعیت خودرو» روی داشبورد دیده می‌شود.',
    ],
    fileName: '02-service.mp4',
  ),
  TutorialVideo(
    id: 'fuel-expense',
    title: 'ثبت سوخت‌گیری و هزینه‌ها',
    summary: 'ثبت بنزین و هزینه‌هایی مثل بیمه، کارواش و لاستیک.',
    steps: [
      '«ثبت سوخت» را بزنید و کیلومتر، مقدار لیتر و مبلغ را وارد کنید.',
      'اگر باک را پر کردید «باک پر شد» را روشن بگذارید؛ از دومین باک پر، مصرف تقریبی محاسبه می‌شود.',
      'برای سایر خرج‌ها «ثبت هزینه» را بزنید و دسته‌بندی مناسب را انتخاب کنید.',
    ],
    fileName: '03-fuel-expense.mp4',
  ),
  TutorialVideo(
    id: 'documents',
    title: 'ثبت مدارک و تاریخ انقضا',
    summary: 'بیمه، معاینه فنی و گواهینامه را ثبت کنید تا تمدیدشان یادتان نرود.',
    steps: [
      '«ثبت مدرک» را بزنید و عنوان و نوع مدرک را انتخاب کنید.',
      'تاریخ انقضا را از تقویم شمسی انتخاب کنید.',
      'نزدیک موعد، برنامه یادآوری می‌فرستد و وضعیت مدرک روی داشبورد نمایش داده می‌شود.',
    ],
    fileName: '04-documents.mp4',
  ),
  TutorialVideo(
    id: 'reports',
    title: 'گزارش‌ها و خروجی PDF',
    summary: 'جمع هزینه‌ها به تفکیک، نمودار ماهانه و گرفتن فایل PDF.',
    steps: [
      'به تب «گزارش‌ها» بروید و بازه (این ماه، ماه گذشته، امسال) را انتخاب کنید.',
      'هزینه کل و سهم سرویس، سوخت و سایر هزینه‌ها را ببینید.',
      'با «خروجی PDF» گزارش کامل ساخته می‌شود و می‌توانید آن را ذخیره یا برای کسی بفرستید.',
    ],
    fileName: '05-reports.mp4',
  ),
  TutorialVideo(
    id: 'more-tools',
    title: 'تاریخچه، محل پارک و ابزارهای راهنما',
    summary: 'امکانات تب «بیشتر»: تاریخچه کامل، محل پارک، چراغ‌های آمپر، عیب‌یابی و چک‌لیست‌ها.',
    steps: [
      '«تاریخچه کامل خودرو» همه سوابق را به ترتیب ماه نشان می‌دهد.',
      'در «محل پارک خودرو» با یک لمس موقعیت فعلی، عکس یا یادداشت محل پارک را ذخیره کنید.',
      '«راهنمای چراغ‌های آمپر» معنی هر چراغ و کاری که باید بکنید را توضیح می‌دهد.',
      '«عیب‌یابی اولیه» و چک‌لیست‌های «قبل از سفر» و «خرید خودروی دست‌دوم» را هم ببینید.',
    ],
    fileName: '06-more-tools.mp4',
  ),
  TutorialVideo(
    id: 'settings',
    title: 'تنظیمات، یادآورها و پشتیبان‌گیری',
    summary: 'حالت تیره، یادآورها و تهیه نسخه پشتیبان از اطلاعات.',
    steps: [
      'در «تنظیمات» ظاهر برنامه (روشن، تیره یا خودکار) را انتخاب کنید.',
      'یادآورهای سرویس و مدارک را روشن یا خاموش کنید.',
      'اطلاعات فقط روی گوشی شما ذخیره می‌شود؛ با «پشتیبان‌گیری» از آن نسخه بگیرید تا با تعویض گوشی از دست نرود.',
    ],
    fileName: '07-settings.mp4',
  ),
];

TutorialVideo? tutorialById(String id) {
  for (final video in tutorialVideos) {
    if (video.id == id) return video;
  }
  return null;
}
