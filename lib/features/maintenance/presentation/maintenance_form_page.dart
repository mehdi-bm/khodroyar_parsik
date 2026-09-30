import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/widgets/form_load_error.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/grouped_number_input.dart';
import '../../../core/utils/persian_date.dart';
import '../../../core/widgets/date_field.dart';
import '../../../core/widgets/photo_picker_avatar.dart';
import '../../vehicles/data/vehicle_repository.dart';
import '../cubit/maintenance_form_cubit.dart';
import '../cubit/maintenance_form_state.dart';
import '../data/maintenance_repository.dart';
import '../data/maintenance_schedule_repository.dart';
import '../domain/maintenance_category.dart';
import '../domain/maintenance_validators.dart';

/// Add/edit maintenance record form for [vehicleId]. In edit mode,
/// [recordId] is provided and the existing record is loaded first.
class MaintenanceFormPage extends StatefulWidget {
  const MaintenanceFormPage({
    super.key,
    required this.vehicleId,
    this.recordId,
  });

  final int vehicleId;
  final int? recordId;

  @override
  State<MaintenanceFormPage> createState() => _MaintenanceFormPageState();
}

class _MaintenanceFormPageState extends State<MaintenanceFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _mileageController = TextEditingController();
  final _costController = TextEditingController(text: formatGroupedDigits('0'));
  final _descriptionController = TextEditingController();
  final _nextMileageController = TextEditingController();

  MaintenanceCategory _category = MaintenanceCategory.engineOil;
  DateTime _date = DateTime.now();
  DateTime? _nextServiceDate;
  String? _photoPath;
  bool _loadingExisting = false;
  bool _loadFailed = false;

  bool get _isEditing => widget.recordId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _loadingExisting = true;
      getIt<MaintenanceRepository>()
          .getById(widget.recordId!)
          .then((record) {
            if (!mounted) return;
            if (record == null) {
              setState(() {
                _loadingExisting = false;
                _loadFailed = true;
              });
              return;
            }
            setState(() {
              _titleController.text = record.title;
              _category = MaintenanceCategory.fromStorageKey(record.category);
              _date = record.date;
              _mileageController.text = formatGroupedDigits(
                '${record.mileage}',
              );
              _costController.text = formatGroupedDigits('${record.cost}');
              _descriptionController.text = record.description ?? '';
              _photoPath = record.photoPath;
              _nextMileageController.text = record.nextServiceMileage == null
                  ? ''
                  : formatGroupedDigits('${record.nextServiceMileage}');
              _nextServiceDate = record.nextServiceDate;
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
    } else {
      // Pre-fill with the vehicle's current mileage as a sensible default.
      // Done before the form is built: changing a controller after the Form
      // is mounted counts as user interaction and would flag the still-empty
      // title field as an error on open.
      _loadingExisting = true;
      getIt<VehicleRepository>()
          .getVehicle(widget.vehicleId)
          .then((vehicle) {
            if (!mounted) return;
            setState(() {
              if (vehicle != null) {
                _mileageController.text = formatGroupedDigits(
                  '${vehicle.currentMileage}',
                );
              }
              _loadingExisting = false;
            });
          })
          .catchError((Object _) {
            if (mounted) setState(() => _loadingExisting = false);
          });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _mileageController.dispose();
    _costController.dispose();
    _descriptionController.dispose();
    _nextMileageController.dispose();
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

  Future<void> _pickNextServiceDate() async {
    final picked = await pickJalaliDate(
      context: context,
      initialDate:
          _nextServiceDate ?? DateTime.now().add(const Duration(days: 180)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (mounted && picked != null) setState(() => _nextServiceDate = picked);
  }

  void _submit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<MaintenanceFormCubit>().submit(
      id: widget.recordId,
      vehicleId: widget.vehicleId,
      title: _titleController.text.trim(),
      category: _category.name,
      date: _date,
      mileage: int.parse(ungroupDigits(_mileageController.text)),
      cost: int.tryParse(ungroupDigits(_costController.text)) ?? 0,
      description: _emptyToNull(_descriptionController.text),
      photoPath: _photoPath,
      nextServiceMileage: int.tryParse(
        ungroupDigits(_nextMileageController.text),
      ),
      nextServiceDate: _nextServiceDate,
    );
  }

  String? _emptyToNull(String value) =>
      value.trim().isEmpty ? null : value.trim();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MaintenanceFormCubit(
        getIt<MaintenanceRepository>(),
        getIt<MaintenanceScheduleRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text(_isEditing ? 'ویرایش سرویس' : 'ثبت سرویس')),
        body: _loadFailed
            ? const FormLoadError()
            : _loadingExisting
            ? const Center(child: CircularProgressIndicator())
            : BlocConsumer<MaintenanceFormCubit, MaintenanceFormState>(
                listener: (context, state) {
                  if (state is MaintenanceFormSuccess) {
                    Navigator.of(context).pop();
                  } else if (state is MaintenanceFormFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  final submitting = state is MaintenanceFormSubmitting;
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
                            folder: 'maintenance',
                            icon: Icons.build_outlined,
                            onChanged: (path) =>
                                setState(() => _photoPath = path),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'عنوان *',
                            hintText: 'مثلاً تعویض روغن موتور',
                          ),
                          validator: MaintenanceValidators.title,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        DropdownButtonFormField<MaintenanceCategory>(
                          isExpanded: true,
                          initialValue: _category,
                          decoration: const InputDecoration(
                            labelText: 'دسته‌بندی',
                          ),
                          items: [
                            for (final category in MaintenanceCategory.values)
                              DropdownMenuItem(
                                value: category,
                                child: Text(category.label),
                              ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _category = value);
                            }
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
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
                          validator: MaintenanceValidators.mileage,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _costController,
                          decoration: const InputDecoration(
                            labelText: 'هزینه (تومان)',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [GroupedNumberInputFormatter()],
                          validator: MaintenanceValidators.cost,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'توضیحات',
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          'سرویس بعدی (اختیاری)',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _nextMileageController,
                          decoration: const InputDecoration(
                            labelText: 'کیلومتر سرویس بعدی',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [GroupedNumberInputFormatter()],
                          validator: (value) =>
                              MaintenanceValidators.nextServiceMileage(
                                value,
                                serviceMileage:
                                    int.tryParse(
                                      ungroupDigits(_mileageController.text),
                                    ) ??
                                    0,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        DateField(
                          label: 'تاریخ سرویس بعدی',
                          date: _nextServiceDate,
                          onTap: _pickNextServiceDate,
                          onClear: _nextServiceDate == null
                              ? null
                              : () => setState(() => _nextServiceDate = null),
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
                                  _isEditing ? 'ذخیره تغییرات' : 'ثبت سرویس',
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
