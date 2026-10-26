import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../cubit/ad_banner_cubit.dart';
import '../../cubit/ad_banner_state.dart';
import '../../data/install_id_repository.dart';
import '../../domain/ad_banner.dart';

const double _stripHeight = 64;
const double _thumbnailWidth = 96;

/// The home-page Parsik ad, shown as a slim static strip pinned to the
/// bottom of the page so it stays visible without competing with the
/// app's own content. Deliberately motionless: no auto-slide, no pulsing
/// loading placeholder. When several banners are active, the next one is
/// shown each time the app returns to the foreground instead.
///
/// Renders nothing at all (not even empty space) while loading, on error,
/// or when ads aren't configured or there's no active campaign — this
/// widget must never show placeholder/demo content.
class AdBannerStrip extends StatefulWidget {
  const AdBannerStrip({super.key});

  @override
  State<AdBannerStrip> createState() => _AdBannerStripState();
}

class _AdBannerStripState extends State<AdBannerStrip>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted || state != AppLifecycleState.resumed) return;
    final cubit = context.read<AdBannerCubit>();
    final count = cubit.state.banners.length;
    if (count > 1) cubit.setPage((cubit.state.currentIndex + 1) % count);
    cubit.refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _openBanner(BuildContext context, AdBanner banner) async {
    final externalUserId = await getIt<InstallIdRepository>().getOrCreate();
    if (!context.mounted) return;
    final target = await context.read<AdBannerCubit>().openBanner(
      banner,
      externalUserId: externalUserId,
    );
    if (target == null) return;
    // Defense in depth — resolvePublicUrl already restricts schemes when
    // the URL was parsed, but never hand an unvalidated scheme to the OS.
    final schemeOk = target.scheme == 'https' || target.scheme == 'http';
    if (!schemeOk) return;
    try {
      await launchUrl(target, mode: LaunchMode.externalApplication);
    } catch (_) {
      // No browser/handler available (or no url_launcher platform
      // implementation, e.g. under test) — the tap itself, and the click
      // registration above, already succeeded; nothing more to do.
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdBannerCubit, AdBannerState>(
      builder: (context, state) {
        if (state.banners.isEmpty) return const SizedBox.shrink();

        final banner = state.banners[state.currentIndex % state.banners.length];
        return _StripItem(
          key: ValueKey('ad_banner_${banner.bannerId}'),
          banner: banner,
          isOpeningLink: state.isOpeningLink,
          onTap: () => _openBanner(context, banner),
        );
      },
    );
  }
}

class _StripItem extends StatelessWidget {
  const _StripItem({
    super.key,
    required this.banner,
    required this.isOpeningLink,
    required this.onTap,
  });

  final AdBanner banner;
  final bool isOpeningLink;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitle = [
      banner.campaignTitle,
      banner.sectionName,
    ].where((s) => s.isNotEmpty).join(' · ');

    return Semantics(
      label: 'تبلیغ، ${banner.bannerTitle}',
      button: true,
      child: Material(
        color: theme.colorScheme.surfaceContainerLow,
        shape: Border(top: BorderSide(color: theme.colorScheme.outlineVariant)),
        child: InkWell(
          onTap: isOpeningLink ? null : onTap,
          child: SizedBox(
            height: _stripHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    child: SizedBox(
                      width: _thumbnailWidth,
                      height: double.infinity,
                      child: Image.network(
                        banner.imageUrl.toString(),
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return ColoredBox(
                            color: theme.colorScheme.surfaceContainerHigh,
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            ColoredBox(
                              color: theme.colorScheme.surfaceContainerHigh,
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: theme.colorScheme.onSurfaceVariant,
                                size: 20,
                              ),
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
                          banner.bannerTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (subtitle.isNotEmpty)
                          Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const _AdLabel(),
                      const SizedBox(height: AppSpacing.xs),
                      if (isOpeningLink)
                        const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else
                        Icon(
                          Icons.open_in_new,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AdLabel extends StatelessWidget {
  const _AdLabel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        'تبلیغ',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontSize: 10,
        ),
      ),
    );
  }
}
