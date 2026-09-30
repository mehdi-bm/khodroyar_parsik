import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../cubit/ad_banner_cubit.dart';
import '../../cubit/ad_banner_state.dart';
import '../../data/install_id_repository.dart';
import '../../domain/ad_banner.dart';

const double _bannerHeight = 160;
const Duration _autoSlideInterval = Duration(seconds: 4);
const Duration _autoSlideAnimationDuration = Duration(milliseconds: 450);

/// The home-page "بنر تبلیغاتی پارسیک" carousel. Renders nothing at all
/// (not even empty space) when ads aren't configured or there's no active
/// campaign — this widget must never show placeholder/demo content.
class AdBannerCarousel extends StatefulWidget {
  const AdBannerCarousel({super.key});

  @override
  State<AdBannerCarousel> createState() => _AdBannerCarouselState();
}

class _AdBannerCarouselState extends State<AdBannerCarousel>
    with WidgetsBindingObserver {
  late final PageController _pageController;
  Timer? _autoSlideTimer;
  bool _userDragging = false;
  int _bannerCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pageController = PageController();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;
    if (state == AppLifecycleState.resumed) {
      context.read<AdBannerCubit>().refresh();
      _startAutoSlide();
    } else {
      _stopAutoSlide();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopAutoSlide();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    if (_bannerCount < 2 || _userDragging) return;
    _autoSlideTimer = Timer.periodic(_autoSlideInterval, (_) {
      if (!_pageController.hasClients || _bannerCount == 0) return;
      final current = _pageController.page?.round() ?? 0;
      _pageController.animateToPage(
        (current + 1) % _bannerCount,
        duration: _autoSlideAnimationDuration,
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = null;
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
        _bannerCount = state.banners.length;

        if (state.initialLoading) {
          return const Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              0,
            ),
            child: _LoadingPlaceholder(),
          );
        }

        if (state.banners.isEmpty) {
          if (state.errorMessage != null) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                0,
              ),
              child: _ErrorPlaceholder(
                message: state.errorMessage!,
                onRetry: () =>
                    context.read<AdBannerCubit>().refresh(force: true),
              ),
            );
          }
          return const SizedBox.shrink();
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted &&
              (_autoSlideTimer == null || !_autoSlideTimer!.isActive)) {
            _startAutoSlide();
          }
        });

        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            0,
          ),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification &&
                  notification.dragDetails != null) {
                _userDragging = true;
                _stopAutoSlide();
              } else if (notification is ScrollEndNotification) {
                _userDragging = false;
                _startAutoSlide();
              }
              return false;
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: SizedBox(
                height: _bannerHeight,
                child: Stack(
                  children: [
                    PageView.builder(
                      key: const ValueKey('ad_banner_page_view'),
                      controller: _pageController,
                      itemCount: state.banners.length,
                      onPageChanged: (index) =>
                          context.read<AdBannerCubit>().setPage(index),
                      itemBuilder: (context, index) {
                        final banner = state.banners[index];
                        return _BannerItem(
                          key: ValueKey('ad_banner_${banner.bannerId}'),
                          banner: banner,
                          isOpeningLink: state.isOpeningLink,
                          onTap: () => _openBanner(context, banner),
                        );
                      },
                    ),
                    const Positioned(
                      top: AppSpacing.sm,
                      right: AppSpacing.sm,
                      child: _AdLabel(),
                    ),
                    if (state.banners.length > 1)
                      Positioned(
                        bottom: AppSpacing.xs,
                        left: 0,
                        right: 0,
                        child: _PageIndicator(
                          count: state.banners.length,
                          index: state.currentIndex
                              .clamp(0, state.banners.length - 1)
                              .toInt(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BannerItem extends StatelessWidget {
  const _BannerItem({
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
      child: InkWell(
        onTap: isOpeningLink ? null : onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              banner.imageUrl.toString(),
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(color: theme.colorScheme.surfaceContainerHigh);
              },
              errorBuilder: (context, error, stackTrace) => Container(
                color: theme.colorScheme.surfaceContainerHigh,
                alignment: Alignment.center,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 32,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.72),
                    ],
                  ),
                ),
                child: Padding(
                  // Extra bottom padding (vs. the AppSpacing.sm used on the
                  // other sides) reserves room for the page-indicator dots
                  // drawn by the parent Stack, which sit right at the
                  // bottom edge whenever there's more than one banner —
                  // without it, the dots overlap the subtitle text.
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.xl,
                    AppSpacing.md,
                    AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        banner.bannerTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitle.isNotEmpty)
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: AppSpacing.sm,
              top: AppSpacing.sm,
              child: Icon(
                Icons.open_in_new,
                size: 16,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
            if (isOpeningLink)
              ColoredBox(
                color: Colors.black.withValues(alpha: 0.25),
                child: const Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AdLabel extends StatelessWidget {
  const _AdLabel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: const Text(
        'تبلیغ',
        style: TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: i == index ? 16 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: (i == index ? Colors.white : Colors.white70).withValues(
                alpha: i == index ? 1 : 0.6,
              ),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
          ),
      ],
    );
  }
}

class _LoadingPlaceholder extends StatefulWidget {
  const _LoadingPlaceholder();

  @override
  State<_LoadingPlaceholder> createState() => _LoadingPlaceholderState();
}

class _LoadingPlaceholderState extends State<_LoadingPlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHigh;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          key: const ValueKey('ad_loading_placeholder'),
          height: _bannerHeight,
          decoration: BoxDecoration(
            color: baseColor.withValues(alpha: 0.5 + _controller.value * 0.5),
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        );
      },
    );
  }
}

class _ErrorPlaceholder extends StatelessWidget {
  const _ErrorPlaceholder({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: const ValueKey('ad_load_error'),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          Expanded(child: Text(message, style: theme.textTheme.bodySmall)),
          TextButton(
            key: const ValueKey('ad_retry_button'),
            onPressed: onRetry,
            child: const Text('تلاش مجدد'),
          ),
        ],
      ),
    );
  }
}
