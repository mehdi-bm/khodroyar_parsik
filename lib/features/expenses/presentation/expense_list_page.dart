import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/empty_state_icon.dart';
import '../cubit/expense_list_cubit.dart';
import '../cubit/expense_list_state.dart';
import '../data/expense_repository.dart';
import 'widgets/expense_record_card.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key, required this.vehicleId});

  final int vehicleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ExpenseListCubit(getIt<ExpenseRepository>())..watch(vehicleId),
      child: Scaffold(
        appBar: AppBar(title: const Text('هزینه‌ها')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(AppRoutes.expenseNew(vehicleId)),
          icon: const Icon(Icons.add),
          label: const Text('ثبت هزینه'),
        ),
        body: BlocBuilder<ExpenseListCubit, ExpenseListState>(
          builder: (context, state) {
            return switch (state) {
              ExpenseListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              ExpenseListError(:final message) => Center(child: Text(message)),
              ExpenseListLoaded(records: final records) when records.isEmpty =>
                _EmptyState(
                  onAdd: () => context.push(AppRoutes.expenseNew(vehicleId)),
                ),
              ExpenseListLoaded(:final records) => ListView.separated(
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
                  return ExpenseRecordCard(
                    record: record,
                    onEdit: () => context.push(
                      AppRoutes.expenseEdit(vehicleId, record.id),
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
    ExpenseRecord record,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف هزینه'),
        content: const Text('آیا از حذف این هزینه مطمئن هستید؟'),
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
      await getIt<ExpenseRepository>().deleteRecord(record.id);
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
            const EmptyStateIcon(Icons.payments_outlined),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'هنوز هزینه‌ای ثبت نشده است.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('ثبت هزینه'),
            ),
          ],
        ),
      ),
    );
  }
}
