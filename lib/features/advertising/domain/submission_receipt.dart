/// Confirmation returned by the error-report / advertising-request
/// endpoints on success (HTTP 201).
class SubmissionReceipt {
  const SubmissionReceipt({
    required this.id,
    required this.type,
    required this.status,
  });

  final String id;
  final String type;
  final String status;

  /// `null` if the response is missing a usable `id` — the caller must
  /// treat that as a failure, not a silent success.
  static SubmissionReceipt? tryParse(Map<String, dynamic> json) {
    final id = json['id'];
    if (id is! String || id.trim().isEmpty) return null;
    return SubmissionReceipt(
      id: id.trim(),
      type: (json['type'] as String?)?.trim() ?? '',
      status: (json['status'] as String?)?.trim() ?? '',
    );
  }
}
