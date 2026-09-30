import '../domain/ad_banner.dart';

/// A single mutable-shape state (rather than this codebase's usual
/// sealed-per-status classes) because several of these fields are
/// genuinely orthogonal — e.g. a background [refreshing] can be true while
/// [banners] still holds the previous successful result, and
/// [errorMessage] only ever describes the *latest* fetch attempt, not
/// whether banners exist.
class AdBannerState {
  const AdBannerState({
    this.banners = const [],
    this.initialLoading = true,
    this.refreshing = false,
    this.currentIndex = 0,
    this.errorMessage,
    this.lastSuccessfulFetch,
    this.isOpeningLink = false,
  });

  final List<AdBanner> banners;
  final bool initialLoading;
  final bool refreshing;
  final int currentIndex;
  final String? errorMessage;
  final DateTime? lastSuccessfulFetch;
  final bool isOpeningLink;

  static const Duration cacheTtl = Duration(minutes: 20);

  bool get isCacheFresh =>
      lastSuccessfulFetch != null &&
      DateTime.now().difference(lastSuccessfulFetch!) < cacheTtl;

  AdBannerState copyWith({
    List<AdBanner>? banners,
    bool? initialLoading,
    bool? refreshing,
    int? currentIndex,
    Object? errorMessage = _unset,
    Object? lastSuccessfulFetch = _unset,
    bool? isOpeningLink,
  }) {
    return AdBannerState(
      banners: banners ?? this.banners,
      initialLoading: initialLoading ?? this.initialLoading,
      refreshing: refreshing ?? this.refreshing,
      currentIndex: currentIndex ?? this.currentIndex,
      errorMessage: errorMessage == _unset
          ? this.errorMessage
          : errorMessage as String?,
      lastSuccessfulFetch: lastSuccessfulFetch == _unset
          ? this.lastSuccessfulFetch
          : lastSuccessfulFetch as DateTime?,
      isOpeningLink: isOpeningLink ?? this.isOpeningLink,
    );
  }
}

/// Sentinel distinguishing "leave unchanged" from "explicitly set to null"
/// for nullable [AdBannerState.copyWith] parameters.
const Object _unset = Object();
