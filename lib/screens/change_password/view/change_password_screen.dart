import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/change_password/controller/reset_pass_controller.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/button_widget.dart';
import 'package:money_maker/widgets/text_field_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordController _changePass = Get.put(
    ChangePasswordController(),
  );
  final TextEditingController _passController = TextEditingController();

  final FocusNode _passFocusNode = FocusNode();

  final errorPassMessage = RxString('');

  final TextEditingController _confirmPassController = TextEditingController();

  final FocusNode _confirmPassFocusNode = FocusNode();

  final errorConfirmPassMessage = RxString('');

  final GlobalKey<FormState> _key = GlobalKey();

  final showPassword = RxBool(true);
  final showConfirmPassword = RxBool(true);

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
                Text(S.of(context).changeYourPassword, style: Styles().bigText),
                SizedBox(height: AppSize.heightBetweenTextField),
                Obx(
                  () => TextFieldWidget(
                    controller: _passController,
                    focusNode: _passFocusNode,
                    keyboardType: TextInputType.multiline,
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
                    onSubmitted: (v) => _confirmPassFocusNode.requestFocus(),
                    hint: S.of(context).password,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        errorPassMessage.value =
                            S
                                .of(context)
                                .thePasswordMustBeAtLeast6CharactersOrDigits;
                        return "";
                      }
                      if (v.length < 6) {
                        errorPassMessage.value =
                            S
                                .of(context)
                                .thePasswordMustBeAtLeast6CharactersOrDigits;
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
                SizedBox(height: AppSize.heightBetweenTextField),
                Obx(
                  () => TextFieldWidget(
                    controller: _confirmPassController,
                    focusNode: _confirmPassFocusNode,
                    keyboardType: TextInputType.multiline,
                    hint: S.of(context).confirmPassword,
                    isObscure: showConfirmPassword.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        showConfirmPassword.value = !showConfirmPassword.value;
                      },
                      icon: Icon(
                        showConfirmPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.buttonColor,
                      ),
                    ),
                    onSubmitted:
                        (v) => FocusManager.instance.primaryFocus?.unfocus(),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        errorConfirmPassMessage.value =
                            S
                                .of(context)
                                .thePasswordMustBeAtLeast6CharactersOrDigits;
                        return "";
                      }
                      if (v.length < 6) {
                        errorConfirmPassMessage.value =
                            S
                                .of(context)
                                .thePasswordMustBeAtLeast6CharactersOrDigits;
                        return "";
                      }
                      if (v != _passController.text) {
                        errorConfirmPassMessage.value =
                            S.of(context).pleaseMakeSureBothPasswordsAreTheSame;
                        return "";
                      }
                      return null;
                    },
                  ),
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
                    errorConfirmPassMessage.value = '';
                    if (_key.currentState!.validate()) {
                      _changePass.resetPassword(
                        password: _passController.text.trim(),
                        passwordConfirmation:
                            _confirmPassController.text.trim(),
                      );
                    }
                  },
                  child: Text(
                    S.of(context).setNewPassword,
                    style: Styles().buttonText,
                  ),
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
