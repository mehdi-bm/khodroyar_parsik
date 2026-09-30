import '../../../core/database/app_database.dart';
import '../../../core/utils/persian_digits.dart';

/// Approximate consumption in liters per 100km as of [record], anchored to
/// the most recent full-tank fill-up strictly before it. Consumption can
/// only be computed *ending* at a full-tank fill-up — a partial fill
/// doesn't tell you how much fuel was actually used since the last full
/// tank, so [record] itself must be a full tank too. Returns `null` when
/// there isn't enough data yet, per the app's rule against showing
/// misleading fuel-economy figures.
double? consumptionAt(
  List<FuelRecord> allRecordsForVehicle,
  FuelRecord record,
) {
  if (!record.isFullTank) return null;

  FuelRecord? previous;
  for (final candidate in allRecordsForVehicle) {
    if (!candidate.isFullTank) continue;
    if (candidate.mileage >= record.mileage) continue;
    if (previous == null || candidate.mileage > previous.mileage) {
      previous = candidate;
    }
  }
  if (previous == null) return null;

  final distance = record.mileage - previous.mileage;
  if (distance <= 0) return null;

  // Partial fills between the two full tanks are fuel consumed too. Omitting
  // them makes a driver's reported economy look artificially better.
  final intermediateLiters = allRecordsForVehicle
      .where(
        (r) =>
            r.vehicleId == record.vehicleId &&
            r.mileage > previous!.mileage &&
            r.mileage < record.mileage,
      )
      .fold<double>(0, (sum, r) => sum + r.fuelAmountLiters);
  return (intermediateLiters + record.fuelAmountLiters) / distance * 100;
}

/// The most recent computable consumption figure across [records], for the
/// dashboard's "مصرف سوخت اخیر" summary.
double? latestFuelConsumption(List<FuelRecord> records) {
  final fullTanks = records.where((r) => r.isFullTank).toList()
    ..sort((a, b) => b.mileage.compareTo(a.mileage));
  for (final record in fullTanks) {
    final value = consumptionAt(records, record);
    if (value != null) return value;
  }
  return null;
}

/// Formats a liters/100km figure with one decimal place and Persian digits,
/// e.g. "۷.۴ لیتر در ۱۰۰ کیلومتر" — matching the spec's dashboard example.
/// Always clearly labeled as approximate by the caller, never as a precise
/// measurement.
String formatFuelConsumption(double litersPer100Km) =>
    toPersianDigits('${litersPer100Km.toStringAsFixed(1)} لیتر در 100 کیلومتر');
