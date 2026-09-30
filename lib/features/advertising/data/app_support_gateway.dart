import '../domain/submission_receipt.dart';

/// Everything the error-report and advertising-request forms need. Kept as
/// an interface so form widget tests can supply a fake instead of hitting
/// the network.
abstract interface class AppSupportGateway {
  bool get isConfigured;

  Future<SubmissionReceipt> submitErrorReport({required String description});

  Future<SubmissionReceipt> submitAdvertisingRequest({
    required String fullName,
    required String phoneNumber,
    required String province,
    required String city,
    required String details,
  });

  void close();
}
