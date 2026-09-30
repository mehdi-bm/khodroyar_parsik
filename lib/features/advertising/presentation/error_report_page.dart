import 'package:flutter/material.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../data/ads_exceptions.dart';
import '../data/app_support_gateway.dart';
import '../domain/support_validators.dart';

class ErrorReportPage extends StatefulWidget {
  const ErrorReportPage({super.key});

  @override
  State<ErrorReportPage> createState() => _ErrorReportPageState();
}

class _ErrorReportPageState extends State<ErrorReportPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  bool _submitting = false;

  AppSupportGateway get _gateway => getIt<AppSupportGateway>();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _submitting = true);
    try {
      await _gateway.submitErrorReport(
        description: _descriptionController.text,
      );
      if (!mounted) return;
      // Reset before the (user-dismissed) success dialog, not in a
      // `finally` after it — the network call already finished
      // successfully, so the button shouldn't keep showing a spinner while
      // waiting on something the user, not the network, now controls.
      setState(() => _submitting = false);
      _descriptionController.clear();
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('ارسال شد'),
          content: const Text('گزارش شما ثبت شد؛ سپاس از همراهی شما.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('باشه'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      final message = e is AdsApiException
          ? e.message
          : 'ارسال گزارش انجام نشد؛ دوباره تلاش کنید.';
      setState(() => _submitting = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('ارسال گزارش خطا')),
      body: !_gateway.isConfigured
          ? const _NotConfiguredNotice()
          : Form(
              key: _formKey,
              child: ListView(
                padding: AppSpacing.page(context),
                children: [
                  AppCard(
                    child: Text(
                      'اگر با مشکلی در برنامه مواجه شدید، لطفاً توضیح دهید در '
                      'کدام صفحه بودید، چه کاری انجام دادید، نتیجه‌ای که '
                      'گرفتید چه بود و انتظار داشتید چه اتفاقی بیفتد.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextFormField(
                    key: const ValueKey('error_description'),
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'شرح خطا *',
                      alignLabelWithHint: true,
                    ),
                    minLines: 5,
                    maxLines: 10,
                    maxLength: 4000,
                    validator: SupportValidators.errorDescription,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton(
                    key: const ValueKey('submit_error_report'),
                    onPressed: _submitting ? null : _submit,
                    child: _submitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('ارسال گزارش'),
                  ),
                ],
              ),
            ),
    );
  }
}

class _NotConfiguredNotice extends StatelessWidget {
  const _NotConfiguredNotice();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Text(
          'این قابلیت در حال حاضر در دسترس نیست.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
