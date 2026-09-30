import 'package:caryar/features/advertising/data/app_support_gateway.dart';
import 'package:caryar/features/advertising/domain/submission_receipt.dart';

/// An in-memory [AppSupportGateway] double for widget tests — never
/// touches the network.
class FakeAppSupportGateway implements AppSupportGateway {
  FakeAppSupportGateway({this.configured = true});

  bool configured;
  Object? errorReportError;
  Object? advertisingRequestError;

  /// Lets a test hold the call pending (e.g. via a [Completer]) to
  /// reliably observe the in-flight/submitting UI state before letting it
  /// resolve — without this, the fake resolves on the next microtask,
  /// too fast for a single `pump()` to ever see the loading state.
  Future<void> Function()? beforeReturns;

  final List<String> errorReportDescriptions = [];
  final List<Map<String, String>> advertisingRequests = [];

  @override
  bool get isConfigured => configured;

  @override
  Future<SubmissionReceipt> submitErrorReport({
    required String description,
  }) async {
    errorReportDescriptions.add(description);
    if (beforeReturns != null) await beforeReturns!();
    if (errorReportError != null) throw errorReportError!;
    return const SubmissionReceipt(
      id: 'r1',
      type: 'ErrorReport',
      status: 'New',
    );
  }

  @override
  Future<SubmissionReceipt> submitAdvertisingRequest({
    required String fullName,
    required String phoneNumber,
    required String province,
    required String city,
    required String details,
  }) async {
    advertisingRequests.add({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'province': province,
      'city': city,
      'details': details,
    });
    if (beforeReturns != null) await beforeReturns!();
    if (advertisingRequestError != null) throw advertisingRequestError!;
    return const SubmissionReceipt(
      id: 'r2',
      type: 'AdvertisingRequest',
      status: 'New',
    );
  }

  @override
  void close() {}
}
