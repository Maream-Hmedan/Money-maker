import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:money_maker/screens/build_company/widgets/exciting_game_start_screen.dart';
import 'package:money_maker/screens/build_company/widgets/start_game_screen.dart';
import 'package:money_maker/screens/login/controller/login_controller.dart';
import 'package:money_maker/screens/login/view/login_screen.dart';
import 'package:money_maker/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  final LoginController _loginController = Get.put(LoginController());

  Future<void> _startSplashTimer() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final navigator = AppNavigator.of(context);
    final email = GetStorage().read(ConstantValues.USER_EMAIL);
    final password = GetStorage().read(ConstantValues.USER_PASSWORD);

    if (kDebugMode) {
      print('email: $email, password: $password');
    }

    if (email != null && password != null) {
      final success = await _loginController.login(
        email: email.toString(),
        password: password.toString(),
        showLoading: false,
      );

      if (kDebugMode) {
        print('success: $success');
      }

      if (!mounted) return;
      if (success) {
        final user = Get.find<SessionController>().user;

        if (user?.hasCompanies == true &&
            user!.companies.isNotEmpty) {

          final company = user.companies.first;

          if (company.status == "pending") {
            navigator.push(
              CompanyOverviewScreen(),
            );
          } else if (company.status == "active") {
            navigator.push(const BottomNavBarScreen());
          } else {
            navigator.push(const ExcitingGameStartScreen());
          }

        } else {
          navigator.push(const ExcitingGameStartScreen());
        }
      }else {
        navigator.pushAndRemoveUntil(LoginScreen());
      }
    } else {
      navigator.pushAndRemoveUntil(LoginScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    _startSplashTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CommonBackground(
          child: Center(
            child: Image.asset(
              appLogo,
              width: AppSize.logoWidth,
              height: AppSize.logoHeight,
            ),
          ),
        ),
      ),
    );
  }
}
