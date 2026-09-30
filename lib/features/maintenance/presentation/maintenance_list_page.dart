import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/empty_state_icon.dart';
import '../cubit/maintenance_list_cubit.dart';
import '../cubit/maintenance_list_state.dart';
import '../data/maintenance_repository.dart';
import 'widgets/maintenance_record_card.dart';

class MaintenanceListPage extends StatelessWidget {
  const MaintenanceListPage({super.key, required this.vehicleId});

  final int vehicleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          MaintenanceListCubit(getIt<MaintenanceRepository>())
            ..watch(vehicleId),
      child: Scaffold(
        appBar: AppBar(title: const Text('سرویس و تعمیرات')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(AppRoutes.maintenanceNew(vehicleId)),
          icon: const Icon(Icons.add),
          label: const Text('ثبت سرویس'),
        ),
        body: BlocBuilder<MaintenanceListCubit, MaintenanceListState>(
          builder: (context, state) {
            return switch (state) {
              MaintenanceListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              MaintenanceListError(:final message) => Center(
                child: Text(message),
              ),
              MaintenanceListLoaded(records: final records)
                  when records.isEmpty =>
                _EmptyState(
                  onAdd: () =>
                      context.push(AppRoutes.maintenanceNew(vehicleId)),
                ),
              MaintenanceListLoaded(:final records) => ListView.separated(
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
                  return MaintenanceRecordCard(
                    record: record,
                    onEdit: () => context.push(
                      AppRoutes.maintenanceEdit(vehicleId, record.id),
                    ),
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
    MaintenanceRecord record,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف سرویس'),
        content: Text('آیا از حذف «${record.title}» مطمئن هستید؟'),
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
      await getIt<MaintenanceRepository>().deleteRecord(record.id);
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
            const EmptyStateIcon(Icons.build_outlined),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'هنوز سرویس یا تعمیراتی ثبت نشده است.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('ثبت سرویس'),
            ),
          ],
        ),
      ),
    );
  }
}
