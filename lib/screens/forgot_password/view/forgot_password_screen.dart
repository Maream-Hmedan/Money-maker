import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/forgot_password/controller/forgot_pass_controller.dart';
import 'package:money_maker/screens/login/view/login_screen.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/button_widget.dart';
import 'package:money_maker/widgets/text_field_widget.dart';



class ForgotPasswordScreen extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final errorEmailMessage = RxString('');

  final ForgotPasswordController _forgetPass = Get.put(ForgotPasswordController());


  final GlobalKey<FormState> _key = GlobalKey();

  ForgotPasswordScreen({super.key});

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
                Image.asset(
                  appLogo,
                  width: AppSize.logoWidthSignUpLogIn,
                  height: AppSize.logoHeightSignUpLogIn,
                  fit: BoxFit.cover,
                ),
                Text(S.of(context).forgotPassword, style: Styles().bigText),
                SizedBox(height: AppSize.heightBetweenTextField),
                Text(S.of(context).enterYourEmailToResetYourPassword, style: Styles().midText),
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  hint: S.of(context).email,
                  onSubmitted: (v) => FocusManager.instance.primaryFocus?.unfocus(),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorEmailMessage.value =
                      S.of(context).pleaseVerifyTheEmailAddress;
                      return "";
                    }
                    if (v.length < 5) {
                      errorEmailMessage.value =
                      S.of(context).pleaseVerifyTheEmailAddress;
                      return "";
                    }
                    if (v.contains(" ")) {
                      errorEmailMessage.value =
                      S.of(context).pleaseVerifyTheEmailAddress;
                      return "";
                    }
                    if (!isValidEmail(v)) {
                      errorEmailMessage.value =
                      S.of(context).pleaseVerifyTheEmailAddress;
                      return "";
                    }
                    return null;
                  },
                ),
                Obx(() {
                  return errorEmailMessage.isNotEmpty
                      ? _errorText(errorEmailMessage.value)
                      : const SizedBox.shrink();
                }),
                SizedBox(height: AppSize.heightBetweenTextAndButton),
                ButtonWidget(
                  color: AppColors.buttonColor,
                  border: AppSize.radiusButtonSignInSignUp,
                  onTap: () {
                    errorEmailMessage.value='';
                    if (_key.currentState!.validate()) {
                      _forgetPass.forgotPassword(email: _emailController.text.trim());
                    }
                  },
                  child: Text(S.of(context).send, style: Styles().buttonText),
                ),
                SizedBox(height: AppSize.heightBetweenTextAndButton),
                Text(S.of(context).goBackTo, style: Styles().midText),
                GestureDetector(
                    onTap: (){
                      _forgetPass.forgotPassword(email: _emailController.text.trim());
                      AppNavigator.of(context).push(LoginScreen());
                    },
                    child: Text(S.of(context).signIn, style: Styles().mainText)),
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
