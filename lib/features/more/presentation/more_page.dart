import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../vehicles/cubit/active_vehicle_cubit.dart';
import '../../vehicles/cubit/active_vehicle_state.dart';
import '../../vehicles/presentation/widgets/vehicle_specs_card.dart';

/// Hub for every feature that doesn't fit the four main tabs — vehicle
/// history/parking (need an active vehicle) plus a set of vehicle-agnostic
/// reference tools (checklists, warning-light guide, troubleshooting).
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بیشتر')),
      body: BlocBuilder<ActiveVehicleCubit, ActiveVehicleState>(
        builder: (context, state) {
          final vehicle = state is ActiveVehicleLoaded ? state.vehicle : null;
          return ListView(
            padding: AppSpacing.page(context),
            children: [
              if (vehicle != null) ...[
                VehicleSpecsCard(key: ValueKey(vehicle.id), vehicle: vehicle),
                const SizedBox(height: AppSpacing.lg),
                _SectionHeader('خودرو'),
                _MoreTile(
                  icon: Icons.history,
                  title: 'تاریخچه کامل خودرو',
                  subtitle: 'همه سرویس‌ها، سوخت‌گیری‌ها، هزینه‌ها و مدارک',
                  onTap: () => context.push(AppRoutes.timeline),
                ),
                _MoreTile(
                  icon: Icons.local_parking_outlined,
                  title: 'محل پارک خودرو',
                  subtitle: 'ثبت و پیدا کردن سریع محل پارک',
                  onTap: () => context.push(AppRoutes.parking),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              _SectionHeader('راهنما و ابزار'),
              _MoreTile(
                icon: Icons.ondemand_video_outlined,
                title: 'آموزش کار با برنامه',
                subtitle: 'ویدیوهای کوتاه آموزشی برای هر بخش',
                onTap: () => context.push(AppRoutes.tutorials),
              ),
              _MoreTile(
                icon: Icons.lightbulb_outline,
                title: 'راهنمای چراغ‌های آمپر',
                subtitle: 'معنی و اهمیت علائم روی داشبورد',
                onTap: () => context.push(AppRoutes.warningLights),
              ),
              _MoreTile(
                icon: Icons.build_circle_outlined,
                title: 'عیب‌یابی اولیه',
                subtitle: 'چند بررسی ساده قبل از مراجعه به تعمیرگاه',
                onTap: () => context.push(AppRoutes.troubleshooting),
              ),
              _MoreTile(
                icon: Icons.checklist_outlined,
                title: 'چک‌لیست قبل از سفر',
                subtitle: 'روغن، لاستیک، چراغ‌ها و ایمنی',
                onTap: () => context.push(AppRoutes.pretripChecklist),
              ),
              _MoreTile(
                icon: Icons.fact_check_outlined,
                title: 'چک‌لیست خرید خودروی دست‌دوم',
                subtitle: 'بدنه، موتور، گیربکس، مدارک و تست رانندگی',
                onTap: () => context.push(AppRoutes.usedCarChecklist),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  const _MoreTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        // Icons.chevron_left has IconData.matchTextDirection: true, so
        // Flutter auto-mirrors it under RTL — using the "left" variant
        // here would actually render pointing right. chevron_right is
        // the one that ends up pointing left (the correct "reveal more"
        // direction for RTL) once auto-mirrored.
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
