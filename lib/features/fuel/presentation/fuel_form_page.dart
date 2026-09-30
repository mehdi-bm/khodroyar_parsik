import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/grouped_number_input.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/utils/persian_date.dart';
import '../../../core/widgets/date_field.dart';
import '../../../core/widgets/form_load_error.dart';
import '../cubit/fuel_form_cubit.dart';
import '../cubit/fuel_form_state.dart';
import '../data/fuel_repository.dart';
import '../domain/fuel_validators.dart';

/// Add/edit fuel record form for [vehicleId]. In edit mode, [recordId] is
/// provided and the existing record is loaded first.
class FuelFormPage extends StatefulWidget {
  const FuelFormPage({super.key, required this.vehicleId, this.recordId});

  final int vehicleId;
  final int? recordId;

  @override
  State<FuelFormPage> createState() => _FuelFormPageState();
}

class _FuelFormPageState extends State<FuelFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _mileageController = TextEditingController();
  final _fuelAmountController = TextEditingController();
  final _totalCostController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _date = DateTime.now();
  bool _isFullTank = true;
  bool _loading = true;
  int? _previousMileage;
  int? _nextMileage;
  bool _loadFailed = false;

  bool get _isEditing => widget.recordId != null;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final repository = getIt<FuelRepository>();
      final records = await repository.getAllForVehicle(widget.vehicleId);
      if (!mounted) return;

      // Unlike the maintenance form, mileage isn't pre-filled here — it must
      // be strictly greater than the previous fill-up (see
      // FuelValidators.mileage), so pre-filling with that exact value would
      // always start the form in an invalid state.
      // Editing an older fill-up must not require an odometer greater than
      // every newer record. Its existing position is validated separately.
      final edited = _isEditing
          ? await repository.getById(widget.recordId!)
          : null;
      if (!mounted) return;
      final otherRecords = _isEditing
          ? records.where((r) => edited != null && r.mileage < edited.mileage)
          : records;
      if (_isEditing && edited == null) {
        _loadFailed = true;
        return;
      }
      if (edited != null) {
        final later = records.where((r) => r.mileage > edited.mileage);
        if (later.isNotEmpty) {
          _nextMileage = later
              .map((r) => r.mileage)
              .reduce((a, b) => a < b ? a : b);
        }
      }
      if (otherRecords.isNotEmpty) {
        _previousMileage = otherRecords
            .map((r) => r.mileage)
            .reduce((a, b) => a > b ? a : b);
      }

      if (_isEditing) {
        final record = edited;
        if (record != null) {
          _date = record.date;
          _mileageController.text = formatGroupedDigits('${record.mileage}');
          _fuelAmountController.text = record.fuelAmountLiters.toString();
          _totalCostController.text = formatGroupedDigits(
            '${record.totalCost}',
          );
          _isFullTank = record.isFullTank;
          _notesController.text = record.notes ?? '';
        }
      }
    } catch (_) {
      _loadFailed = true;
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _mileageController.dispose();
    _fuelAmountController.dispose();
    _totalCostController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await pickJalaliDate(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (mounted && picked != null) setState(() => _date = picked);
  }

  void _submit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<FuelFormCubit>().submit(
      id: widget.recordId,
      vehicleId: widget.vehicleId,
      date: _date,
      mileage: int.parse(ungroupDigits(_mileageController.text)),
      fuelAmountLiters: double.parse(
        normalizeDecimalInput(_fuelAmountController.text),
      ),
      totalCost: int.parse(ungroupDigits(_totalCostController.text)),
      isFullTank: _isFullTank,
      notes: _emptyToNull(_notesController.text),
    );
  }

  String? _emptyToNull(String value) =>
      value.trim().isEmpty ? null : value.trim();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FuelFormCubit(getIt<FuelRepository>()),
      child: Scaffold(
        appBar: AppBar(title: Text(_isEditing ? 'ویرایش سوخت' : 'ثبت سوخت')),
        body: _loadFailed
            ? const FormLoadError()
            : _loading
            ? const Center(child: CircularProgressIndicator())
            : BlocConsumer<FuelFormCubit, FuelFormState>(
                listener: (context, state) {
                  if (state is FuelFormSuccess) {
                    Navigator.of(context).pop();
                  } else if (state is FuelFormFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  final submitting = state is FuelFormSubmitting;
                  return Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: AppSpacing.page(context),
                      children: [
                        DateField(
                          label: 'تاریخ',
                          date: _date,
                          onTap: _pickDate,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _mileageController,
                          decoration: const InputDecoration(
                            labelText: 'کیلومتر *',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [GroupedNumberInputFormatter()],
                          validator: (value) => FuelValidators.mileage(
                            value,
                            previousMileage: _previousMileage,
                            nextMileage: _nextMileage,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _fuelAmountController,
                          decoration: const InputDecoration(
                            labelText: 'مقدار سوخت (لیتر) *',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: FuelValidators.fuelAmount,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _totalCostController,
                          decoration: const InputDecoration(
                            labelText: 'هزینه (تومان) *',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [GroupedNumberInputFormatter()],
                          validator: FuelValidators.totalCost,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('باک پر شد'),
                          subtitle: const Text(
                            'برای محاسبه مصرف تقریبی، لازم است باک به‌طور کامل پر شود.',
                          ),
                          value: _isFullTank,
                          onChanged: (value) =>
                              setState(() => _isFullTank = value),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _notesController,
                          decoration: const InputDecoration(
                            labelText: 'یادداشت',
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        ElevatedButton(
                          onPressed: submitting ? null : () => _submit(context),
                          child: submitting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(_isEditing ? 'ذخیره تغییرات' : 'ثبت سوخت'),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
