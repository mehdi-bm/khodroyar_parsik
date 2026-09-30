import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/database/app_database.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/notifications/notification_scheduler.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../data/backup_service.dart';
import '../domain/reminder_timing_options.dart';
import '../domain/theme_mode_option.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تنظیمات')),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final loaded = state as SettingsLoaded;
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            children: [
              const _SectionHeader('ظاهر برنامه'),
              _AppearanceSection(current: loaded.themeMode),
              const _SectionHeader('اعلان‌ها'),
              _NotificationsSection(settings: loaded.settings),
              const _SectionHeader('تنظیمات عمومی'),
              const _GeneralSection(),
              const _SectionHeader('پشتیبان‌گیری'),
              const _BackupSection(),
              const _SectionHeader('ارتباط و همکاری'),
              const _SupportSection(),
              const _SectionHeader('اطلاعات'),
              const _AboutSection(),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _AppearanceSection extends StatelessWidget {
  const _AppearanceSection({required this.current});

  final ThemeModeOption current;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<ThemeModeOption>(
      groupValue: current,
      onChanged: (value) {
        if (value != null) {
          context.read<SettingsCubit>().setThemeMode(value);
        }
      },
      child: Column(
        children: [
          for (final option in ThemeModeOption.values)
            RadioListTile<ThemeModeOption>(
              title: Text(option.label),
              value: option,
            ),
        ],
      ),
    );
  }
}

class _NotificationsSection extends StatelessWidget {
  const _NotificationsSection({required this.settings});

  final AppSetting settings;

  @override
  Widget build(BuildContext context) {
    final enabled = settings.notificationsEnabled;
    final serviceDays = settings.serviceReminderDaysBefore;
    final documentDays = settings.documentReminderDaysBefore;

    return Column(
      children: [
        SwitchListTile(
          title: const Text('فعال بودن اعلان‌ها'),
          subtitle: const Text('یادآوری سرویس و انقضای مدارک'),
          value: enabled,
          onChanged: (value) async {
            try {
              if (value &&
                  !await getIt<NotificationService>().requestPermission()) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'برای دریافت یادآوری، دسترسی اعلان‌های خودرویار را در تنظیمات گوشی فعال کنید.',
                    ),
                  ),
                );
                return;
              }
              if (context.mounted) {
                await context.read<SettingsCubit>().setNotificationsEnabled(
                  value,
                );
              }
            } catch (_) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'تغییر تنظیمات اعلان انجام نشد. دوباره تلاش کنید.',
                    ),
                  ),
                );
              }
            }
          },
        ),
        ListTile(
          enabled: enabled,
          title: const Text('یادآوری سرویس'),
          subtitle: Text(reminderTimingLabel(serviceDays)),
          // Icons.chevron_left has IconData.matchTextDirection: true, so
          // Flutter auto-mirrors it under RTL — using the "left" variant
          // here would actually render pointing right. chevron_right is
          // the one that ends up pointing left (the correct "reveal more"
          // direction for RTL) once auto-mirrored.
          trailing: const Icon(Icons.chevron_right),
          onTap: enabled
              ? () => _pickReminderDays(
                  context,
                  current: serviceDays,
                  onSelected: (days) => context
                      .read<SettingsCubit>()
                      .setServiceReminderDaysBefore(days),
                )
              : null,
        ),
        ListTile(
          enabled: enabled,
          title: const Text('یادآوری انقضای مدارک'),
          subtitle: Text(reminderTimingLabel(documentDays)),
          // Icons.chevron_left has IconData.matchTextDirection: true, so
          // Flutter auto-mirrors it under RTL — using the "left" variant
          // here would actually render pointing right. chevron_right is
          // the one that ends up pointing left (the correct "reveal more"
          // direction for RTL) once auto-mirrored.
          trailing: const Icon(Icons.chevron_right),
          onTap: enabled
              ? () => _pickReminderDays(
                  context,
                  current: documentDays,
                  onSelected: (days) => context
                      .read<SettingsCubit>()
                      .setDocumentReminderDaysBefore(days),
                )
              : null,
        ),
      ],
    );
  }

  Future<void> _pickReminderDays(
    BuildContext context, {
    required int current,
    required ValueChanged<int> onSelected,
  }) async {
    final selected = await showModalBottomSheet<int>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: RadioGroup<int>(
          groupValue: current,
          onChanged: (value) => Navigator.pop(sheetContext, value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final days in reminderTimingOptionsDays)
                RadioListTile<int>(
                  title: Text(reminderTimingLabel(days)),
                  value: days,
                ),
            ],
          ),
        ),
      ),
    );
    if (selected != null) onSelected(selected);
  }
}

class _GeneralSection extends StatelessWidget {
  const _GeneralSection();

