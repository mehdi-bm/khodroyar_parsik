import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/database/app_database.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/persian_date.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/photo_picker_avatar.dart';
import '../../vehicles/cubit/active_vehicle_cubit.dart';
import '../../vehicles/cubit/active_vehicle_state.dart';
import '../cubit/parking_cubit.dart';
import '../cubit/parking_state.dart';
import '../data/location_provider.dart';
import '../data/parking_repository.dart';

/// Lets the user save (and later find) where they parked. Only one spot is
/// kept per vehicle — saving again replaces it, this is deliberately not a
/// history log (see [ParkingRepository]).
class ParkingPage extends StatelessWidget {
  const ParkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('محل پارک خودرو')),
      body: BlocBuilder<ActiveVehicleCubit, ActiveVehicleState>(
        builder: (context, state) {
          if (state is ActiveVehicleLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final vehicle = (state as ActiveVehicleLoaded).vehicle;
          if (vehicle == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  'برای استفاده از این قابلیت، ابتدا یک خودرو اضافه کنید.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          }
          return _ParkingBody(key: ValueKey(vehicle.id), vehicleId: vehicle.id);
        },
      ),
    );
  }
}

class _ParkingBody extends StatefulWidget {
  const _ParkingBody({super.key, required this.vehicleId});

  final int vehicleId;

  @override
  State<_ParkingBody> createState() => _ParkingBodyState();
}

class _ParkingBodyState extends State<_ParkingBody> {
  final _noteController = TextEditingController();
  String? _photoPath;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _openInMaps(BuildContext context, ParkingSpot spot) async {
    final latitude = spot.latitude;
    final longitude = spot.longitude;
    if (latitude == null || longitude == null) return;
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('بازکردن نقشه انجام نشد.')));
      }
    }
  }

  Future<void> _confirmClear(BuildContext context) async {
    final cubit = context.read<ParkingCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف محل پارک'),
        content: const Text('محل پارک ذخیره‌شده حذف شود؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('انصراف'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (confirmed == true) await cubit.clear();
  }

  Future<void> _save(BuildContext context) async {
    final cubit = context.read<ParkingCubit>();
    final note = _noteController.text.trim();
    await cubit.save(
      note: note.isEmpty ? null : note,
      photoPath: _photoPath,
    );
    if (mounted) {
      _noteController.clear();
      setState(() => _photoPath = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ParkingCubit(
        getIt<ParkingRepository>(),
        getIt<LocationProvider>(),
      )..watch(widget.vehicleId),
      child: BlocConsumer<ParkingCubit, ParkingState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          final theme = Theme.of(context);
          final spot = state.spot;
          return ListView(
            padding: AppSpacing.page(context),
            children: [
              if (spot != null) ...[
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'آخرین محل ذخیره‌شده',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      if (spot.photoPath != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.sm,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            child: Image.file(
                              File(spot.photoPath!),
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if ((spot.note ?? '').isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.xs,
                          ),
                          child: Text(spot.note!),
                        ),
                      Text(
                        'ذخیره شده در ${formatJalaliDate(spot.savedAt)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          if (spot.latitude != null && spot.longitude != null)
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _openInMaps(context, spot),
                                icon: const Icon(Icons.map_outlined),
                                label: const Text('باز کردن در نقشه'),
                              ),
                            ),
                          const SizedBox(width: AppSpacing.sm),
                          TextButton(
                            onPressed: () => _confirmClear(context),
                            child: const Text('حذف'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ] else
                Text(
                  'هنوز محل پارکی برای این خودرو ثبت نشده است.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              Text('ثبت محل پارک جدید', style: theme.textTheme.titleSmall),
              const SizedBox(height: AppSpacing.md),
              Center(
                child: PhotoPickerAvatar(
                  photoPath: _photoPath,
                  folder: 'parking',
                  icon: Icons.local_parking_outlined,
                  onChanged: (path) => setState(() => _photoPath = path),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'یادداشت (اختیاری)',
                  hintText: 'مثلاً طبقه دوم، ردیف B',
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton.icon(
                onPressed: state.saving ? null : () => _save(context),
                icon: state.saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location),
                label: Text(
                  state.saving ? 'در حال دریافت موقعیت...' : 'ثبت موقعیت فعلی',
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'اگر دسترسی موقعیت مکانی داده نشود، همچنان می‌توانید فقط '
                'یادداشت یا عکس را ذخیره کنید.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
