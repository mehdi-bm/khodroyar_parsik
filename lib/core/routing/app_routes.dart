/// Top-level route paths.
abstract final class AppRoutes {
  static const String home = '/home';
  static const String vehicles = '/vehicles';
  static const String reports = '/reports';
  static const String settings = '/settings';
  static const String privacy = '/settings/privacy';
  static const String errorReport = '/settings/error-report';
  static const String advertisingRequest = '/settings/advertising-request';

  static const String more = '/more';
  static const String timeline = '/more/timeline';
  static const String parking = '/more/parking';
  static const String warningLights = '/more/warning-lights';
  static const String troubleshooting = '/more/troubleshooting';
  static const String _troubleshootingDetailBase =
      '/more/troubleshooting';
  static String troubleshootingDetail(String symptomId) =>
      '$_troubleshootingDetailBase/$symptomId';
  static const String pretripChecklist = '/more/pretrip-checklist';
  static const String usedCarChecklist = '/more/used-car-checklist';
  static const String tutorials = '/more/tutorials';
  static String tutorialPlayer(String videoId) => '$tutorials/$videoId';

  static const String vehicleNew = '/vehicles/new';
  static const String _vehicleEditBase = '/vehicles/edit';
  static String vehicleEdit(int id) => '$_vehicleEditBase/$id';

  static String maintenanceList(int vehicleId) =>
      '/vehicles/$vehicleId/maintenance';
  static String maintenanceNew(int vehicleId) =>
      '/vehicles/$vehicleId/maintenance/new';
  static String maintenanceEdit(int vehicleId, int recordId) =>
      '/vehicles/$vehicleId/maintenance/edit/$recordId';

  static String fuelList(int vehicleId) => '/vehicles/$vehicleId/fuel';
  static String fuelNew(int vehicleId) => '/vehicles/$vehicleId/fuel/new';
  static String fuelEdit(int vehicleId, int recordId) =>
      '/vehicles/$vehicleId/fuel/edit/$recordId';

  static String expenseList(int vehicleId) => '/vehicles/$vehicleId/expenses';
  static String expenseNew(int vehicleId) =>
      '/vehicles/$vehicleId/expenses/new';
  static String expenseEdit(int vehicleId, int recordId) =>
      '/vehicles/$vehicleId/expenses/edit/$recordId';

  static String documentList(int vehicleId) => '/vehicles/$vehicleId/documents';
  static String documentNew(int vehicleId) =>
      '/vehicles/$vehicleId/documents/new';
  static String documentEdit(int vehicleId, int recordId) =>
      '/vehicles/$vehicleId/documents/edit/$recordId';
}
