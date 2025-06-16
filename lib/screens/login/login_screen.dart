import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/screens/forgot_password/forgot_password_screen.dart';
import 'package:money_maker/screens/home/home_screen.dart';
import 'package:money_maker/screens/register/register_screen.dart';
import 'package:money_maker/wigets/background_widget.dart';
import 'package:money_maker/wigets/button_widget.dart';
import 'package:money_maker/wigets/text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _firstFieldController = TextEditingController();
  final FocusNode _firstFieldFocusNode = FocusNode();
  final errorFirstFieldMessage = RxString('');

  final TextEditingController _passController = TextEditingController();
  final FocusNode _passFocusNode = FocusNode();
  final errorPassMessage = RxString('');
  final GlobalKey<FormState> _key = GlobalKey();

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
                Text('Welcome Back!', style: Styles().bigText),
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _firstFieldController,
                  focusNode: _firstFieldFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Email or Phone Number',
                  onSubmitted: (v) => _passFocusNode.requestFocus(),
                  validator: _emailOrPhoneValidator,
                ),
                Obx(() {
                  return errorFirstFieldMessage.isNotEmpty
                      ? _errorText(errorFirstFieldMessage.value)
                      : const SizedBox.shrink();
                }),
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _passController,
                  focusNode: _passFocusNode,
                  keyboardType: TextInputType.multiline,
                  hint: 'Password',
                  onSubmitted: (v) => FocusManager.instance.primaryFocus?.unfocus(),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorPassMessage.value =
                          "The password must be at least 6 characters or digits long.";
                      return "";
                    }
                    if (v.length < 6) {
                      errorPassMessage.value =
                          "The password must be at least 6 characters or digits long.";
                      return "";
                    }
                    return null;
                  },
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
                    alignment: Alignment.bottomRight,
                    child: Text('Forgot Password?', style: Styles().smallText),
                  ),
                ),
                SizedBox(height: AppSize.heightBetweenTextField),
                ButtonWidget(
                  color: AppColors.buttonColor,
                  border: AppSize.radiusButtonSignInSignUp,
                  onTap: () {
                    errorPassMessage.value = '';
                    errorFirstFieldMessage.value = '';
                    if (_key.currentState!.validate()) {
                      AppNavigator.of(context).push(HomeScreen());
                    }
                  },
                  child: Text('Login', style: Styles().buttonText),
                ),
                SizedBox(height: AppSize.heightBetweenTextAndButton),
                Text("Don't have an account?", style: Styles().midText),
                GestureDetector(
                  onTap: (){
                    AppNavigator.of(context).push(RegisterScreen());
                  },
                  child: Text("Sign Up", style: Styles().mainText),
                ),
                // SizedBox(height: AppSize.heightLogoAndTextLogInSignUp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _emailOrPhoneValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      errorFirstFieldMessage.value = 'Please verify the input.';
      return '';
    }

    final value = v.trim();
    final bool isEmail = isValidEmail(value);
    final bool isPhone =
        value.length >= 9 &&
        value.length <= 10 &&
        RegExp(r'^\d+$').hasMatch(value);

    if (!isEmail && !isPhone) {
      errorFirstFieldMessage.value =
          'Please enter a valid email address or phone number.';
      return '';
    }
    return null;
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
