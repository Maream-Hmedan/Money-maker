import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/controller/build_company_controller.dart';
import 'package:money_maker/screens/change_password/controller/reset_pass_controller.dart';
import 'package:money_maker/screens/change_password/view/change_password_screen.dart';
import 'package:money_maker/screens/home/widget/balance_value/balance_value_controller.dart';
import 'package:money_maker/screens/home/widget/portfolio_value/portfolio_value_controller.dart';
import 'package:money_maker/screens/login/view/login_screen.dart';
import 'package:money_maker/screens/market/controller/market_controller.dart';
import 'package:money_maker/screens/market_place/controller/market_place_controller.dart';
import 'package:money_maker/screens/notification/controller/notification_controller.dart';
import 'package:money_maker/screens/portfolio/controller/portfolio_controller.dart';
import 'package:money_maker/screens/profile/controller/get_profile_controller.dart';
import 'package:money_maker/screens/settings/contact_us/view/contact_us_screen.dart';
import 'package:money_maker/screens/settings/privacy_policy/view/privacy_policy_screen.dart';
import 'package:money_maker/screens/special_offers/controller/special_offers_controller.dart';
import 'package:money_maker/screens/top/controller/top_controller.dart';
import 'package:money_maker/screens/top_up_balance/controller/top_up_controller.dart';
import 'package:money_maker/screens/top_up_balance/view/top_up_balance_screen.dart';
import 'package:money_maker/screens/transaction_history/controller/transaction_history_controller.dart';
import 'package:money_maker/screens/transaction_history/view/transaction_history_screen.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/button_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sizer/sizer.dart';

