import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return OKToast(
        child: GetMaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              boldText: false,
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          ),
          title: 'Money Maker',
          theme: ThemeData(
            fontFamily: 'Futura',
          ),
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          home:  const SplashScreen(),
        ),
      );
    });
  }
}

