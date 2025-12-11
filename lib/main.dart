import 'package:biker_app/app/get_di.dart';
import 'package:biker_app/app/services/appsflyer_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_theme.dart';
import 'package:biker_app/app/utils/common.dart';
import 'package:biker_app/app/utils/extensions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize Firebase Analytics
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await EasyLocalization.ensureInitialized();

  await init();

  // Initialize AppsFlyer Service
  Get.put(AppsFlyerService());

  // Example: log app_open event
  analytics.logAppOpen();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
        Locale('ar', 'SA'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('fr', 'FR'),
      startLocale: const Locale('fr', 'FR'),
      useFallbackTranslations: true,
      child: MyApp(analytics: analytics),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics;
  const MyApp({super.key, required this.analytics});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    "Your device locale: ${Get.deviceLocale}".logStr(name: 'Locale');
    return KeyboardDismissOnTap(
      // Dismiss keyboard when clicked outside
      // onTap: () => Common.dismissKeyboard(),
      child: GetMaterialApp(
        initialRoute: AppRoutes.initial,
        theme: AppThemes.themData,
        getPages: AppPages.pages,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      ),
    );
  }
}
