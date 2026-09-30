import 'package:go_router/go_router.dart';

import '../../features/advertising/presentation/advertising_request_page.dart';
import '../../features/advertising/presentation/error_report_page.dart';
import '../../features/documents/presentation/document_form_page.dart';
import '../../features/documents/presentation/document_list_page.dart';
import '../../features/expenses/presentation/expense_form_page.dart';
import '../../features/expenses/presentation/expense_list_page.dart';
import '../../features/fuel/presentation/fuel_form_page.dart';
import '../../features/fuel/presentation/fuel_list_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/maintenance/presentation/maintenance_form_page.dart';
import '../../features/maintenance/presentation/maintenance_list_page.dart';
import '../../features/more/presentation/more_page.dart';
import '../../features/parking/presentation/parking_page.dart';
import '../../features/reference/presentation/pretrip_checklist_page.dart';
import '../../features/reference/presentation/troubleshooting_detail_page.dart';
import '../../features/reference/presentation/troubleshooting_page.dart';
import '../../features/reference/presentation/used_car_checklist_page.dart';
import '../../features/reference/presentation/warning_lights_page.dart';
import '../../features/reports/presentation/reports_page.dart';
import '../../features/tutorials/presentation/tutorial_player_page.dart';
import '../../features/tutorials/presentation/tutorials_page.dart';
import '../../features/settings/presentation/privacy_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../../features/timeline/presentation/timeline_page.dart';
import '../../features/vehicles/presentation/vehicle_form_page.dart';
import '../../features/vehicles/presentation/vehicles_page.dart';
import 'app_shell.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    // Full-screen routes (no bottom nav) — sit above the shell.
    GoRoute(
      path: AppRoutes.vehicleNew,
      builder: (context, state) => const VehicleFormPage(),
    ),
    GoRoute(
      path: '/vehicles/edit/:id',
      builder: (context, state) =>
          VehicleFormPage(vehicleId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/maintenance',
      builder: (context, state) => MaintenanceListPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
      ),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/maintenance/new',
      builder: (context, state) => MaintenanceFormPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
      ),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/maintenance/edit/:id',
      builder: (context, state) => MaintenanceFormPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
        recordId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/fuel',
      builder: (context, state) => FuelListPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
      ),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/fuel/new',
      builder: (context, state) => FuelFormPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
      ),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/fuel/edit/:id',
      builder: (context, state) => FuelFormPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
        recordId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/expenses',
      builder: (context, state) => ExpenseListPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
      ),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/expenses/new',
      builder: (context, state) => ExpenseFormPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
      ),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/expenses/edit/:id',
      builder: (context, state) => ExpenseFormPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
        recordId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/documents',
      builder: (context, state) => DocumentListPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
      ),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/documents/new',
      builder: (context, state) => DocumentFormPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
      ),
    ),
    GoRoute(
      path: '/vehicles/:vehicleId/documents/edit/:id',
      builder: (context, state) => DocumentFormPage(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
        recordId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: AppRoutes.privacy,
      builder: (context, state) => const PrivacyPage(),
    ),
    GoRoute(
      path: AppRoutes.errorReport,
      builder: (context, state) => const ErrorReportPage(),
    ),
    GoRoute(
      path: AppRoutes.advertisingRequest,
      builder: (context, state) => const AdvertisingRequestPage(),
    ),
    GoRoute(
      path: AppRoutes.timeline,
      builder: (context, state) => const TimelinePage(),
    ),
    GoRoute(
      path: AppRoutes.parking,
      builder: (context, state) => const ParkingPage(),
    ),
    GoRoute(
      path: AppRoutes.warningLights,
      builder: (context, state) => const WarningLightsPage(),
    ),
    GoRoute(
      path: AppRoutes.troubleshooting,
      builder: (context, state) => const TroubleshootingPage(),
    ),
    GoRoute(
      path: '${AppRoutes.troubleshooting}/:symptomId',
      builder: (context, state) => TroubleshootingDetailPage(
        symptomId: state.pathParameters['symptomId']!,
      ),
    ),
    GoRoute(
      path: AppRoutes.pretripChecklist,
      builder: (context, state) => const PretripChecklistPage(),
    ),
    GoRoute(
      path: AppRoutes.usedCarChecklist,
      builder: (context, state) => const UsedCarChecklistPage(),
    ),
    GoRoute(
      path: AppRoutes.tutorials,
      builder: (context, state) => const TutorialsPage(),
    ),
    GoRoute(
      path: '${AppRoutes.tutorials}/:videoId',
      builder: (context, state) =>
          TutorialPlayerPage(videoId: state.pathParameters['videoId']!),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.vehicles,
              builder: (context, state) => const VehiclesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.reports,
              builder: (context, state) => const ReportsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.more,
              builder: (context, state) => const MorePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
