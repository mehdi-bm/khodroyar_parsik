import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/widgets/form_load_error.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/grouped_number_input.dart';
import '../../../core/utils/persian_date.dart';
import '../../../core/widgets/date_field.dart';
import '../../../core/widgets/photo_picker_avatar.dart';
import '../cubit/expense_form_cubit.dart';
import '../cubit/expense_form_state.dart';
import '../data/expense_repository.dart';
import '../domain/expense_category.dart';
import '../domain/expense_validators.dart';

/// Add/edit expense record form for [vehicleId]. In edit mode, [recordId]
/// is provided and the existing record is loaded first.
class ExpenseFormPage extends StatefulWidget {
  const ExpenseFormPage({super.key, required this.vehicleId, this.recordId});

  final int vehicleId;
  final int? recordId;

  @override
  State<ExpenseFormPage> createState() => _ExpenseFormPageState();
}

class _ExpenseFormPageState extends State<ExpenseFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  ExpenseCategory _category = ExpenseCategory.insurance;
  DateTime _date = DateTime.now();
  String? _photoPath;
  bool _loading = false;
  bool _loadFailed = false;

  bool get _isEditing => widget.recordId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _loading = true;
      getIt<ExpenseRepository>()
          .getById(widget.recordId!)
          .then((record) {
            if (!mounted) return;
            if (record == null) {
              setState(() {
                _loading = false;
                _loadFailed = true;
              });
              return;
            }
            setState(() {
              _category = ExpenseCategory.fromStorageKey(record.category);
              _amountController.text = formatGroupedDigits('${record.amount}');
              _date = record.date;
              _descriptionController.text = record.description ?? '';
              _photoPath = record.photoPath;
              _loading = false;
            });
          })
          .catchError((Object error) {
            if (mounted) {
              setState(() {
                _loading = false;
                _loadFailed = true;
              });
            }
          });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
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
    context.read<ExpenseFormCubit>().submit(
      id: widget.recordId,
      vehicleId: widget.vehicleId,
      category: _category.name,
      amount: int.parse(ungroupDigits(_amountController.text)),
      date: _date,
      description: _emptyToNull(_descriptionController.text),
      photoPath: _photoPath,
    );
  }

  String? _emptyToNull(String value) =>
      value.trim().isEmpty ? null : value.trim();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpenseFormCubit(getIt<ExpenseRepository>()),
      child: Scaffold(
        appBar: AppBar(title: Text(_isEditing ? 'ویرایش هزینه' : 'ثبت هزینه')),
        body: _loadFailed
            ? const FormLoadError()
            : _loading
            ? const Center(child: CircularProgressIndicator())
            : BlocConsumer<ExpenseFormCubit, ExpenseFormState>(
                listener: (context, state) {
                  if (state is ExpenseFormSuccess) {
                    Navigator.of(context).pop();
                  } else if (state is ExpenseFormFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  final submitting = state is ExpenseFormSubmitting;
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
                            folder: 'expenses',
                            icon: Icons.receipt_long_outlined,
                            onChanged: (path) =>
                                setState(() => _photoPath = path),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        DropdownButtonFormField<ExpenseCategory>(
                          isExpanded: true,
                          initialValue: _category,
                          decoration: const InputDecoration(
                            labelText: 'دسته‌بندی',
                          ),
                          items: [
                            for (final category in ExpenseCategory.values)
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
                        TextFormField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            labelText: 'مبلغ (تومان) *',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [GroupedNumberInputFormatter()],
                          validator: ExpenseValidators.amount,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        DateField(
                          label: 'تاریخ',
                          date: _date,
                          onTap: _pickDate,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'توضیحات',
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
                              : Text(
                                  _isEditing ? 'ذخیره تغییرات' : 'ثبت هزینه',
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
