import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/screens/login/login_screen.dart';
import 'package:money_maker/wigets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> _startSplashTimer() async {
    Timer(const Duration(seconds: 3), () {
      AppNavigator.of(context).pushAndRemoveUntil(LoginScreen());
    });
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