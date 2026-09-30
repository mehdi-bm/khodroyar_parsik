import 'package:caryar/features/advertising/data/advertising_gateway.dart';
import 'package:caryar/features/advertising/domain/ad_banner.dart';

/// An in-memory [AdvertisingGateway] double for cubit/widget tests — never
/// touches the network. Configure [bannersToReturn]/[fetchError] to control
/// [fetchBanners], and [clickError]/[clickDestination] to control
/// [registerClick].
class FakeAdvertisingGateway implements AdvertisingGateway {
  FakeAdvertisingGateway({this.configured = true});

  bool configured;
  List<AdBanner> bannersToReturn = const [];
  Object? fetchError;
  Future<void> Function()? beforeFetchReturns;
  int fetchCallCount = 0;

  Uri? clickDestination;
  Object? clickError;
  final List<String> registeredClickBannerIds = [];

  @override
  bool get isConfigured => configured;

  @override
  Uri resolvePublicUrl(String value) => Uri.parse(value);

  @override
  Future<List<AdBanner>> fetchBanners() async {
    fetchCallCount++;
    if (beforeFetchReturns != null) await beforeFetchReturns!();
    if (fetchError != null) throw fetchError!;
    return bannersToReturn;
  }

  @override
  Future<Uri> registerClick({
    required String bannerId,
    required String externalUserId,
  }) async {
    registeredClickBannerIds.add(bannerId);
    if (clickError != null) throw clickError!;
    return clickDestination ?? Uri.parse('https://example.com/fallback');
  }

  @override
  void close() {}
}
