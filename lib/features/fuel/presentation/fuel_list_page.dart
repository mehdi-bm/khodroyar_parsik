import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/empty_state_icon.dart';
import '../cubit/fuel_list_cubit.dart';
import '../cubit/fuel_list_state.dart';
import '../data/fuel_repository.dart';
import '../domain/fuel_consumption_calculator.dart';
import 'widgets/fuel_record_card.dart';

class FuelListPage extends StatelessWidget {
  const FuelListPage({super.key, required this.vehicleId});

  final int vehicleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FuelListCubit(getIt<FuelRepository>())..watch(vehicleId),
      child: Scaffold(
        appBar: AppBar(title: const Text('سوخت')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(AppRoutes.fuelNew(vehicleId)),
          icon: const Icon(Icons.add),
          label: const Text('ثبت سوخت'),
        ),
        body: BlocBuilder<FuelListCubit, FuelListState>(
          builder: (context, state) {
            return switch (state) {
              FuelListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              FuelListError(:final message) => Center(child: Text(message)),
              FuelListLoaded(records: final records) when records.isEmpty =>
                _EmptyState(
                  onAdd: () => context.push(AppRoutes.fuelNew(vehicleId)),
                ),
              FuelListLoaded(:final records) => ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  96,
                ),
                itemCount: records.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final record = records[index];
                  return FuelRecordCard(
                    record: record,
                    consumption: consumptionAt(records, record),
                    onEdit: () =>
                        context.push(AppRoutes.fuelEdit(vehicleId, record.id)),
                    onDelete: () => _confirmAndDelete(context, record),
                  );
                },
              ),
            };
          },
        ),
      ),
    );
  }

  Future<void> _confirmAndDelete(
    BuildContext context,
    FuelRecord record,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف سوخت‌گیری'),
        content: const Text('آیا از حذف این سوخت‌گیری مطمئن هستید؟'),
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
    if (confirmed != true) return;

    try {
      await getIt<FuelRepository>().deleteRecord(record.id);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('عملیات انجام نشد. دوباره تلاش کنید.')),
        );
      }
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmptyStateIcon(Icons.local_gas_station_outlined),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'هنوز سوخت‌گیری ثبت نشده است.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('ثبت سوخت'),
            ),
          ],
        ),
      ),
    );
  }
}
