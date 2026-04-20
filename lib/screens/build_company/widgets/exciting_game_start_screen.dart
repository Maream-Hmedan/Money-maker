import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/build_company/widgets/start_game_screen.dart';
import 'package:money_maker/screens/login/view/login_screen.dart';
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

  Widget _topActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    final Color pinkGlow = const Color(0xFFFF7AAB);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
          color: Colors.white.withAlpha(20),
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withAlpha(45),
                  width: 1.1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isDanger ? Colors.redAccent : pinkGlow).withAlpha(
                      50,
                    ),
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18.sp, color: Colors.white),
                  SizedBox(width: 2.w),
                  Text(
                    label,
                    style: Styles().smallText.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _changeLanguage() async {
    final newLocale =
        AppLocale().isArabic() ? const Locale('en') : const Locale('ar');

    await AppLocale().setLocale(newLocale);

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _logout() async {
    final shouldLogout = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Logout',
      barrierColor: Colors.black.withAlpha(115),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white.withAlpha(22),
                    border: Border.all(
                      color: Colors.white.withAlpha(40),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(35),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: const Color(0xFFFF7AAB).withAlpha(35),
                        blurRadius: 24,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 62,
                          height: 62,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.darkBrandColor.withAlpha(242),
                                const Color(0xFFFF7AAB).withAlpha(242),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.redAccent.withAlpha(89),
                                blurRadius: 20,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          S.of(context).logout,
                          style: Styles().mainText.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        SizedBox(height: AppSize.heightBetweenTextField),
                        Text(
                          S
                              .of(context)
                              .areYouSureYouWantToLogoutFromYourAccount,
                          textAlign: TextAlign.center,
                          style: Styles().smallText.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withAlpha(210),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: _dialogActionButton(
                                label: S.of(context).cancel,
                                onTap: () => Navigator.of(context).pop(false),
                                isPrimary: false,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: _dialogActionButton(
                                label: S.of(context).logout,
                                onTap: () => Navigator.of(context).pop(true),
                                isPrimary: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );

    if (shouldLogout == true) {
      CurrentSession().clear();
      await GetStorage().erase();
      if (!mounted) return;
      AppNavigator.of(context).pushAndRemoveUntil(LoginScreen());
    }
  }

  Widget _dialogActionButton({
    required String label,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient:
                    isPrimary
                        ? LinearGradient(
                          colors: [
                            AppColors.darkBrandColor.withAlpha(242),
                            const Color(0xFFFF7AAB).withAlpha(242),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                        : null,
                color: isPrimary ? null : Colors.white.withAlpha(18),
                border: Border.all(
                  color:
                      isPrimary
                          ? Colors.transparent
                          : Colors.white.withAlpha(40),
                  width: 1.1,
                ),
                boxShadow:
                    isPrimary
                        ? [
                          BoxShadow(
                            color: Colors.redAccent.withAlpha(71),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ]
                        : [],
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: Styles().smallText.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color pinkAccent = const Color(0xFFFF3CAC);
    final Color pinkGlow = const Color(0xFFFF7AAB);

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
                stops: const [0, 0.5, 1],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _topActionButton(
                    icon: Icons.language,
                    label: AppLocale().isArabic() ? 'EN' : 'AR',
                    onTap: _changeLanguage,
                  ),
                  _topActionButton(
                    icon: Icons.logout_rounded,
                    label: S.of(context).logout,
                    isDanger: true,
                    onTap: _logout,
                  ),
                ],
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
                    S.of(context).riseToTheTop,
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withAlpha(230),
                      shadows: [
                        Shadow(
                          blurRadius: 14,
                          color: pinkGlow.withAlpha(179),
                          offset: const Offset(0, 0),
                        ),
                      ],
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
                              offset: const Offset(0, 8),
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
                                onTap: () {
                                  // AppNavigator.of(
                                  //   context,
                                  // ).push(BuildCompanyScreen());
                                  AppNavigator.of(
                                    context,
                                  ).push(CompanyOverviewScreen());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 48,
                                    vertical: 18,
                                  ),
                                  child: Text(
                                    S.of(context).startPlayingBuildYourCompany,
                                    style: TextStyle(
                                      fontSize: 19.5.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withAlpha(242),
                                      shadows: const [
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
