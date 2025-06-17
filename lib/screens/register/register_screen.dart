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
import 'package:money_maker/wigets/country_selector_widget.dart';
import 'package:money_maker/wigets/text_field_widget.dart';
import 'package:sizer/sizer.dart';


class RegisterScreen extends StatefulWidget {
   const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();

  final errorNameMessage = RxString('');

   final TextEditingController _countryController = TextEditingController();

   final FocusNode _countryFocusNode = FocusNode();

   final errorCountryMessage = RxString('');

   final TextEditingController _emailController = TextEditingController();

   final FocusNode _emailFocusNode = FocusNode();

   final errorEmailMessage = RxString('');

   final TextEditingController _phoneController = TextEditingController();

   final FocusNode _phoneFocusNode = FocusNode();

   final errorPhoneMessage = RxString('');

  final TextEditingController _passController = TextEditingController();

  final FocusNode _passFocusNode = FocusNode();

  final errorPassMessage = RxString('');

   final TextEditingController _confirmPassController = TextEditingController();

   final FocusNode _confirmPassFocusNode = FocusNode();

   final errorConfirmPassMessage = RxString('');

  final GlobalKey<FormState> _key = GlobalKey();

   String _dialCode = '+962';

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
                Text('Create Account', style: Styles().bigText),
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Full Name',
                  onSubmitted: (v) => _emailFocusNode.requestFocus(),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorNameMessage.value = "Please enter your name.";
                      return "";
                    }
                    return null;
                  },
                ),
                Obx(() {
                  return errorNameMessage.isNotEmpty
                      ? _errorText(errorNameMessage.value)
                      : const SizedBox.shrink();
                }),
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  onSubmitted: (v) => _countryFocusNode.requestFocus(),
                  hint: 'Email',
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
                SizedBox(height: AppSize.heightBetweenTextField),
                CountrySelectorField(controller: _countryController,
                  focusNode: _countryFocusNode,
                  onSubmitted:(v) =>  _phoneFocusNode.requestFocus(),
                  onCountryChanged: (country) {
                    setState(() => _dialCode = '+${country.phoneCode}');
                    _phoneController.clear();
                  },
                ),
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  onSubmitted: (v) => _passFocusNode.requestFocus(),
                  keyboardType: TextInputType.phone,
                  prefixText: '$_dialCode | ',
                  hint: 'Phone Number',
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorPhoneMessage.value = "Please verify the phone number.";
                      return "";
                    }
                    if (v.length < 9 || v.length > 10) {
                      errorPhoneMessage.value = "Please enter a valid phone number.";
                      return "";
                    }
                    return null;
                  },
                ),
                Obx(() {
                  return errorPhoneMessage.isNotEmpty
                      ? _errorText(errorPhoneMessage.value)
                      : const SizedBox.shrink();
                }),
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _passController,
                  focusNode: _passFocusNode,
                  keyboardType: TextInputType.multiline,
                  onSubmitted: (v) => _confirmPassFocusNode.requestFocus(),
                  hint: 'Password',
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
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _confirmPassController,
                  focusNode: _confirmPassFocusNode,
                  keyboardType: TextInputType.multiline,
                  hint: 'Confirm Password',
                  onSubmitted: (v) => FocusManager.instance.primaryFocus?.unfocus(),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorConfirmPassMessage.value =
                      "The password must be at least 6 characters or digits long.";
                      return "";
                    }
                    if (v.length < 6) {
                      errorConfirmPassMessage.value =
                      "The password must be at least 6 characters or digits long.";
                      return "";
                    }
                    if (v !=_passController.text ) {
                      errorConfirmPassMessage.value =
                      "Please make sure both passwords are the same.";
                      return "";
                    }
                    return null;
                  },
                ),
                Obx(() {
                  return errorConfirmPassMessage.isNotEmpty
                      ? _errorText(errorConfirmPassMessage.value)
                      : const SizedBox.shrink();
                }),
                SizedBox(height: AppSize.heightBetweenTextField),
                ButtonWidget(
                  color: AppColors.buttonColor,
                  border: AppSize.radiusButtonSignInSignUp,
                  onTap: () {
                    errorNameMessage.value = '';
                    errorEmailMessage.value='';
                    errorPhoneMessage.value='';
                    errorPassMessage.value = '';
                    errorConfirmPassMessage.value='';
                    if (_key.currentState!.validate()) {
                      AppNavigator.of(context).push(LoginScreen());
                    }
                  },
                  child: Text('Sign Up', style: Styles().buttonText),
                ),
                SizedBox(height: AppSize.heightBetweenTextAndButton),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: Styles().midText),
                  GestureDetector(
                      onTap: (){
                        AppNavigator.of(context).push(LoginScreen());
                      },
                      child: Text("Sign In", style: Styles().mainText)),
                ],),
                SizedBox(height: 1.h,),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Styles().bottomText,
                children: [
                  const TextSpan(text: 'By signing up, you agree to our '),

                  TextSpan(
                    text: 'Terms',
                    style: Styles()
                        .bottomText
                        .copyWith(color: const Color(0xFF380E87)),
                  ),

                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: Styles()
                        .bottomText
                        .copyWith(color: const Color(0xFF380E87)),
                  ),
                ],
              ),
            ),
                SizedBox(height: 1.h,),
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
