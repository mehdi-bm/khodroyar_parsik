import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/advertising_gateway.dart';
import '../domain/ad_banner.dart';
import 'ad_banner_state.dart';

/// Drives the home-page ad banner carousel: fetches active banners, caches
/// a successful result for [AdBannerState.cacheTtl], and de-duplicates
/// concurrent refresh/click attempts.
class AdBannerCubit extends Cubit<AdBannerState> {
  AdBannerCubit(this._gateway) : super(const AdBannerState());

  final AdvertisingGateway _gateway;
  bool _fetchInFlight = false;

  Future<void> loadInitial() => refresh();

  /// Fetches banners unless a fetch is already in flight, or the cached
  /// result is still fresh and [force] wasn't requested (e.g. app resumed
  /// but the 20-minute cache hasn't expired yet).
  Future<void> refresh({bool force = false}) async {
    if (!_gateway.isConfigured) {
      emit(state.copyWith(initialLoading: false, refreshing: false));
      return;
    }
    if (_fetchInFlight) return;
    if (!force && state.isCacheFresh) return;

    _fetchInFlight = true;
    final isFirstLoad = state.lastSuccessfulFetch == null;
    emit(
      state.copyWith(
        initialLoading: isFirstLoad,
        refreshing: !isFirstLoad,
        errorMessage: null,
      ),
    );
    try {
      final banners = await _gateway.fetchBanners();
      final nextIndex = banners.isEmpty
          ? 0
          : state.currentIndex % banners.length;
      emit(
        state.copyWith(
          banners: banners,
          initialLoading: false,
          refreshing: false,
          currentIndex: nextIndex,
          lastSuccessfulFetch: DateTime.now(),
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          initialLoading: false,
          refreshing: false,
          errorMessage: 'دریافت تبلیغات ناموفق بود',
        ),
      );
    } finally {
      _fetchInFlight = false;
    }
  }

  void setPage(int index) {
    if (index == state.currentIndex) return;
    emit(state.copyWith(currentIndex: index));
  }

  /// Registers the click for [banner] and returns the URL the caller
  /// should open. Repeated taps while one is already in flight are
  /// ignored (returns `null`). If click registration fails, falls back to
  /// the banner's own [AdBanner.destinationUrl] so a network hiccup
  /// doesn't break the user's tap.
  Future<Uri?> openBanner(
    AdBanner banner, {
    required String externalUserId,
  }) async {
    if (state.isOpeningLink) return null;
    emit(state.copyWith(isOpeningLink: true));
    try {
      return await _gateway.registerClick(
        bannerId: banner.bannerId,
        externalUserId: externalUserId,
      );
    } catch (_) {
      return banner.destinationUrl;
    } finally {
      emit(state.copyWith(isOpeningLink: false));
    }
  }
}
