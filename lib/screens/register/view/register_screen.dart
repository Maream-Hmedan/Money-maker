import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/get_countries/controller/countries_controller.dart';
import 'package:money_maker/screens/get_countries/model/countries_response.dart';
import 'package:money_maker/screens/login/view/login_screen.dart';
import 'package:money_maker/screens/register/controller/register_controller.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/button_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:money_maker/widgets/text_field_widget.dart';
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

  final RegisterController _registerController = Get.put(RegisterController());

  Countries? selectedCountry;

  final prefix = ''.obs;

  @override
  void initState() {
    super.initState();
    Get.put(CountriesController());
  }

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
                Text(S.of(context).createAccount, style: Styles().bigText),
                SizedBox(height: AppSize.heightBetweenTextField),
                TextFieldWidget(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  hint: S.of(context).fullName,
                  onSubmitted: (v) => _emailFocusNode.requestFocus(),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorNameMessage.value =
                          S.of(context).pleaseEnterYourName;
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
                  hint: S.of(context).email,
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
                SizedBox(height: AppSize.heightBetweenTextField),
                GetBuilder<CountriesController>(
                  builder: (controller) {
                    Countries? defaultCountry;
                    if (controller.countries.isNotEmpty) {
                      defaultCountry = controller.countries.firstWhere(
                        (c) => c.name.toLowerCase().contains('jordan'),
                        orElse: () => controller.countries.first,
                      );
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        prefix.value = selectedCountry?.prefix ?? '';
                      });
                    }

                    selectedCountry ??= defaultCountry;

                    return DropdownSearch<Countries>(
                      items: controller.countries,
                      selectedItem: selectedCountry,
                      enabled: controller.countries.isNotEmpty,
                      onChanged: (value) {
                        setState(() {
                          selectedCountry = value;
                          prefix.value = selectedCountry?.prefix ?? '';
                        });
                      },
                      itemAsString:
                          (Countries? item) => item?.name.toString() ?? '',
                      dropdownButtonProps: const DropdownButtonProps(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintText:
                              selectedCountry == null
                                  ? S.of(context).selectCountry
                                  : '',
                          hintStyle: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 2.5.h,
                            horizontal: 3.w,
                          ),
                          focusedBorder: buildOutlineInputBorder(),
                          disabledBorder: buildOutlineInputBorder(),
                          enabledBorder: buildOutlineInputBorder(),
                        ),
                      ),
                      dropdownBuilder: (context, item) {
                        if (item == null) {
                          return CommonViews().customText(
                            textContent: 'Select Country',
                            textColor: Colors.grey,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          );
                        }
                        return Row(
                          children: [
                            if (item.image.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(1.w),
                                child: CachedNetworkImage(
                                  imageUrl: item.image,
                                  width: 7.w,
                                  height: 2.3.h,
                                  fit: BoxFit.cover,
                                  placeholder:
                                      (context, url) => Container(
                                        width: 7.w,
                                        height: 2.3.h,
                                        color: Colors.grey.shade200,
                                      ),
                                  errorWidget:
                                      (context, url, error) => Icon(
                                        Icons.flag_outlined,
                                        color: Colors.grey,
                                        size: 12.sp,
                                      ),
                                ),
                              ),
                            SizedBox(width: 2.2.w),
                            CommonViews().customText(
                              textContent: item.name.toString(),
                              textColor: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        );
                      },

                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: 'Search Country',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                        containerBuilder: (context, popupWidget) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              inputDecorationTheme: const InputDecorationTheme(
                                isDense: true,
                              ),
                            ),
                            child: Container(
                              constraints: BoxConstraints(maxHeight: 50.h),
                              color: Colors.white,
                              child: popupWidget,
                            ),
                          );
                        },
                        itemBuilder:
                            (context, item, isSelected) => ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              leading:
                                  item.image.isNotEmpty
                                      ? ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CachedNetworkImage(
                                          imageUrl: item.image,
                                          width: 30,
                                          height: 22,
                                          fit: BoxFit.cover,
                                          placeholder:
                                              (context, url) => Container(
                                                width: 30,
                                                height: 22,
                                                color: Colors.grey.shade200,
                                              ),
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Icon(
                                                    Icons.flag_outlined,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                        ),
                                      )
                                      : const Icon(
                                        Icons.flag_outlined,
                                        color: Colors.grey,
                                      ),
                              title: CommonViews().customText(
                                textContent: item.name.toString(),
                                textColor: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSize.heightBetweenTextField),
                Obx(() {
                  return TextFieldWidget(
                    controller: _phoneController,
                    focusNode: _phoneFocusNode,
                    onSubmitted: (v) => _passFocusNode.requestFocus(),
                    keyboardType: TextInputType.phone,
                    prefixText: '${prefix.value} | ',
                    hint: 'Phone Number',
                    maxLength: 10,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        errorPhoneMessage.value =
                            "Please verify the phone number.";
                        return "";
                      }
                      if (v.length < 9 || v.length > 10) {
                        errorPhoneMessage.value =
                            "Please enter a valid phone number.";
                        return "";
                      }
                      return null;
                    },
                  );
                }),
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
                  isObscure: true,
                  onSubmitted: (v) => _confirmPassFocusNode.requestFocus(),
                  hint: S.of(context).password,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorPassMessage.value =
                          S
                              .of(context)
                              .thePasswordMustBeAtLeast8CharactersOrDigits;
                      return "";
                    }
                    if (v.length < 8) {
                      errorPassMessage.value =
                          S
                              .of(context)
                              .thePasswordMustBeAtLeast8CharactersOrDigits;
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
                  isObscure: true,
                  hint: S.of(context).confirmPassword,
                  onSubmitted:
                      (v) => FocusManager.instance.primaryFocus?.unfocus(),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      errorConfirmPassMessage.value =
                          S
                              .of(context)
                              .thePasswordMustBeAtLeast8CharactersOrDigits;
                      return "";
                    }
                    if (v.length < 8) {
                      errorConfirmPassMessage.value =
                          S
                              .of(context)
                              .thePasswordMustBeAtLeast8CharactersOrDigits;
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
                Obx(() {
                  return errorConfirmPassMessage.isNotEmpty
                      ? _errorText(errorConfirmPassMessage.value)
                      : const SizedBox.shrink();
                }),
                SizedBox(height: AppSize.heightBetweenTextField),
                ButtonWidget(
                  color: AppColors.buttonColor,
                  border: AppSize.radiusButtonSignInSignUp,
                  onTap: () async {
                    errorNameMessage.value = '';
                    errorEmailMessage.value = '';
                    errorPhoneMessage.value = '';
                    errorPassMessage.value = '';
                    errorConfirmPassMessage.value = '';
                    if (_key.currentState!.validate()) {
                      await _registerController.register(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passController.text.trim(),
                        confirmPassword: _confirmPassController.text.trim(),
                        mobile: _phoneController.text.trim(),
                        countryId: (selectedCountry?.id).toString(),
                      );
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
                      onTap: () {
                        AppNavigator.of(context).push(LoginScreen());
                      },
                      child: Text("Sign In", style: Styles().mainText),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Styles().bottomText,
                    children: [
                      const TextSpan(text: 'By signing up, you agree to our '),

                      TextSpan(
                        text: 'Terms',
                        style: Styles().bottomText.copyWith(
                          color: const Color(0xFF380E87),
                        ),
                      ),

                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: Styles().bottomText.copyWith(
                          color: const Color(0xFF380E87),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
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
