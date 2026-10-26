import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_spacing.dart';
import '../domain/parsik_app.dart';

/// "سایر اپلیکیشن‌های کاربردی" — the rest of the Parsik suite, each linking
/// straight to its Cafe Bazaar page. Mirrors the same page in the other
/// Parsik apps.
class OtherAppsPage extends StatelessWidget {
  const OtherAppsPage({super.key});

  Future<void> _openInBazaar(BuildContext context, ParsikApp app) async {
    // Prefer the Bazaar client; fall back to the web page on devices
    // without it (launchUrl returns false, or throws, when nothing can
    // handle the bazaar:// scheme).
    for (final uri in [app.bazaarAppUri, app.bazaarWebUri]) {
      try {
        if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          return;
        }
      } catch (_) {
        // Try the next option; a message is shown if none works.
      }
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('باز کردن صفحه برنامه در کافه‌بازار ممکن نشد.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('سایر اپلیکیشن‌های کاربردی')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columnCount = constraints.maxWidth >= 760 ? 2 : 1;

          return CustomScrollView(
            key: const Key('other_apps_scroll_view'),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                sliver: SliverToBoxAdapter(
                  child: Card(
                    color: colors.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.apps_rounded,
                            size: 32,
                            color: colors.onPrimaryContainer,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'محصولات دیگر پارسیک',
                                  style: textTheme.titleMedium?.copyWith(
                                    color: colors.onPrimaryContainer,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  'برای مشاهده جزئیات و نصب هر برنامه، آن را انتخاب کنید.',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colors.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.xl + MediaQuery.paddingOf(context).bottom,
                ),
                sliver: SliverGrid(
                  key: const Key('other_apps_grid'),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final app = kOtherParsikApps[index];
                    return _AppCard(
                      app: app,
                      onTap: () => _openInBazaar(context, app),
                    );
                  }, childCount: kOtherParsikApps.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnCount,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    // Room for a two-line name under larger font scales.
                    mainAxisExtent:
                        32 + MediaQuery.textScalerOf(context).scale(72),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AppCard extends StatelessWidget {
  const _AppCard({required this.app, required this.onTap});

  final ParsikApp app;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: Key('other_app_${app.packageName}'),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: Image.asset(
                  app.iconAsset,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  semanticLabel: 'آیکون ${app.name}',
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 64,
                    height: 64,
                    color: theme.colorScheme.surfaceContainerHigh,
                    child: Icon(
                      Icons.apps_rounded,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'مشاهده در کافه‌بازار',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                Icons.open_in_new_rounded,
                size: 20,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