import 'delete_account/controller/delete_my_account_controller.dart'
    show DeleteMyAccount;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<PopupMenuButtonState<String>> _langMenuKey =
      GlobalKey<PopupMenuButtonState<String>>();

  final DeleteMyAccount _deleteAccountController = Get.put(DeleteMyAccount());

  @override
  Widget build(BuildContext context) {
    final isGuest = CurrentSession().getUser() == null;

    return CommonBackground(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset(
              appLogo,
              width: AppSize.logoWidthCommon,
              height: AppSize.logoHeightCommon,
              fit: BoxFit.cover,
            ),
            CommonViews().customText(
              textContent: S.of(context).settings,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              textColor: AppColors.buttonColor,
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height: 1.h),

                  if (!isGuest) ...[
                    buildSettingItem(
                      title: S.of(context).changePassword,
                      onTap: () {
                        AppNavigator.of(
                          context,
                          rootNavigator: true,
                        ).push(ChangePasswordScreen());
                      },
                      showDivider: true,
                    ),
                    buildSettingItem(
                      title: S.of(context).topUpYourBalance,
                      onTap: () {
                        AppNavigator.of(
                          context,
                          rootNavigator: true,
                        ).push(BalanceTopUpScreen());
                      },
                      showDivider: true,
                    ),
                    buildSettingItem(
                      title: S.of(context).payment,
                      onTap: () {
                        AppNavigator.of(
                          context,
                          rootNavigator: true,
                        ).push(TransactionHistoryScreen());
                      },
                      showDivider: true,
                    ),
                  ],

                  buildSettingItem(
                    title: S.of(context).changeLanguage,
                    onTap: _openLanguageMenu,
                    showDivider: true,
                    trailing: changeLanguageTheme(context),
                  ),
                  buildSettingItem(
                    title: S.of(context).contactUs,
                    onTap: () {
                      AppNavigator.of(
                        context,
                        rootNavigator: true,
                      ).push(ContactUsScreen());
                    },
                    showDivider: true,
                  ),
                  buildSettingItem(
                    title: S.of(context).privacyPolicyTerms,
                    onTap: () {
                      AppNavigator.of(
                        context,
                        rootNavigator: true,
                      ).push(PrivacyPolicyScreen());
                    },
                    showDivider: !isGuest,
                  ),

                  if (!isGuest) ...[
                    buildSettingItem(
                      title: S.of(context).deleteMyAccount,
                      onTap: () {
                        deleteAccountDialog(context);
                      },
                      showDivider: false,
                    ),
                    SizedBox(height: 2.h),
                    ButtonWidget(
                      color: AppColors.buttonColor,
                      border: AppSize.radiusButtonSignInSignUp,
                      onTap: () {
                        _logOut();
                      },
                      child: Text(
                        S.of(context).logOut,
                        style: Styles().buttonText,
                      ),
                    ),
                  ] else ...[
                    SizedBox(height: 2.h),
                    ButtonWidget(
                      color: AppColors.buttonColor,
                      border: AppSize.radiusButtonSignInSignUp,
                      onTap: () {
                        AppNavigator.of(
                          context,
                          rootNavigator: true,
                        ).pushAndRemoveUntil(LoginScreen());
                      },
                      child: Text(
                        S.of(context).logIn,
                        style: Styles().buttonText,
                      ),
                    ),
                  ],

                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingItem({
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    bool showDivider = false,
  }) {
    return Column(
      children: [
        ListTile(
          title: CommonViews().customText(
            textContent: title,
            textColor: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          trailing: trailing ?? const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: AppColors.buttonColor, thickness: 2),
          ),
      ],
    );
  }

  void _openLanguageMenu() {
    final dynamic state = _langMenuKey.currentState;
    state?.showButtonMenu();
  }

  Theme changeLanguageTheme(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(popupMenuTheme: PopupMenuThemeData(color: Colors.white)),
      child: PopupMenuButton<String>(
        key: _langMenuKey,
        position: PopupMenuPosition.under,
        onSelected: (value) => _onMenuSelected(context, value),
        child: const Icon(Icons.chevron_right),
        itemBuilder: (context) {
          final localeModel = ScopedModel.of<AppLocale>(context);
          return [S.of(context).english, S.of(context).arabic].map((lang) {
            final bool isSelected =
                localeModel.currentLocale.languageCode ==
                (lang == S.of(context).arabic ? 'ar' : 'en');
            return PopupMenuItem<String>(
              value: lang,
              child:
                  isSelected
                      ? Container(
                        width: 100.w,
                        height: 4.h,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.darkBrandColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          lang,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                      : Text(
                        lang,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.darkBrandColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
            );
          }).toList();
        },
      ),
    );
  }

  void _onMenuSelected(BuildContext context, String value) {
    final locale =
        (value == S.of(context).arabic)
            ? const Locale('ar')
            : const Locale('en');
    AppLocale().setLocale(locale);
  }

  Future<dynamic> deleteAccountDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: CommonViews().customText(
              textContent: S.of(context).confirmDeletion,
              textColor: AppColors.darkBrandColor,
            ),
            content: CommonViews().customText(
              textContent:
                  S.of(context).areYouSureYouWantToDeleteYourAccountThis,
              textColor: Colors.black54,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  S.of(context).no,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteAccountController.deleteAccount();
                },
                child: Text(
                  S.of(context).yes,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.darkBrandColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _logOut() async {
    try {
      ProgressHud.shared.startLoading(Get.context!);
      final url = Uri.parse(ApiEndPoint.LOGOUT_URL);
      final token = GetStorage().read(ConstantValues.TOKEN);

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      ProgressHud.shared.stopLoading();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          CurrentSession().clear();
          GetStorage().erase();
          Get.delete<PortfolioValueController>();
          Get.delete<MarketController>();
          Get.delete<ProfileController>();
          Get.delete<CompanyController>();
          Get.delete<ChangePasswordController>();
          Get.delete<BalanceValueController>();
          Get.delete<MarketPlaceController>();
          Get.delete<NotificationController>();
          Get.delete<PortfolioController>();
          Get.delete<SpecialOffersController>();
          Get.delete<TopLeaderBoardController>();
          Get.delete<TransactionHistoryController>();
          Get.delete<TopUpController>();
          AppNavigator.of(Get.context!).pushAndRemoveUntil(LoginScreen());
        } else {
          debugPrint('Logout failed: ${data['message']}');
        }
      } else {
        debugPrint('Invalid response: ${response.body}');
      }
    } catch (e) {
      ProgressHud.shared.stopLoading();
      debugPrint('ERROR $e');
    }
  }
}
