import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'screens/splash/splash_screen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
  playSound: true,
  enableVibration: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const String channelId = 'high_importance_channel';
const String channelName = 'High Importance Notifications';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print(
      '[BG] message: ${message.messageId} '
      'title=${message.notification?.title} '
      'body=${message.notification?.body}',
    );
  }
}

void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        if (kDebugMode) print('FlutterError ➜ ${details.exceptionAsString()}');
      };
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      runApp(const MyApp());
    },
    (error, stack) {
      if (kDebugMode) print('runZonedGuarded Error ➜ $error\n$stack');
    },
  );
}

Future<void> _requestNotificationPermission() async {
  final settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  if (kDebugMode) {
    print('Notification permission: ${settings.authorizationStatus}');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _bootstrapped = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<void> _bootstrap() async {
    try {
      await GetStorage.init();
      await AppLocale().init();

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      await _requestNotificationPermission();

      const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosInit = DarwinInitializationSettings();
      const initSettings = InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );
      await flutterLocalNotificationsPlugin.initialize(initSettings);

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        final notif = message.notification;
        if (notif == null) return;
        await flutterLocalNotificationsPlugin.show(
          message.hashCode,
          notif.title ?? '',
          notif.body ?? '',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              channelId,
              channelName,
              importance: Importance.high,
              priority: Priority.high,
              color: Colors.indigoAccent,
              playSound: true,
              enableVibration: true,
              icon: '@mipmap/ic_launcher',
              styleInformation: BigTextStyleInformation(''),
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
        );
      });

      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (kDebugMode) print('FCM token Money: $fcmToken');

      setState(() => _bootstrapped = true);
    } catch (e, st) {
      if (kDebugMode) print('Bootstrap error: $e\n$st');
      setState(() => _bootstrapped = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final home = _bootstrapped ? SplashScreen() : SplashScreen();

    return ScopedModel<AppLocale>(
      model: AppLocale(),
      child: ScopedModelDescendant<AppLocale>(
        builder: (_, __, localeModel) {
          final isArabic = localeModel.isArabic();
          return Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: Sizer(
              builder: (context, orientation, deviceType) {
                return OKToast(
                  child: GetMaterialApp(
                    key: ValueKey(localeModel.currentLocale.languageCode),
                    builder:
                        (context, child) => MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            boldText: false,
                            textScaler: const TextScaler.linear(1.0),
                          ),
                          child: child!,
                        ),
                    locale: localeModel.currentLocale,
                    localeResolutionCallback:
                        (deviceLocale, supported) => localeModel.currentLocale,
                    supportedLocales: S.delegate.supportedLocales,
                    localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      S.delegate,
                    ],
                    title: 'Money Maker',
                    theme: ThemeData(fontFamily: 'Futura'),
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeMode.system,
                    home: home,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
