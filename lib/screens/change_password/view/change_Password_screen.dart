import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/button_widget.dart';
import 'package:money_maker/widgets/text_field_widget.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passController = TextEditingController();

  final FocusNode _passFocusNode = FocusNode();

  final errorPassMessage = RxString('');

  final TextEditingController _confirmPassController = TextEditingController();

  final FocusNode _confirmPassFocusNode = FocusNode();

  final errorConfirmPassMessage = RxString('');

  final GlobalKey<FormState> _key = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: true,
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
                Text('Change Your Password', style: Styles().bigText),
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _passController,
                  focusNode: _passFocusNode,
                  keyboardType: TextInputType.multiline,
                  isObscure: true,
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
                    errorPassMessage.value = '';
                    errorConfirmPassMessage.value='';
                    if (_key.currentState!.validate()) {
                      AppNavigator.of(context).push(BottomNavBarScreen());
                    }
                  },
                  child: Text('Set New Password', style: Styles().buttonText),
                ),
                SizedBox(height: AppSize.heightBetweenTextAndButton),
              ],
            ),
          ),
        ),
      ),
    );
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
