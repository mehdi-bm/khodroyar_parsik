import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:caryar/core/database/app_database.dart';
import 'package:caryar/core/di/service_locator.dart';
import 'package:caryar/core/notifications/notification_sink.dart';
import 'package:caryar/core/routing/app_router.dart';
import 'package:caryar/core/routing/app_routes.dart';
import 'package:caryar/features/advertising/presentation/widgets/ad_banner_carousel.dart';
import 'package:caryar/features/documents/data/document_repository.dart';
import 'package:caryar/features/expenses/data/expense_repository.dart';
import 'package:caryar/features/fuel/data/fuel_repository.dart';
import 'package:caryar/features/maintenance/data/maintenance_repository.dart';
import 'package:caryar/features/maintenance/data/maintenance_schedule_repository.dart';
import 'package:caryar/features/vehicles/data/vehicle_repository.dart';
import 'package:caryar/main.dart';

import 'support/fake_notification_sink.dart';

void main() {
  setUp(() {
    // Registers every real repository (see setupServiceLocator) against an
    // in-memory test database, so this file never needs updating just
    // because a new phase adds another repository to the locator. The fake
    // notification sink is required, not optional — a real platform-channel
    // call under plain `flutter test` hangs forever instead of throwing.
    setupServiceLocator(
      createDatabase: () => AppDatabase.withExecutor(NativeDatabase.memory()),
      createNotificationSink: FakeNotificationSink.new,
    );
    // The Settings screen reads PackageInfo.fromPlatform() — mock it so
    // that call resolves instantly instead of hitting a real platform
    // channel with nothing to answer it.
    PackageInfo.setMockInitialValues(
      appName: 'خودرویار پارسیک',
      packageName: 'com.parsik.caryar',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
  });

  tearDown(() async {
    // `appRouter` is a single global GoRouter instance (see app_router.dart)
    // reused across every test's fresh CarYarApp() — without resetting its
    // location, a test that navigates away from /home leaks that location
    // into the next test's initial pumpWidget.
    appRouter.go(AppRoutes.home);
    if (getIt.isRegistered<AppDatabase>()) {
      await getIt<AppDatabase>().close();
    }
    await getIt.reset();
  });

  testWidgets('home tab prompts to add a vehicle when there are none, in RTL', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CarYarApp());
    await tester.pumpAndSettle();

    expect(find.text('خودرویار پارسیک'), findsOneWidget);
    expect(find.text('برای شروع، یک خودرو اضافه کنید'), findsOneWidget);

    final directionality = tester.widget<Directionality>(
      find.byType(Directionality).first,
    );
    expect(directionality.textDirection, TextDirection.rtl);

    // Close the DB connection before the test body returns — flutter_test's
    // post-test invariant check (no pending timers) runs before tearDown,
    // and drift's NativeDatabase keeps a background isolate/timer alive for
    // as long as the connection is open.
    await getIt<AppDatabase>().close();
  });

  testWidgets('small screen and large Persian text keep core screens usable', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.6;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
      tester.platformDispatcher.clearTextScaleFactorTestValue();
    });
    final id = await getIt<VehicleRepository>().addVehicle(
      name: 'خودروی خانوادگی پژو پارس',
      currentMileage: 125000,
    );
    await tester.pumpWidget(const CarYarApp());
    await tester.pumpAndSettle();
    for (final route in [
      AppRoutes.home,
      AppRoutes.vehicles,
      AppRoutes.reports,
      AppRoutes.settings,
      AppRoutes.vehicleEdit(id),
      AppRoutes.maintenanceNew(id),
      AppRoutes.fuelNew(id),
      AppRoutes.expenseNew(id),
      AppRoutes.documentNew(id),
    ]) {
      appRouter.go(route);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'Layout failed at $route');
    }
    await getIt<AppDatabase>().close();
  });

  testWidgets(
    'missing editable records show a recovery action, not an endless spinner',
    (tester) async {
      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();
      appRouter.go(AppRoutes.vehicleEdit(999));
      await tester.pumpAndSettle();
      expect(find.text('بازگشت به فهرست'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await getIt<AppDatabase>().close();
    },
  );

  testWidgets('dashboard shows the active vehicle once one exists', (
    WidgetTester tester,
  ) async {
    await getIt<VehicleRepository>().addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 87450,
    );

    await tester.pumpWidget(const CarYarApp());
    await tester.pumpAndSettle();

    expect(find.text('پژو ۲۰۶'), findsOneWidget);
    expect(find.text('۸۷,۴۵۰ کیلومتر'), findsOneWidget);
    expect(
      find.text('هنوز اطلاعات سرویس یا مدرکی برای این خودرو ثبت نشده است.'),
      findsOneWidget,
    );
    expect(
      find.text(
        'با ثبت دو سوخت‌گیری با باک پُر، میانگین مصرف نمایش داده می‌شود.',
      ),
      findsOneWidget,
    );
    expect(find.text('۰ تومان'), findsOneWidget);

    // All three quick actions are wired to their real forms now (Phases 8,
    // 10, and 11).
    await tester.tap(find.text('ثبت سرویس'));
    await tester.pumpAndSettle();
    expect(find.text('ثبت سرویس'), findsWidgets);
    expect(find.text('عنوان *'), findsOneWidget);
    // Mileage is pre-filled from the vehicle, and that pre-fill must not
    // count as user interaction that flags the untouched title as invalid.
    expect(find.text('۸۷,۴۵۰'), findsOneWidget);
    expect(find.text('وارد کردن عنوان الزامی است'), findsNothing);

    await getIt<AppDatabase>().close();
  });

  testWidgets(
    'tapping the empty vehicle-status card opens the documents list',
    (WidgetTester tester) async {
      await getIt<VehicleRepository>().addVehicle(
        name: 'پژو ۲۰۶',
        currentMileage: 87450,
      );

      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      await tester.tap(
        find.text('هنوز اطلاعات سرویس یا مدرکی برای این خودرو ثبت نشده است.'),
      );
      await tester.pumpAndSettle();

      expect(find.text('مدارک'), findsWidgets);
      expect(find.text('هنوز مدرکی ثبت نشده است.'), findsOneWidget);

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets('dashboard shows a status badge once a document exists', (
    WidgetTester tester,
  ) async {
    final vehicleId = await getIt<VehicleRepository>().addVehicle(
      name: 'دنا',
      currentMileage: 84600,
    );
    await getIt<DocumentRepository>().addDocument(
      vehicleId: vehicleId,
      title: 'بیمه شخص ثالث',
      type: 'insurance',
      expirationDate: DateTime.now().add(const Duration(days: 84)),
    );

    await tester.pumpWidget(const CarYarApp());
    await tester.pumpAndSettle();

    expect(
      find.textContaining('بیمه شخص ثالث: ۸۴ روز باقی‌مانده'),
      findsOneWidget,
    );

    await tester.tap(find.textContaining('بیمه شخص ثالث: ۸۴ روز باقی‌مانده'));
    await tester.pumpAndSettle();
    expect(find.text('مدارک'), findsWidgets);

    await getIt<AppDatabase>().close();
  });

  testWidgets(
    'dashboard sums maintenance, fuel, and expense costs for the current month',
    (WidgetTester tester) async {
      final vehicleId = await getIt<VehicleRepository>().addVehicle(
        name: 'دنا',
        currentMileage: 80500,
      );
      final now = DateTime.now();
      await getIt<ExpenseRepository>().addRecord(
        vehicleId: vehicleId,
        category: 'insurance',
        amount: 450000,
        date: now,
      );

      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      // Appears twice now: the "هزینه این ماه" card total, and the same
      // record's own row in "آخرین فعالیت‌ها" — both legitimately show it.
      expect(find.text('۴۵۰,۰۰۰ تومان'), findsWidgets);

      await tester.tap(find.text('ثبت هزینه'));
      await tester.pumpAndSettle();
      expect(find.text('ثبت هزینه'), findsWidgets);
      expect(find.text('مبلغ (تومان) *'), findsOneWidget);

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets('dashboard shows approximate fuel consumption once computable', (
    WidgetTester tester,
  ) async {
    final vehicleId = await getIt<VehicleRepository>().addVehicle(
      name: 'دنا',
      currentMileage: 80500,
    );
    await getIt<FuelRepository>().addRecord(
      vehicleId: vehicleId,
      date: DateTime(2026, 1, 1),
      mileage: 80000,
      fuelAmountLiters: 40,
      totalCost: 1400000,
      isFullTank: true,
    );
    await getIt<FuelRepository>().addRecord(
      vehicleId: vehicleId,
      date: DateTime(2026, 2, 1),
      mileage: 80500,
      fuelAmountLiters: 37,
      totalCost: 1295000,
      isFullTank: true,
    );

    await tester.pumpWidget(const CarYarApp());
    await tester.pumpAndSettle();

    expect(find.text('۷.۴ لیتر در ۱۰۰ کیلومتر'), findsOneWidget);

    await tester.tap(find.text('ثبت سوخت'));
    await tester.pumpAndSettle();
    expect(find.text('ثبت سوخت'), findsWidgets);
    expect(find.text('مقدار سوخت (لیتر) *'), findsOneWidget);

    await getIt<AppDatabase>().close();
  });

  testWidgets(
    'dashboard shows a status badge once a maintenance schedule exists',
    (WidgetTester tester) async {
      final vehicleId = await getIt<VehicleRepository>().addVehicle(
        name: 'دنا',
        currentMileage: 84600,
      );
      await getIt<MaintenanceScheduleRepository>().upsertFromRecord(
        vehicleId: vehicleId,
        category: 'engineOil',
        title: 'روغن موتور',
        serviceMileage: 80000,
        serviceDate: DateTime.now(),
        nextServiceMileage: 85000,
      );

      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      // 400 of 5000 km remaining (8%) falls inside the "due" threshold.
      expect(find.textContaining('روغن موتور'), findsOneWidget);
      expect(find.textContaining('۴۰۰ کیلومتر باقی‌مانده'), findsOneWidget);

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets('reports tab shows this-month totals across all cost sources', (
    WidgetTester tester,
  ) async {
    final vehicleId = await getIt<VehicleRepository>().addVehicle(
      name: 'دنا',
      currentMileage: 80500,
    );
    final now = DateTime.now();
    await getIt<MaintenanceRepository>().addRecord(
      vehicleId: vehicleId,
      title: 'تعویض روغن موتور',
      category: 'engineOil',
      date: now,
      mileage: 80000,
      cost: 1500000,
    );
    await getIt<ExpenseRepository>().addRecord(
      vehicleId: vehicleId,
      category: 'insurance',
      amount: 450000,
      date: now,
    );

    await tester.pumpWidget(const CarYarApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('گزارش‌ها'));
    await tester.pumpAndSettle();

    // Default filter is "این ماه" — both records were just logged today.
    expect(find.text('۱,۹۵۰,۰۰۰ تومان'), findsOneWidget); // total
    expect(find.text('۱,۵۰۰,۰۰۰ تومان'), findsOneWidget); // maintenance
    expect(find.text('۴۵۰,۰۰۰ تومان'), findsOneWidget); // other expenses

    await tester.tap(find.text('امسال'));
    await tester.pumpAndSettle();
    expect(find.text('۱,۹۵۰,۰۰۰ تومان'), findsOneWidget);

    await getIt<AppDatabase>().close();
  });

  testWidgets('bottom navigation switches between all five sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CarYarApp());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.text('خودرو'));
    await tester.pumpAndSettle();
    expect(find.text('هنوز خودرویی اضافه نکرده‌اید.'), findsOneWidget);

    await tester.tap(find.text('گزارش‌ها'));
    await tester.pumpAndSettle();
    expect(
      find.text('برای مشاهده گزارش‌ها، ابتدا یک خودرو اضافه کنید.'),
      findsOneWidget,
    );

    await tester.tap(find.text('تنظیمات'));
    await tester.pumpAndSettle();
    expect(find.text('ظاهر برنامه'), findsOneWidget);

    await tester.tap(find.text('بیشتر'));
    await tester.pumpAndSettle();
    expect(find.text('راهنمای چراغ‌های آمپر'), findsOneWidget);

    await tester.tap(find.text('خانه'));
    await tester.pumpAndSettle();
    expect(find.text('برای شروع، یک خودرو اضافه کنید'), findsOneWidget);

    expect(tester.takeException(), isNull);

    await getIt<AppDatabase>().close();
  });

  testWidgets(
    '"بیشتر" hub shows vehicle-scoped tools once a vehicle exists, and '
    'the timeline shows real records',
    (WidgetTester tester) async {
      final vehicleId = await getIt<VehicleRepository>().addVehicle(
        name: 'پژو ۲۰۶',
        currentMileage: 87450,
      );
      await getIt<MaintenanceRepository>().addRecord(
        vehicleId: vehicleId,
        title: 'تعویض روغن',
        category: 'engineOil',
        date: DateTime.now(),
        mileage: 87450,
        cost: 500000,
      );

      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('بیشتر'));
      await tester.pumpAndSettle();

      // Interact with the top-of-list, vehicle-scoped entries first, while
      // they're still on-screen near the top — before scrolling down for
      // the reference tiles below, to avoid a scroll-back-up edge case
      // where the target ends up sitting right on the viewport boundary.
      expect(find.text('مشخصات قطعات مصرفی'), findsOneWidget);
      expect(find.text('تاریخچه کامل خودرو'), findsOneWidget);
      expect(find.text('محل پارک خودرو'), findsOneWidget);

      await tester.tap(find.text('تاریخچه کامل خودرو'));
      await tester.pumpAndSettle();

      expect(find.text('تعویض روغن'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();

      // Parking uses a real platform location plugin — only confirm the
      // page opens and shows its primary action, never tap it (that would
      // hit a real platform channel with nothing to answer it under test).
      await tester.tap(find.text('محل پارک خودرو'));
      await tester.pumpAndSettle();
      expect(find.text('ثبت موقعیت فعلی'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();

      for (final title in [
        'راهنمای چراغ‌های آمپر',
        'عیب‌یابی اولیه',
        'چک‌لیست قبل از سفر',
        'چک‌لیست خرید خودروی دست‌دوم',
      ]) {
        await tester.scrollUntilVisible(
          find.text(title),
          200,
          scrollable: find.byType(Scrollable).first,
        );
        expect(find.text(title), findsOneWidget);
      }

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets('reports tab offers a PDF export button once data exists', (
    WidgetTester tester,
  ) async {
    final vehicleId = await getIt<VehicleRepository>().addVehicle(
      name: 'پژو ۲۰۶',
      currentMileage: 87450,
    );
    await getIt<ExpenseRepository>().addRecord(
      vehicleId: vehicleId,
      category: 'insurance',
      amount: 450000,
      date: DateTime.now(),
    );

    await tester.pumpWidget(const CarYarApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('گزارش‌ها'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('خروجی PDF'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('خروجی PDF'), findsOneWidget);
    // Deliberately not tapped — would invoke the real share_plus platform
    // channel, which has nothing to answer it under `flutter test`.

    await getIt<AppDatabase>().close();
  });

  testWidgets('choosing a theme mode in settings updates MaterialApp live', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CarYarApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('تنظیمات'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.system,
    );

    await tester.tap(find.text('تاریک'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );

    await getIt<AppDatabase>().close();
  });

  testWidgets(
    'turning notifications off disables the reminder rows and cancels everything',
    (WidgetTester tester) async {
      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('تنظیمات'));
      await tester.pumpAndSettle();

      final fakeSink = getIt<NotificationSink>() as FakeNotificationSink;
      await fakeSink.scheduleAt(
        id: 999,
        title: 'یادآوری',
        body: 'body',
        dateTime: DateTime.now().add(const Duration(days: 1)),
      );

      await tester.tap(find.text('فعال بودن اعلان‌ها'));
      await tester.pumpAndSettle();

      expect(fakeSink.cancelledAll, isTrue);
      expect(fakeSink.scheduled, isEmpty);

      final serviceReminderTile = tester.widget<ListTile>(
        find.widgetWithText(ListTile, 'یادآوری سرویس'),
      );
      expect(serviceReminderTile.enabled, isFalse);

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets(
    'distance and fuel unit rows in settings are informational only',
    (WidgetTester tester) async {
      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('تنظیمات'));
      await tester.pumpAndSettle();

      // These rows sit below the fold — scroll the settings ListView until
      // each becomes visible before asserting on it.
      await tester.scrollUntilVisible(
        find.text('واحد فاصله'),
        200,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text('واحد فاصله'), findsOneWidget);
      expect(find.text('کیلومتر'), findsOneWidget);
      final distanceTile = tester.widget<ListTile>(
        find.widgetWithText(ListTile, 'واحد فاصله'),
      );
      expect(distanceTile.onTap, isNull);

      await tester.scrollUntilVisible(
        find.text('واحد سوخت'),
        200,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text('واحد سوخت'), findsOneWidget);
      expect(find.text('لیتر'), findsOneWidget);
      final fuelUnitTile = tester.widget<ListTile>(
        find.widgetWithText(ListTile, 'واحد سوخت'),
      );
      expect(fuelUnitTile.onTap, isNull);

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets('privacy row in settings opens the full privacy page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CarYarApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('تنظیمات'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('حریم خصوصی'),
      200,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.text('حریم خصوصی'));
    await tester.pumpAndSettle();

    expect(find.text('حریم خصوصی'), findsWidgets);
    expect(find.text('چه اطلاعاتی ذخیره می‌شود'), findsOneWidget);
    expect(find.text('چه اطلاعاتی هرگز جمع‌آوری نمی‌شود'), findsOneWidget);

    await getIt<AppDatabase>().close();
  });

  testWidgets(
    'home page hosts the advertising carousel even before adding a vehicle',
    (WidgetTester tester) async {
      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      expect(find.byType(AdBannerCarousel), findsOneWidget);

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets(
    'settings has error-report and advertising-request entries that open '
    'their pages',
    (WidgetTester tester) async {
      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('تنظیمات'));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('ارسال گزارش خطا'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('ارسال گزارش خطا'));
      await tester.pumpAndSettle();
      // No ADS_* dart-defines are set under `flutter test`, so the feature
      // correctly disables itself rather than attempting any network call.
      expect(
        find.text('این قابلیت در حال حاضر در دسترس نیست.'),
        findsOneWidget,
      );

      await tester.pageBack();
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('درخواست تبلیغ'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('درخواست تبلیغ'));
      await tester.pumpAndSettle();
      expect(
        find.text('این قابلیت در حال حاضر در دسترس نیست.'),
        findsOneWidget,
      );

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets(
    'settings disclosure rows use the icon that renders pointing left under RTL',
    (WidgetTester tester) async {
      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('تنظیمات'));
      await tester.pumpAndSettle();

      // Icons.chevron_left has matchTextDirection: true, so under this
      // app's RTL Directionality it actually renders pointing *right* —
      // the wrong way for a "reveal more" affordance. chevron_right is the
      // one that ends up pointing left once auto-mirrored, which is what
      // every disclosure row in Settings must use instead.
      expect(find.byIcon(Icons.chevron_left), findsNothing);
      expect(find.byIcon(Icons.chevron_right), findsWidgets);

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets(
    'typing a mileage value live-formats it with grouping and Persian digits',
    (WidgetTester tester) async {
      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('افزودن خودرو'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'کیلومتر فعلی *'),
        '1500000',
      );
      await tester.pump();

      expect(find.text('۱,۵۰۰,۰۰۰'), findsOneWidget);

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets(
    'tapping a date field opens the real Jalali calendar picker, not Gregorian',
    (WidgetTester tester) async {
      await getIt<VehicleRepository>().addVehicle(
        name: 'دنا',
        currentMileage: 80500,
      );

      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('ثبت سوخت'));
      await tester.pumpAndSettle();

      // The DateField's InkWell hit area is larger than the label Text
      // itself (InputDecorator ink layer intercepts the exact label
      // offset) — the tap still lands correctly, just not on the literal
      // Text's own hit-test point.
      await tester.tap(find.text('تاریخ'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // showPersianDatePicker's Persian localization delegate provides
      // these exact button labels — if AppMaterialLocalizations.delegate
      // weren't registered in main.dart, this dialog would either assert or
      // fall back to English "OK"/"CANCEL" instead.
      expect(find.text('تأیید'), findsOneWidget);
      expect(find.text('لغو'), findsOneWidget);
      // Calendar day numbers use Persian digits like the rest of the app.
      expect(find.text('۱'), findsWidgets);
      expect(find.text('1'), findsNothing);

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets(
    'dashboard recent-activities feed shows real records, not the old static placeholder',
    (WidgetTester tester) async {
      final vehicleId = await getIt<VehicleRepository>().addVehicle(
        name: 'دنا',
        currentMileage: 80500,
      );
      await getIt<MaintenanceRepository>().addRecord(
        vehicleId: vehicleId,
        title: 'تعویض روغن موتور',
        category: 'engineOil',
        date: DateTime.now(),
        mileage: 80000,
        cost: 1500000,
      );

      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      expect(find.text('هنوز فعالیتی ثبت نشده است.'), findsNothing);
      await tester.scrollUntilVisible(
        find.text('تعویض روغن موتور'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      expect(find.text('تعویض روغن موتور'), findsOneWidget);

      await getIt<AppDatabase>().close();
    },
  );

  testWidgets(
    'switching the active vehicle refreshes dashboard cards and reports, '
    'not just the header',
    (WidgetTester tester) async {
      final vehicleAId = await getIt<VehicleRepository>().addVehicle(
        name: 'خودروی الف',
        currentMileage: 1000,
      );
      final vehicleBId = await getIt<VehicleRepository>().addVehicle(
        name: 'خودروی ب',
        currentMileage: 2000,
      );
      await getIt<VehicleRepository>().setActiveVehicle(vehicleAId);
      await getIt<ExpenseRepository>().addRecord(
        vehicleId: vehicleAId,
        category: 'insurance',
        amount: 111111,
        date: DateTime.now(),
      );
      await getIt<ExpenseRepository>().addRecord(
        vehicleId: vehicleBId,
        category: 'tires',
        amount: 222222,
        date: DateTime.now(),
      );

      await tester.pumpWidget(const CarYarApp());
      await tester.pumpAndSettle();

      // Home dashboard starts on vehicle A — "آخرین فعالیت‌ها" sits below
      // the fold, so it must be scrolled into view first. `.first` because
      // StatefulShellRoute.indexedStack builds every branch's Scrollable
      // up front, not just the visible one.
      await tester.scrollUntilVisible(
        find.text('آخرین فعالیت‌ها'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('بیمه'), findsOneWidget);
      expect(find.text('لاستیک'), findsNothing);

      await tester.tap(find.text('گزارش‌ها'));
      await tester.pumpAndSettle();
      expect(find.text('۱۱۱,۱۱۱ تومان'), findsWidgets);

      // Switch the active vehicle to B — BlocProvider.create only runs
      // once per element identity, so every per-vehicle card/page must be
      // keyed by vehicleId or it will keep showing vehicle A's stale data
      // (the actual bug this test locks in).
      await getIt<VehicleRepository>().setActiveVehicle(vehicleBId);
      await tester.pumpAndSettle();
      expect(find.text('۲۲۲,۲۲۲ تومان'), findsWidgets);
      expect(find.text('۱۱۱,۱۱۱ تومان'), findsNothing);

      await tester.tap(find.text('خانه'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('آخرین فعالیت‌ها'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('لاستیک'), findsOneWidget);
      expect(find.text('بیمه'), findsNothing);

      await getIt<AppDatabase>().close();
    },
  );
}
