import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/widgets/form_load_error.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/grouped_number_input.dart';
import '../../../core/widgets/photo_picker_avatar.dart';
import '../cubit/vehicle_form_cubit.dart';
import '../cubit/vehicle_form_state.dart';
import '../data/vehicle_repository.dart';
import '../domain/vehicle_validators.dart';

/// Add/edit vehicle form. In edit mode, [vehicleId] is provided and the
/// existing record is loaded before the form renders.
class VehicleFormPage extends StatefulWidget {
  const VehicleFormPage({super.key, this.vehicleId});

  final int? vehicleId;

  @override
  State<VehicleFormPage> createState() => _VehicleFormPageState();
}

class _VehicleFormPageState extends State<VehicleFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _modelYearController = TextEditingController();
  final _colorController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _mileageController = TextEditingController(
    text: formatGroupedDigits('0'),
  );
  final _notesController = TextEditingController();
  final _oilTypeController = TextEditingController();
  final _oilFilterController = TextEditingController();
  final _airFilterController = TextEditingController();
  final _cabinFilterController = TextEditingController();
  final _tireSizeController = TextEditingController();
  final _batteryModelController = TextEditingController();
  final _sparkPlugController = TextEditingController();

  String? _photoPath;
  bool _loadingExisting = false;
  bool _loadFailed = false;

  bool get _isEditing => widget.vehicleId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _loadingExisting = true;
      getIt<VehicleRepository>()
          .getVehicle(widget.vehicleId!)
          .then((vehicle) {
            if (!mounted) return;
            if (vehicle == null) {
              setState(() {
                _loadingExisting = false;
                _loadFailed = true;
              });
              return;
            }
            setState(() {
              _nameController.text = vehicle.name;
              _brandController.text = vehicle.brand ?? '';
              _modelController.text = vehicle.model ?? '';
              _modelYearController.text = vehicle.modelYear?.toString() ?? '';
              _colorController.text = vehicle.color ?? '';
              _licensePlateController.text = vehicle.licensePlate ?? '';
              _mileageController.text = formatGroupedDigits(
                '${vehicle.currentMileage}',
              );
              _notesController.text = vehicle.notes ?? '';
              _oilTypeController.text = vehicle.oilType ?? '';
              _oilFilterController.text = vehicle.oilFilterModel ?? '';
              _airFilterController.text = vehicle.airFilterModel ?? '';
              _cabinFilterController.text = vehicle.cabinFilterModel ?? '';
              _tireSizeController.text = vehicle.tireSize ?? '';
              _batteryModelController.text = vehicle.batteryModel ?? '';
              _sparkPlugController.text = vehicle.sparkPlugModel ?? '';
              _photoPath = vehicle.photoPath;
              _loadingExisting = false;
            });
          })
          .catchError((Object error) {
            if (mounted) {
              setState(() {
                _loadingExisting = false;
                _loadFailed = true;
              });
            }
          });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _modelYearController.dispose();
    _colorController.dispose();
    _licensePlateController.dispose();
    _mileageController.dispose();
    _notesController.dispose();
    _oilTypeController.dispose();
    _oilFilterController.dispose();
    _airFilterController.dispose();
    _cabinFilterController.dispose();
    _tireSizeController.dispose();
    _batteryModelController.dispose();
    _sparkPlugController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<VehicleFormCubit>().submit(
      id: widget.vehicleId,
      name: _nameController.text.trim(),
      brand: _emptyToNull(_brandController.text),
      model: _emptyToNull(_modelController.text),
      modelYear: int.tryParse(ungroupDigits(_modelYearController.text)),
      color: _emptyToNull(_colorController.text),
      licensePlate: _emptyToNull(_licensePlateController.text),
      currentMileage: int.parse(ungroupDigits(_mileageController.text)),
      photoPath: _photoPath,
      notes: _emptyToNull(_notesController.text),
      oilType: _emptyToNull(_oilTypeController.text),
      oilFilterModel: _emptyToNull(_oilFilterController.text),
      airFilterModel: _emptyToNull(_airFilterController.text),
      cabinFilterModel: _emptyToNull(_cabinFilterController.text),
      tireSize: _emptyToNull(_tireSizeController.text),
      batteryModel: _emptyToNull(_batteryModelController.text),
      sparkPlugModel: _emptyToNull(_sparkPlugController.text),
    );
  }

  String? _emptyToNull(String value) =>
      value.trim().isEmpty ? null : value.trim();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VehicleFormCubit(getIt<VehicleRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? 'ویرایش خودرو' : 'افزودن خودرو'),
        ),
        body: _loadFailed
            ? const FormLoadError()
            : _loadingExisting
            ? const Center(child: CircularProgressIndicator())
            : BlocConsumer<VehicleFormCubit, VehicleFormState>(
                listener: (context, state) {
                  if (state is VehicleFormSuccess) {
                    Navigator.of(context).pop();
                  } else if (state is VehicleFormFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  final submitting = state is VehicleFormSubmitting;
                  return Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: AppSpacing.page(context),
                      children: [
                        Center(
                          child: PhotoPickerAvatar(
                            photoPath: _photoPath,
                            folder: 'vehicles',
                            onChanged: (path) =>
                                setState(() => _photoPath = path),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'نام خودرو *',
                            hintText: 'مثلاً پژو ۲۰۶',
                          ),
                          validator: VehicleValidators.name,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _brandController,
                          decoration: const InputDecoration(labelText: 'برند'),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _modelController,
                          decoration: const InputDecoration(labelText: 'مدل'),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _modelYearController,
                          decoration: const InputDecoration(
                            labelText: 'سال تولید',
                          ),
                          keyboardType: TextInputType.number,
                          validator: VehicleValidators.modelYear,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _colorController,
                          decoration: const InputDecoration(labelText: 'رنگ'),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _licensePlateController,
                          decoration: const InputDecoration(
                            labelText: 'شماره پلاک',
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _mileageController,
                          decoration: const InputDecoration(
                            labelText: 'کیلومتر فعلی *',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [GroupedNumberInputFormatter()],
                          validator: VehicleValidators.mileage,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _notesController,
                          decoration: const InputDecoration(
                            labelText: 'یادداشت',
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          'مشخصات قطعات مصرفی (اختیاری)',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'برای این‌که موقع خرید دوباره دنبال اطلاعات نگردید.',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _oilTypeController,
                          decoration: const InputDecoration(
                            labelText: 'نوع روغن موتور',
                            hintText: 'مثلاً 5W-30 سینتتیک',
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _oilFilterController,
                          decoration: const InputDecoration(
                            labelText: 'مدل فیلتر روغن',
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _airFilterController,
                          decoration: const InputDecoration(
                            labelText: 'مدل فیلتر هوا',
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _cabinFilterController,
                          decoration: const InputDecoration(
                            labelText: 'مدل فیلتر کابین',
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _tireSizeController,
                          decoration: const InputDecoration(
                            labelText: 'سایز لاستیک',
                            hintText: 'مثلاً 185/65R15',
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _batteryModelController,
                          decoration: const InputDecoration(
                            labelText: 'مدل باتری',
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _sparkPlugController,
                          decoration: const InputDecoration(
                            labelText: 'مدل شمع',
                          ),
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
                              : Text(
                                  _isEditing ? 'ذخیره تغییرات' : 'افزودن خودرو',
                                ),
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
