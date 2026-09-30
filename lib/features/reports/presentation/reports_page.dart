import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/database/app_database.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/theme/app_spacing.dart';
import '../../expenses/cubit/expense_list_cubit.dart';
import '../../expenses/cubit/expense_list_state.dart';
import '../../expenses/data/expense_repository.dart';
import '../../fuel/cubit/fuel_list_cubit.dart';
import '../../fuel/cubit/fuel_list_state.dart';
import '../../fuel/data/fuel_repository.dart';
import '../../maintenance/cubit/maintenance_list_cubit.dart';
import '../../maintenance/cubit/maintenance_list_state.dart';
import '../../maintenance/data/maintenance_repository.dart';
import '../../vehicles/cubit/active_vehicle_cubit.dart';
import '../../vehicles/cubit/active_vehicle_state.dart';
import '../data/pdf_report_builder.dart';
import '../domain/report_calculator.dart';
import '../domain/report_period.dart';
import 'widgets/fuel_consumption_chart.dart';
import 'widgets/monthly_cost_chart.dart';
import 'widgets/report_summary_cards.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('گزارش‌ها')),
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
                  'برای مشاهده گزارش‌ها، ابتدا یک خودرو اضافه کنید.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          }
          // Keyed by vehicleId so switching the active vehicle forces a
          // fresh widget (and fresh Cubits/BlocProviders below it) instead
          // of reusing the old element — BlocProvider's create callback
          // only ever runs once per element identity, so without this key
          // the maintenance/fuel/expense cubits would keep watching
          // whichever vehicle was active when this page was first built.
          return _ReportsBody(key: ValueKey(vehicle.id), vehicle: vehicle);
        },
      ),
    );
  }
}

class _ReportsBody extends StatefulWidget {
  const _ReportsBody({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  State<_ReportsBody> createState() => _ReportsBodyState();
}

class _ReportsBodyState extends State<_ReportsBody> {
  ReportPeriod _period = ReportPeriod.thisMonth;
  bool _exportingPdf = false;

  int get _vehicleId => widget.vehicle.id;

  Future<void> _exportPdf({
    required ReportSummary summary,
    required List<MaintenanceRecord> maintenanceRecords,
    required List<FuelRecord> fuelRecords,
    required List<ExpenseRecord> expenseRecords,
  }) async {
    setState(() => _exportingPdf = true);
    try {
      final doc = await PdfReportBuilder().build(
        vehicle: widget.vehicle,
        period: _period,
        summary: summary,
        maintenanceRecords: maintenanceRecords,
        fuelRecords: fuelRecords,
        expenseRecords: expenseRecords,
      );
      final bytes = await doc.save();
      final tempDir = await getTemporaryDirectory();
      final filePath = p.join(
        tempDir.path,
        'khodroyar-report-${widget.vehicle.id}-${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      if (!mounted) return;
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(filePath)],
          text: 'گزارش خودرویار پارسیک — ${widget.vehicle.name}',
        ),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('ساخت فایل PDF انجام نشد.')));
      }
    } finally {
      if (mounted) setState(() => _exportingPdf = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              MaintenanceListCubit(getIt<MaintenanceRepository>())
                ..watch(_vehicleId),
        ),
        BlocProvider(
          create: (_) =>
              FuelListCubit(getIt<FuelRepository>())..watch(_vehicleId),
        ),
        BlocProvider(
          create: (_) =>
              ExpenseListCubit(getIt<ExpenseRepository>())..watch(_vehicleId),
        ),
      ],
      child: Builder(
        builder: (context) {
          final maintenanceState = context.watch<MaintenanceListCubit>().state;
          final fuelState = context.watch<FuelListCubit>().state;
          final expenseState = context.watch<ExpenseListCubit>().state;

          final maintenanceRecords = maintenanceState is MaintenanceListLoaded
              ? maintenanceState.records
              : const <MaintenanceRecord>[];
          final fuelRecords = fuelState is FuelListLoaded
              ? fuelState.records
              : const <FuelRecord>[];
          final expenseRecords = expenseState is ExpenseListLoaded
              ? expenseState.records
              : const <ExpenseRecord>[];

          final now = DateTime.now();
          final summary = computeReportSummary(
            maintenanceRecords: maintenanceRecords,
            fuelRecords: fuelRecords,
            expenseRecords: expenseRecords,
            period: _period.rangeFor(now),
          );
          final monthlySeries = computeMonthlyCostSeries(
            maintenanceRecords: maintenanceRecords,
            fuelRecords: fuelRecords,
            expenseRecords: expenseRecords,
            now: now,
          );
          final fuelSeries = computeFuelConsumptionSeries(fuelRecords);

          return ListView(
            padding: AppSpacing.page(context),
            children: [
              Wrap(
                spacing: AppSpacing.sm,
                children: [
                  for (final period in ReportPeriod.values)
                    ChoiceChip(
                      label: Text(period.label),
                      selected: _period == period,
                      onSelected: (_) => setState(() => _period = period),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              ReportSummaryCards(summary: summary),
              const SizedBox(height: AppSpacing.lg),
              MonthlyCostChart(points: monthlySeries),
              const SizedBox(height: AppSpacing.lg),
              FuelConsumptionChart(points: fuelSeries),
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton.icon(
                onPressed: _exportingPdf
                    ? null
                    : () => _exportPdf(
                        summary: summary,
                        maintenanceRecords: maintenanceRecords,
                        fuelRecords: fuelRecords,
                        expenseRecords: expenseRecords,
                      ),
                icon: _exportingPdf
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.picture_as_pdf_outlined),
                label: Text(_exportingPdf ? 'در حال ساخت فایل...' : 'خروجی PDF'),
              ),
            ],
          );
        },
      ),
    );
  }
}
