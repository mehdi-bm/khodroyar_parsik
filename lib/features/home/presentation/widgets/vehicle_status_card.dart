import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/notifications/notification_scheduler.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../documents/cubit/document_list_cubit.dart';
import '../../../documents/cubit/document_list_state.dart';
import '../../../documents/data/document_repository.dart';
import '../../../documents/domain/document_status_calculator.dart';
import '../../../maintenance/cubit/maintenance_schedule_list_cubit.dart';
import '../../../maintenance/cubit/maintenance_schedule_list_state.dart';
import '../../../maintenance/data/maintenance_schedule_repository.dart';
import '../../../maintenance/domain/maintenance_status_calculator.dart';

/// The dashboard's "وضعیت خودرو" card — combines maintenance-schedule
/// status badges with document-expiration status badges in one place,
/// matching the spec's own dashboard example (engine oil, insurance, and
/// inspection all shown together). Tapping a badge jumps to the relevant
/// list (maintenance vs. documents); the card itself has no single
/// destination since it now represents two features.
class VehicleStatusCard extends StatelessWidget {
  const VehicleStatusCard({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MaintenanceScheduleListCubit(
            getIt<MaintenanceScheduleRepository>(),
          )..watch(vehicle.id),
        ),
        BlocProvider(
          create: (_) =>
              DocumentListCubit(getIt<DocumentRepository>())..watch(vehicle.id),
        ),
      ],
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          final scheduleState = context
              .watch<MaintenanceScheduleListCubit>()
              .state;
          final documentState = context.watch<DocumentListCubit>().state;

          final schedules = scheduleState is MaintenanceScheduleListLoaded
              ? scheduleState.schedules
              : const <MaintenanceSchedule>[];
          final documents = documentState is DocumentListLoaded
              ? documentState.documents
              : const <Document>[];

          final today = DateTime.now();

          final isEmpty = schedules.isEmpty && documents.isEmpty;

          // Reactive mileage-based reminder check (spec section 51) — runs
          // after this frame renders, not during build. De-duplicated per
          // app session inside NotificationScheduler/NotificationService.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final scheduler = getIt<NotificationScheduler>();
            for (final schedule in schedules) {
              scheduler.checkMileageReminder(
                schedule: schedule,
                currentMileage: vehicle.currentMileage,
              );
            }
          });

          return AppCard(
            // The only entry point into the documents list before any
            // exist — maintenance/fuel/expenses all have their own quick
            // action, but the spec's dashboard only has room for three.
            onTap: isEmpty
                ? () => context.push(AppRoutes.documentList(vehicle.id))
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('وضعیت خودرو', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                if (isEmpty)
                  Text(
                    'هنوز اطلاعات سرویس یا مدرکی برای این خودرو ثبت نشده است.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  )
                else
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final schedule in schedules)
                        InkWell(
                          onTap: () => context.push(
                            AppRoutes.maintenanceList(vehicle.id),
                          ),
                          borderRadius: BorderRadius.circular(AppSpacing.sm),
                          child: StatusBadge(
                            level: computeMaintenanceStatus(
                              schedule: schedule,
                              currentMileage: vehicle.currentMileage,
                              today: today,
                            ),
                            label:
                                '${schedule.title}: ${describeMaintenanceRemaining(schedule: schedule, currentMileage: vehicle.currentMileage, today: today)}',
                          ),
                        ),
                      for (final document in documents)
                        InkWell(
                          onTap: () =>
                              context.push(AppRoutes.documentList(vehicle.id)),
                          borderRadius: BorderRadius.circular(AppSpacing.sm),
                          child: StatusBadge(
                            level: computeDocumentStatus(
                              expirationDate: document.expirationDate,
                              today: today,
                            ),
                            label:
                                '${document.title}: ${describeDocumentRemaining(expirationDate: document.expirationDate, today: today)}',
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
