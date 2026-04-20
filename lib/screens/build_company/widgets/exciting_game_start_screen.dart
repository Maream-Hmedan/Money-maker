import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:sizer/sizer.dart';

class ExcitingGameStartScreen extends StatefulWidget {
  const ExcitingGameStartScreen({super.key});

  @override
  State<ExcitingGameStartScreen> createState() =>
      _ExcitingGameStartScreenState();
}

class _ExcitingGameStartScreenState extends State<ExcitingGameStartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color pinkAccent = Color(0xFFFF3CAC);
    final Color pinkGlow = Color(0xFFFF7AAB);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.borderTextFieldColor,
                  AppColors.darkBrandColor,
                  AppColors.borderTextFieldColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 0.5, 1],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'RISE TO THE TOP',
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withAlpha(230),
                      shadows: [
                        Shadow(
                          blurRadius: 14,
                          color: pinkGlow.withAlpha(179),
                          offset: Offset(0, 0),
                        ),
                      ],
                      letterSpacing: 1.6,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  AnimatedBuilder(
                    animation: _glowAnimation,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          gradient: LinearGradient(
                            colors: [
                              pinkAccent.withAlpha(
                                (0.15 * _glowAnimation.value * 255).round(),
                              ),
                              pinkGlow.withAlpha(
                                (0.25 * _glowAnimation.value * 255).round(),
                              ),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: pinkGlow.withAlpha(
                                (0.6 * _glowAnimation.value * 255).round(),
                              ),
                              blurRadius: 25 * _glowAnimation.value,
                              spreadRadius: 2 * _glowAnimation.value,
                              offset: Offset(0, 8),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withAlpha(51),
                            width: 1.5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: Material(
                              color: Colors.white.withAlpha(26),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(22),
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 48,
                                    vertical: 18,
                                  ),
                                  child: Text(
                                    'Start Playing & Build Your Company',
                                    style: TextStyle(
                                      fontSize: 19.5.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withAlpha(242),
                                      shadows: [
                                        Shadow(
                                          blurRadius: 8,
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
