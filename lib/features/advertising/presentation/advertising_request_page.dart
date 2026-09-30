import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_spacing.dart';
import '../data/ads_exceptions.dart';
import '../data/app_support_gateway.dart';
import '../domain/support_validators.dart';

/// Below this width, province/city stack vertically instead of sitting
/// side by side.
const double _wideLayoutBreakpoint = 480;

class AdvertisingRequestPage extends StatefulWidget {
  const AdvertisingRequestPage({super.key});

  @override
  State<AdvertisingRequestPage> createState() => _AdvertisingRequestPageState();
}

class _AdvertisingRequestPageState extends State<AdvertisingRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _provinceController = TextEditingController();
  final _cityController = TextEditingController();
  final _detailsController = TextEditingController();
  bool _submitting = false;

  AppSupportGateway get _gateway => getIt<AppSupportGateway>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _provinceController.dispose();
    _cityController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _submitting = true);
    try {
      await _gateway.submitAdvertisingRequest(
        fullName: _fullNameController.text,
        phoneNumber: _phoneController.text,
        province: _provinceController.text,
        city: _cityController.text,
        details: _detailsController.text,
      );
      if (!mounted) return;
      // Reset before the (user-dismissed) success dialog, not in a
      // `finally` after it — the network call already finished
      // successfully, so the button shouldn't keep showing a spinner while
      // waiting on something the user, not the network, now controls.
      setState(() => _submitting = false);
      _fullNameController.clear();
      _phoneController.clear();
      _provinceController.clear();
      _cityController.clear();
      _detailsController.clear();
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('درخواست ثبت شد'),
          content: const Text(
            'درخواست شما ثبت شد. کارشناسان تبلیغات پارسیک با شماره ثبت‌شده '
            'با شما تماس می‌گیرند.',
          ),
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
          : 'ثبت درخواست انجام نشد؛ دوباره تلاش کنید.';
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
      appBar: AppBar(title: const Text('درخواست تبلیغ')),
      body: !_gateway.isConfigured
          ? const _NotConfiguredNotice()
          : Form(
              key: _formKey,
              child: ListView(
                padding: AppSpacing.page(context),
                children: [
                  TextFormField(
                    key: const ValueKey('advertising_full_name'),
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'نام و نام خانوادگی *',
                    ),
                    maxLength: 160,
                    autofillHints: const [AutofillHints.name],
                    validator: SupportValidators.fullName,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    key: const ValueKey('advertising_phone'),
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'شماره تماس *',
                    ),
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    maxLength: 20,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9۰-۹٠-٩+\-\s()]'),
                      ),
                    ],
                    autofillHints: const [AutofillHints.telephoneNumber],
                    validator: SupportValidators.phoneNumber,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final province = TextFormField(
                        key: const ValueKey('advertising_province'),
                        controller: _provinceController,
                        decoration: const InputDecoration(labelText: 'استان *'),
                        maxLength: 100,
                        validator: SupportValidators.province,
                      );
                      final city = TextFormField(
                        key: const ValueKey('advertising_city'),
                        controller: _cityController,
                        decoration: const InputDecoration(labelText: 'شهر *'),
                        maxLength: 100,
                        validator: SupportValidators.city,
                      );
                      if (constraints.maxWidth >= _wideLayoutBreakpoint) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: province),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(child: city),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          province,
                          const SizedBox(height: AppSpacing.md),
                          city,
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    key: const ValueKey('advertising_details'),
                    controller: _detailsController,
                    decoration: const InputDecoration(
                      labelText: 'توضیحات تکمیلی',
                      alignLabelWithHint: true,
                    ),
                    minLines: 3,
                    maxLines: 6,
                    maxLength: 4000,
                    validator: SupportValidators.details,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'اطلاعات شما فقط برای پیگیری همین درخواست استفاده می‌شود.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton(
                    key: const ValueKey('submit_advertising_request'),
                    onPressed: _submitting ? null : _submit,
                    child: _submitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('ثبت درخواست'),
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
