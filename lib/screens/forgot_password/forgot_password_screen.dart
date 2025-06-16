import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/screens/login/login_screen.dart';
import 'package:money_maker/wigets/background_widget.dart';
import 'package:money_maker/wigets/button_widget.dart';
import 'package:money_maker/wigets/text_field_widget.dart';


class ForgotPasswordScreen extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final errorEmailMessage = RxString('');


  final GlobalKey<FormState> _key = GlobalKey();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  appLogo,
                  width: AppSize.logoWidthSignUpLogIn,
                  height: AppSize.logoHeightSignUpLogIn,
                  fit: BoxFit.cover,
                ),
                Text('Forgot Password', style: Styles().bigText),
                SizedBox(height: AppSize.heightBetweenTextField),
                Text("Enter your email to reset your password.", style: Styles().midText),
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Email',
                  onSubmitted: (v) => FocusManager.instance.primaryFocus?.unfocus(),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorEmailMessage.value =
                      "Please verify the email address.";
                      return "";
                    }
                    if (v.length < 5) {
                      errorEmailMessage.value =
                      "Please verify the email address.";
                      return "";
                    }
                    if (v.contains(" ")) {
                      errorEmailMessage.value =
                      "Please verify the email address.";
                      return "";
                    }
                    if (!isValidEmail(v)) {
                      errorEmailMessage.value =
                      "Please verify the email address.";
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
                      AppNavigator.of(context).push(LoginScreen());
                    }
                  },
                  child: Text('Send', style: Styles().buttonText),
                ),
                SizedBox(height: AppSize.heightBetweenTextAndButton),
                Text("Go Back To ", style: Styles().midText),
                GestureDetector(
                    onTap: (){
                      AppNavigator.of(context).push(LoginScreen());
                    },
                    child: Text("Sign In", style: Styles().mainText)),
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
