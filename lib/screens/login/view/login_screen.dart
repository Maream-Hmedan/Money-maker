import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/build_company/widgets/exciting_game_start_screen.dart';
import 'package:money_maker/screens/build_company/widgets/start_game_screen.dart';
import 'package:money_maker/screens/forgot_password/view/forgot_password_screen.dart';
import 'package:money_maker/screens/login/controller/login_controller.dart';
import 'package:money_maker/screens/register/view/register_screen.dart';
import 'package:money_maker/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/button_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:money_maker/widgets/text_field_widget.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _firstFieldController = TextEditingController();
  final FocusNode _firstFieldFocusNode = FocusNode();
  final errorFirstFieldMessage = RxString('');

  final TextEditingController _passController = TextEditingController();
  final FocusNode _passFocusNode = FocusNode();
  final errorPassMessage = RxString('');
  final GlobalKey<FormState> _key = GlobalKey();
  final LoginController _loginController = Get.put(LoginController());
  final showPassword = RxBool(true);

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: AppLocale().isArabic()
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async {
                      final newLocale = AppLocale().isArabic()
                          ? const Locale('en')
                          : const Locale('ar');

                      await AppLocale().setLocale(newLocale);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.buttonColor.withAlpha(64)),
                        color: AppColors.buttonColor.withAlpha(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           Icon(Icons.language, size: 18.sp),
                           SizedBox(width: 2.w),
                          Text(
                            AppLocale().isArabic() ? 'EN' : 'AR',
                            style: Styles().smallText.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  appLogo,
                  width: AppSize.logoWidthSignUpLogIn,
                  height: AppSize.logoHeightSignUpLogIn,
                  fit: BoxFit.cover,
                ),
                Text(S.of(context).logIn, style: Styles().bigText),
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _firstFieldController,
                  focusNode: _firstFieldFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  hint: S.of(context).email,
                  prefixIcon: Icon(Icons.person),
                  onSubmitted: (v) => _passFocusNode.requestFocus(),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorFirstFieldMessage.value =
                      S.of(context).pleaseEnterYourValidEmail;
                      return "";
                    }
                    if (v.length < 5) {
                      errorFirstFieldMessage.value =
                      S.of(context).pleaseEnterYourValidEmail;
                      return "";
                    }
                    if (v.contains(" ")) {
                      errorFirstFieldMessage.value =
                      S.of(context).pleaseEnterYourValidEmail;
                      return "";
                    }
                    if (!isValidEmail(v)) {
                      errorFirstFieldMessage.value =
                      S.of(context).pleaseEnterYourValidEmail;
                      return "";
                    }
                    return null;
                  },
                ),
                Obx(() {
                  return errorFirstFieldMessage.isNotEmpty
                      ? _errorText(errorFirstFieldMessage.value)
                      : const SizedBox.shrink();
                }),
                SizedBox(height: AppSize.heightBetweenTextField),
                Obx(()=>
                    TextFieldWidget(
                      controller: _passController,
                      focusNode: _passFocusNode,
                      isObscure: showPassword.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          showPassword.value = !showPassword.value;
                        },
                        icon: Icon(
                          showPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.buttonColor,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      keyboardType: TextInputType.multiline,
                      hint: S.of(context).password,
                      onSubmitted: (v) => FocusManager.instance.primaryFocus?.unfocus(),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          errorPassMessage.value =
                              S.of(context).thePasswordMustBeAtLeast6CharactersOrDigits;
                          return "";
                        }
                        if (v.length < 6) {
                          errorPassMessage.value =
                              S.of(context).thePasswordMustBeAtLeast6CharactersOrDigits;
                          return "";
                        }
                        return null;
                      },
                    ),
                ),
                Obx(() {
                  return errorPassMessage.isNotEmpty
                      ? _errorText(errorPassMessage.value)
                      : const SizedBox.shrink();
                }),
                GestureDetector(
                  onTap: (){
                    AppNavigator.of(context).push(ForgotPasswordScreen());
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 8),
                    alignment: AppLocale().isArabic()?Alignment.bottomLeft:Alignment.bottomRight,
                    child: Text(S.of(context).forgotPasswordL, style: Styles().smallText),
                  ),
                ),
                SizedBox(height: AppSize.heightBetweenTextField),
                ButtonWidget(
                  color: AppColors.buttonColor,
                  border: AppSize.radiusButtonSignInSignUp,
                  onTap: () async {
                    errorPassMessage.value = '';
                    errorFirstFieldMessage.value = '';
                    final navigator = AppNavigator.of(context);
                    if (_key.currentState!.validate()) {
                      final success = await _loginController.login(
                        email: _firstFieldController.text.trim(),
                        password: _passController.text.trim(),
                      );
                      if (success) {
                        final user = Get.find<SessionController>().user;

                        if (user?.hasCompanies == true &&
                            user!.companies.isNotEmpty) {

                          final company = user.companies.first;

                          if (company.status == "pending") {
                            // navigator.push(
                            //   CompanyOverviewScreen(
                            //     logoUrl: company.logo,
                            //     companyName: company.name,
                            //     founderName: company.founderName,
                            //     category: company.categoryId.toString(),
                            //     description: company.description,
                            //   ),
                            // );
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
                      }
                    }
                  },
                  child: Text(S.of(context).logIn, style: Styles().buttonText),
                ),
                SizedBox(height: AppSize.heightBetweenTextAndButton),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(S.of(context).dontHaveAnAccount, style: Styles().midText),
                  GestureDetector(
                    onTap: (){
                      AppNavigator.of(context).push(RegisterScreen());
                    },
                    child: Text(S.of(context).signUp, style: Styles().mainText),
                  ),
                ],),
                SizedBox(height: 5.h),
                CommonViews().customClickableText(
                  textContent: S.of(context).continueAsGuest,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  fontSize: 17.sp,
                  onTap: () {
                    AppNavigator.of(context).push(BottomNavBarScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  bool isValidEmail(String value) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    return RegExp(pattern).hasMatch(value);
  }

  Padding _errorText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: Styles().errorText,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
