import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حریم خصوصی')),
      body: ListView(
        padding: AppSpacing.page(context),
        children: const [
          _PrivacySection(
            title: 'چه اطلاعاتی ذخیره می‌شود',
            bullets: [
              'اطلاعاتی که خودتان وارد می‌کنید: نام و مشخصات خودرو، کیلومتر، سرویس‌ها، سوخت‌گیری‌ها، هزینه‌ها و مدارک.',
              'عکس‌هایی که به‌صورت اختیاری برای خودرو یا مدارک انتخاب می‌کنید.',
            ],
          ),
          SizedBox(height: AppSpacing.xl),
          _PrivacySection(
            title: 'چه اطلاعاتی هرگز جمع‌آوری نمی‌شود',
            bullets: [
              'موقعیت مکانی (GPS)',
              'مخاطبین، پیامک‌ها یا سابقه تماس‌ها',
              'نیازی به ثبت‌نام یا ورود با شماره موبایل یا ایمیل نیست',
              'اطلاعات خودرو، هزینه‌ها و مدارک برای تبلیغات ارسال نمی‌شود.',
            ],
          ),
          SizedBox(height: AppSpacing.xl),
          _PrivacySection(
            title: 'محل ذخیره‌سازی',
            bullets: [
              'اطلاعات خودرو و عکس‌های انتخابی در حافظه اختصاصی برنامه روی گوشی ذخیره می‌شوند. ثبت و مشاهده این اطلاعات به اینترنت نیاز ندارد.',
              'همگام‌سازی ابری در برنامه وجود ندارد. پیش از حذف برنامه یا تعویض گوشی، از تنظیمات فایل پشتیبان بگیرید.',
              'فایل پشتیبان شامل اطلاعات و عکس‌های موجود است و رمزگذاری نشده؛ آن را فقط در محل مطمئن ذخیره کنید. عکس‌های حذف‌شده از گوشی در پشتیبان قرار نمی‌گیرند.',
            ],
          ),
          SizedBox(height: AppSpacing.xl),
          _PrivacySection(
            title: 'دسترسی‌های برنامه',
            bullets: [
              'دوربین و گالری: فقط زمانی درخواست می‌شود که خودتان بخواهید برای خودرو یا مدرکی عکس اضافه کنید.',
              'اعلان‌ها: فقط برای یادآوری سرویس و انقضای مدارک استفاده می‌شود و از تنظیمات برنامه قابل غیرفعال کردن است.',
            ],
          ),
          SizedBox(height: AppSpacing.xl),
          _PrivacySection(
            title: 'تبلیغات و خدمات آنلاین',
            bullets: [
              'برای دریافت بنرهای تبلیغاتی، برنامه به سرویس پارسیک متصل می‌شود. مانند هر اتصال اینترنتی، نشانی IP برای سرور قابل مشاهده است.',
              'با لمس تبلیغ، شناسه تصادفی نصب برنامه، شناسه تبلیغ، نام برنامه و نوع پلتفرم برای ثبت کلیک به سرویس پارسیک ارسال می‌شود. این شناسه از مخاطبین، شماره تلفن یا شناسه سخت‌افزاری گوشی گرفته نمی‌شود.',
              'لینک تبلیغ در مرورگر باز می‌شود و سایت مقصد سیاست حریم خصوصی مستقل دارد.',
            ],
          ),
          SizedBox(height: AppSpacing.xl),
          _PrivacySection(
            title: 'پشتیبانی و اشتراک‌گذاری',
            bullets: [
              'گزارش خطا فقط هنگام انتخاب ارسال، با متنی که خودتان نوشته‌اید برای پارسیک فرستاده می‌شود. اطلاعات حساس را در متن گزارش ننویسید.',
              'در فرم درخواست تبلیغ، نام، شماره تماس، استان، شهر و توضیحاتی که وارد می‌کنید برای پیگیری درخواست ارسال می‌شوند.',
              'فایل پشتیبان تنها از طریق گزینه اشتراک‌گذاری و با انتخاب خودتان به برنامه یا شخص دیگری داده می‌شود.',
              'برای حذف اطلاعات محلی می‌توانید خودرو را از فهرست خودروها حذف کنید یا داده‌های برنامه را از تنظیمات اندروید پاک کنید. برای پیگیری اطلاعات ارسال‌شده، از بخش گزارش خطا با پشتیبانی ارتباط بگیرید.',
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivacySection extends StatelessWidget {
  const _PrivacySection({required this.title, required this.bullets});

  final String title;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final bullet in bullets)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('•  '),
                Expanded(
                  child: Text(bullet, style: theme.textTheme.bodyMedium),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
