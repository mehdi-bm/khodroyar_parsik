import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/empty_state_icon.dart';
import '../cubit/document_list_cubit.dart';
import '../cubit/document_list_state.dart';
import '../data/document_repository.dart';
import 'widgets/document_record_card.dart';

class DocumentListPage extends StatelessWidget {
  const DocumentListPage({super.key, required this.vehicleId});

  final int vehicleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          DocumentListCubit(getIt<DocumentRepository>())..watch(vehicleId),
      child: Scaffold(
        appBar: AppBar(title: const Text('مدارک')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(AppRoutes.documentNew(vehicleId)),
          icon: const Icon(Icons.add),
          label: const Text('افزودن مدرک'),
        ),
        body: BlocBuilder<DocumentListCubit, DocumentListState>(
          builder: (context, state) {
            return switch (state) {
              DocumentListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              DocumentListError(:final message) => Center(child: Text(message)),
              DocumentListLoaded(documents: final documents)
                  when documents.isEmpty =>
                _EmptyState(
                  onAdd: () => context.push(AppRoutes.documentNew(vehicleId)),
                ),
              DocumentListLoaded(:final documents) => ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  96,
                ),
                itemCount: documents.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final document = documents[index];
                  return DocumentRecordCard(
                    document: document,
                    onEdit: () => context.push(
                      AppRoutes.documentEdit(vehicleId, document.id),
                    ),
                    onDelete: () => _confirmAndDelete(context, document),
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
    Document document,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف مدرک'),
        content: Text('آیا از حذف «${document.title}» مطمئن هستید؟'),
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
      await getIt<DocumentRepository>().deleteDocument(document.id);
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
            const EmptyStateIcon(Icons.description_outlined),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'هنوز مدرکی ثبت نشده است.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('افزودن مدرک'),
            ),
          ],
        ),
      ),
    );
  }
}