  @override
  Widget build(BuildContext context) {
    // Distance/fuel unit are stored in AppSettings but no other screen in
    // the app currently reads them to change displayed units, so these are
    // shown as informational-only rows rather than a functional selector —
    // implementing a toggle that doesn't actually change anything would
    // violate the "don't claim a feature works unless it's true" rule.
    return const Column(
      children: [
        ListTile(title: Text('واحد فاصله'), subtitle: Text('کیلومتر')),
        ListTile(title: Text('واحد سوخت'), subtitle: Text('لیتر')),
      ],
    );
  }
}

class _BackupSection extends StatefulWidget {
  const _BackupSection();

  @override
  State<_BackupSection> createState() => _BackupSectionState();
}

class _BackupSectionState extends State<_BackupSection> {
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          enabled: !_busy,
          leading: const Icon(Icons.backup_outlined),
          title: const Text('پشتیبان‌گیری از اطلاعات'),
          subtitle: const Text(
            'ذخیره اطلاعات و عکس‌ها در یک فایل برای انتقال به گوشی دیگر',
          ),
          onTap: () => _createBackup(context),
        ),
        ListTile(
          enabled: !_busy,
          leading: const Icon(Icons.restore_outlined),
          title: const Text('بازیابی از فایل پشتیبان'),
          subtitle: const Text(
            'جایگزینی اطلاعات فعلی با یک فایل پشتیبان — این کار اطلاعات فعلی را حذف می‌کند',
          ),
          onTap: () => _restoreFromBackup(context),
        ),
      ],
    );
  }

  Future<void> _createBackup(BuildContext context) async {
    setState(() => _busy = true);
    try {
      final backupFile = await getIt<BackupService>().createBackup();
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(backupFile.path)],
          text: 'فایل پشتیبان خودرویار',
        ),
      );
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ساخت فایل پشتیبان انجام نشد.')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _restoreFromBackup(BuildContext context) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final picked = await FilePicker.pickFile();
      if (picked?.path == null) return;
      final pickedFile = File(picked!.path!);

      if (!context.mounted) return;
      final confirmed = await _confirmRestore(context);
      if (confirmed != true) return;

      final backupService = getIt<BackupService>();
      if (!await backupService.looksLikeSqliteDatabase(pickedFile)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('این فایل یک فایل پشتیبان معتبر نیست.'),
            ),
          );
        }
        return;
      }

      await backupService.restoreFromFile(pickedFile);
      await getIt<NotificationScheduler>().rescheduleAll();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('اطلاعات و عکس‌های موجود با موفقیت بازیابی شدند.'),
          ),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('بازیابی انجام نشد.')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<bool?> _confirmRestore(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('بازیابی اطلاعات'),
        content: const Text(
          'با این کار تمام اطلاعات فعلی برنامه (خودروها، سرویس‌ها، سوخت‌گیری‌ها، '
          'هزینه‌ها و مدارک) حذف و با محتوای فایل پشتیبان جایگزین می‌شود. این '
          'عملیات قابل بازگشت نیست. آیا مطمئن هستید؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('انصراف'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('بازیابی'),
          ),
        ],
      ),
    );
  }
}

class _SupportSection extends StatelessWidget {
  const _SupportSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.bug_report_outlined),
          title: const Text('ارسال گزارش خطا'),
          subtitle: const Text('مشکلی در برنامه دیده‌اید؟ برای ما بنویسید'),
          // Icons.chevron_left has IconData.matchTextDirection: true, so
          // Flutter auto-mirrors it under RTL — using the "left" variant
          // here would actually render pointing right. chevron_right is
          // the one that ends up pointing left (the correct "reveal more"
          // direction for RTL) once auto-mirrored.
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(AppRoutes.errorReport),
        ),
        ListTile(
          leading: const Icon(Icons.campaign_outlined),
          title: const Text('درخواست تبلیغ'),
          subtitle: const Text('معرفی کسب‌وکار شما در اپ‌های پارسیک'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(AppRoutes.advertisingRequest),
        ),
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            final version = snapshot.data?.version;
            return ListTile(
              title: const Text('نسخه برنامه'),
              subtitle: Text(version ?? 'در حال بارگذاری...'),
            );
          },
        ),
        ListTile(
          title: const Text('حریم خصوصی'),
          // Icons.chevron_left has IconData.matchTextDirection: true, so
          // Flutter auto-mirrors it under RTL — using the "left" variant
          // here would actually render pointing right. chevron_right is
          // the one that ends up pointing left (the correct "reveal more"
          // direction for RTL) once auto-mirrored.
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(AppRoutes.privacy),
        ),
        ListTile(
          title: const Text('معرفی به دوستان'),
          trailing: const Icon(Icons.share_outlined),
          onTap: () {
            SharePlus.instance.share(
              ShareParams(
                text:
                    'خودرویار: دستیار مدیریت خودرو، رایگان و بدون نیاز به اینترنت.',
              ),
            );
          },
        ),
      ],
    );
  }
}
