import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/widgets/form_load_error.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/persian_date.dart';
import '../../../core/widgets/date_field.dart';
import '../../../core/widgets/photo_picker_avatar.dart';
import '../cubit/document_form_cubit.dart';
import '../cubit/document_form_state.dart';
import '../data/document_repository.dart';
import '../domain/document_type.dart';
import '../domain/document_validators.dart';

/// Add/edit document form for [vehicleId]. In edit mode, [recordId] is
/// provided and the existing document is loaded first.
class DocumentFormPage extends StatefulWidget {
  const DocumentFormPage({super.key, required this.vehicleId, this.recordId});

  final int vehicleId;
  final int? recordId;

  @override
  State<DocumentFormPage> createState() => _DocumentFormPageState();
}

class _DocumentFormPageState extends State<DocumentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();

  DocumentType _type = DocumentType.insurance;
  DateTime? _startDate;
  DateTime _expirationDate = DateTime.now().add(const Duration(days: 365));
  String? _photoPath;
  bool _loading = false;
  bool _loadFailed = false;
  String? _expirationError;

  bool get _isEditing => widget.recordId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _loading = true;
      getIt<DocumentRepository>()
          .getById(widget.recordId!)
          .then((document) {
            if (!mounted) return;
            if (document == null) {
              setState(() {
                _loading = false;
                _loadFailed = true;
              });
              return;
            }
            setState(() {
              _titleController.text = document.title;
              _type = DocumentType.fromStorageKey(document.type);
              _startDate = document.startDate;
              _expirationDate = document.expirationDate;
              _notesController.text = document.notes ?? '';
              _photoPath = document.photoPath;
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
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickStartDate() async {
    final picked = await pickJalaliDate(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (mounted && picked != null) setState(() => _startDate = picked);
  }

  Future<void> _pickExpirationDate() async {
    final picked = await pickJalaliDate(
      context: context,
      initialDate: _expirationDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650 * 2)),
    );
    if (mounted && picked != null) setState(() => _expirationDate = picked);
  }

  void _submit(BuildContext context) {
    final formValid = _formKey.currentState?.validate() ?? false;
    final expirationError = DocumentValidators.expirationDate(
      startDate: _startDate,
      expirationDate: _expirationDate,
    );
    setState(() => _expirationError = expirationError);
    if (!formValid || expirationError != null) return;

    context.read<DocumentFormCubit>().submit(
      id: widget.recordId,
      vehicleId: widget.vehicleId,
      title: _titleController.text.trim(),
      type: _type.name,
      startDate: _startDate,
      expirationDate: _expirationDate,
      photoPath: _photoPath,
      notes: _emptyToNull(_notesController.text),
    );
  }

  String? _emptyToNull(String value) =>
      value.trim().isEmpty ? null : value.trim();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DocumentFormCubit(getIt<DocumentRepository>()),
      child: Scaffold(
        appBar: AppBar(title: Text(_isEditing ? 'ویرایش مدرک' : 'افزودن مدرک')),
        body: _loadFailed
            ? const FormLoadError()
            : _loading
            ? const Center(child: CircularProgressIndicator())
            : BlocConsumer<DocumentFormCubit, DocumentFormState>(
                listener: (context, state) {
                  if (state is DocumentFormSuccess) {
                    Navigator.of(context).pop();
                  } else if (state is DocumentFormFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  final submitting = state is DocumentFormSubmitting;
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
                            folder: 'documents',
                            icon: Icons.description_outlined,
                            onChanged: (path) =>
                                setState(() => _photoPath = path),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'عنوان *',
                            hintText: 'مثلاً بیمه شخص ثالث',
                          ),
                          validator: DocumentValidators.title,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        DropdownButtonFormField<DocumentType>(
                          isExpanded: true,
                          initialValue: _type,
                          decoration: const InputDecoration(
                            labelText: 'نوع مدرک',
                          ),
                          items: [
                            for (final type in DocumentType.values)
                              DropdownMenuItem(
                                value: type,
                                child: Text(type.label),
                              ),
                          ],
                          onChanged: (value) {
                            if (value != null) setState(() => _type = value);
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        DateField(
                          label: 'تاریخ شروع (اختیاری)',
                          date: _startDate,
                          onTap: _pickStartDate,
                          onClear: _startDate == null
                              ? null
                              : () => setState(() => _startDate = null),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        DateField(
                          label: 'تاریخ انقضا *',
                          date: _expirationDate,
                          onTap: _pickExpirationDate,
                        ),
                        if (_expirationError != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppSpacing.xs,
                              right: AppSpacing.md,
                            ),
                            child: Text(
                              _expirationError!,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
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
                              : Text(
                                  _isEditing ? 'ذخیره تغییرات' : 'افزودن مدرک',
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
