import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/persian_date.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/report_calculator.dart';

/// Monthly expense bar chart (spec section 14) — the last 6 months, oldest
/// on the right since the chart reads right-to-left with the layout.
class MonthlyCostChart extends StatelessWidget {
  const MonthlyCostChart({super.key, required this.points});

  final List<MonthlyCostPoint> points;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxCost = points
        .map((p) => p.totalCost)
        .fold<int>(0, (max, cost) => cost > max ? cost : max);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('هزینه ماهانه', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.lg),
          if (maxCost == 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Text(
                'هنوز هزینه‌ای برای نمایش نمودار ثبت نشده است.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            )
          else
            SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  maxY: maxCost * 1.2,
                  barTouchData: const BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= points.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.xs),
                            child: Text(
                              jalaliMonthLabel(points[index].month),
                              style: theme.textTheme.labelSmall,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    for (var i = 0; i < points.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: points[i].totalCost.toDouble(),
                            color: theme.colorScheme.primary,
                            width: 18,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
