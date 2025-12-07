import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:money_maker/screens/get_countries/controller/countries_controller.dart';
import 'package:money_maker/screens/get_countries/model/countries_response.dart';
import 'package:money_maker/screens/profile/controller/get_profile_controller.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/button_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:money_maker/widgets/text_field_widget.dart';
import 'package:sizer/sizer.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _key = GlobalKey<FormState>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  final errorNameMessage = RxString('');
  final errorEmailMessage = RxString('');
  final errorPhoneMessage = RxString('');

  final ProfileController _profileController = Get.put(ProfileController());
  final CountriesController _countriesController = Get.put(CountriesController());


  @override
  void initState() {
    super.initState();
    // Load profile and countries
    _profileController.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: true,
      child: GetBuilder<ProfileController>(
        builder: (controller) {
          if (controller.isLoading) {
            return  Center(child: SpinKitCircle(color: AppColors.darkBrandColor, size: 30.sp),);
          }
          return Form(
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
                    Text(
                      S.of(context).yourPersonalInfoAndAccountDetails,
                      style: Styles().midText,
                    ),
                    SizedBox(height: AppSize.heightBetweenTextField),
                    TextFieldWidget(
                      controller: _profileController.nameController,
                      focusNode: _nameFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      hint: 'Full Name',
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
                      controller: _profileController.emailController,
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
                      builder: (_) {
                        return DropdownSearch<Countries>(
                          items: _countriesController.countries,
                          selectedItem: controller.selectedCountry,
                          enabled: _countriesController.countries.isNotEmpty,
                          onChanged: (value) {
                            controller.setSelectedCountry(value);
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
                              hintText: S.of(context).selectCountry,
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
                                textContent: S.of(context).selectCountry,
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
                                  inputDecorationTheme:
                                  const InputDecorationTheme(isDense: true),
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
                                borderRadius: BorderRadius.circular(
                                  4,
                                ),
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
                        controller: _profileController.phoneController,
                        focusNode: _phoneFocusNode,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        prefixText: '${_profileController.dialCode.value} | ',
                        hint: S.of(context).phoneNumber,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            errorPhoneMessage.value =
                                S.of(context).pleaseVerifyThePhoneNumber;
                            return "";
                          }
                          if (v.length < 9 || v.length > 10) {
                            errorPhoneMessage.value =
                                S.of(context).pleaseEnterAValidPhoneNumber;
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
                    ButtonWidget(
                      color: AppColors.buttonColor,
                      border: AppSize.radiusButtonSignInSignUp,
                      onTap: () {
                        errorNameMessage.value = '';
                        errorEmailMessage.value = '';
                        errorPhoneMessage.value = '';
                        if (_key.currentState!.validate()) {
                          AppNavigator.of(context).push(BottomNavBarScreen());
                        }
                      },
                      child: Text(S.of(context).save, style: Styles().buttonText),
                    ),
                    SizedBox(height: AppSize.heightBetweenTextAndButton),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _errorText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: Text(
          text,
          style: const TextStyle(color: Colors.red, fontSize: 12),
        ),
      ),
    );
  }

  bool isValidEmail(String value) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    return RegExp(pattern).hasMatch(value);
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
    );
  }
}

//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//
//   final FocusNode _nameFocusNode = FocusNode();
//
//   final errorNameMessage = RxString('');
//
//
//   final FocusNode _countryFocusNode = FocusNode();
//
//   final errorCountryMessage = RxString('');
//
//
//   final FocusNode _emailFocusNode = FocusNode();
//
//   final errorEmailMessage = RxString('');
//
//   final FocusNode _phoneFocusNode = FocusNode();
//
//   final errorPhoneMessage = RxString('');
//   final GlobalKey<FormState> _key = GlobalKey();
//
//   final _profileController = Get.put(ProfileController());
//   final String _dialCode = '+962';
//   Countries? selectedCountry;
//
//   @override
//   void initState() {
//     super.initState();
//     Get.put(CountriesController());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CommonBackground(
//       showAppBar: true,
//       child: GetBuilder<ProfileController>(
//         builder: (controller) {
//           if (controller.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           return Form(
//             key: _key,
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Image.asset(
//                       appLogo,
//                       width: AppSize.logoWidthSignUpLogIn,
//                       height: AppSize.logoHeightSignUpLogIn,
//                       fit: BoxFit.cover,
//                     ),
//                     Text(
//                       S.of(context).yourPersonalInfoAndAccountDetails,
//                       style: Styles().midText,
//                     ),
//                     SizedBox(height: AppSize.heightBetweenTextField),
//                     TextFieldWidget(
//                       controller: _profileController.nameController,
//                       focusNode: _nameFocusNode,
//                       keyboardType: TextInputType.emailAddress,
//                       hint: 'Full Name',
//                       onSubmitted: (v) => _emailFocusNode.requestFocus(),
//                       validator: (v) {
//                         if (v == null || v.isEmpty) {
//                           errorNameMessage.value =
//                               S.of(context).pleaseEnterYourName;
//                           return "";
//                         }
//                         return null;
//                       },
//                     ),
//                     Obx(() {
//                       return errorNameMessage.isNotEmpty
//                           ? _errorText(errorNameMessage.value)
//                           : const SizedBox.shrink();
//                     }),
//                     SizedBox(height: AppSize.heightBetweenTextField),
//                     TextFieldWidget(
//                       controller: _profileController.emailController,
//                       focusNode: _emailFocusNode,
//                       keyboardType: TextInputType.emailAddress,
//                       onSubmitted: (v) => _countryFocusNode.requestFocus(),
//                       hint: 'Email',
//                       validator: (v) {
//                         if (v == null || v.isEmpty) {
//                           errorEmailMessage.value =
//                               S.of(context).pleaseVerifyTheEmailAddress;
//                           return "";
//                         }
//                         if (v.length < 5) {
//                           errorEmailMessage.value =
//                               S.of(context).pleaseVerifyTheEmailAddress;
//                           return "";
//                         }
//                         if (v.contains(" ")) {
//                           errorEmailMessage.value =
//                               S.of(context).pleaseVerifyTheEmailAddress;
//                           return "";
//                         }
//                         if (!isValidEmail(v)) {
//                           errorEmailMessage.value =
//                               S.of(context).pleaseVerifyTheEmailAddress;
//                           return "";
//                         }
//                         return null;
//                       },
//                     ),
//                     Obx(() {
//                       return errorEmailMessage.isNotEmpty
//                           ? _errorText(errorEmailMessage.value)
//                           : const SizedBox.shrink();
//                     }),
//                     SizedBox(height: AppSize.heightBetweenTextField),
//                     GetBuilder<CountriesController>(
//                       builder: (controller) {
//                         return DropdownSearch<Countries>(
//                           items: controller.countries,
//                           selectedItem:
//                               _profileController.selectedCountry.value,
//                           enabled: controller.countries.isNotEmpty,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedCountry = value;
//                             });
//                           },
//                           itemAsString:
//                               (Countries? item) => item?.name.toString() ?? '',
//                           dropdownButtonProps: const DropdownButtonProps(
//                             icon: Icon(
//                               Icons.keyboard_arrow_down,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           dropdownDecoratorProps: DropDownDecoratorProps(
//                             dropdownSearchDecoration: InputDecoration(
//                               hintText:
//                                   selectedCountry == null
//                                       ? S.of(context).selectCountry
//                                       : '',
//                               hintStyle: TextStyle(
//                                 fontSize: 15.sp,
//                                 color: Colors.grey,
//                               ),
//                               filled: true,
//                               fillColor: Colors.transparent,
//                               contentPadding: EdgeInsets.symmetric(
//                                 vertical: 2.5.h,
//                                 horizontal: 3.w,
//                               ),
//                               focusedBorder: buildOutlineInputBorder(),
//                               disabledBorder: buildOutlineInputBorder(),
//                               enabledBorder: buildOutlineInputBorder(),
//                             ),
//                           ),
//                           dropdownBuilder: (context, item) {
//                             if (item == null) {
//                               return CommonViews().customText(
//                                 textContent: 'Select Country',
//                                 textColor: Colors.grey,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w400,
//                               );
//                             }
//                             return Row(
//                               children: [
//                                 if (item.image.isNotEmpty)
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(1.w),
//                                     child: CachedNetworkImage(
//                                       imageUrl: item.image,
//                                       width: 7.w,
//                                       height: 2.3.h,
//                                       fit: BoxFit.cover,
//                                       placeholder:
//                                           (context, url) => Container(
//                                             width: 7.w,
//                                             height: 2.3.h,
//                                             color: Colors.grey.shade200,
//                                           ),
//                                       errorWidget:
//                                           (context, url, error) => Icon(
//                                             Icons.flag_outlined,
//                                             color: Colors.grey,
//                                             size: 12.sp,
//                                           ),
//                                     ),
//                                   ),
//                                 SizedBox(width: 2.2.w),
//                                 CommonViews().customText(
//                                   textContent: item.name.toString(),
//                                   textColor: Colors.black,
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ],
//                             );
//                           },
//
//                           popupProps: PopupProps.menu(
//                             showSearchBox: true,
//                             searchFieldProps: TextFieldProps(
//                               decoration: InputDecoration(
//                                 hintText: 'Search Country',
//                                 prefixIcon: const Icon(
//                                   Icons.search,
//                                   color: Colors.grey,
//                                 ),
//                                 hintStyle: TextStyle(
//                                   fontSize: 15.sp,
//                                   color: Colors.grey,
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: Colors.grey.shade300,
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: Colors.grey.shade400,
//                                   ),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 8,
//                                 ),
//                               ),
//                             ),
//                             containerBuilder: (context, popupWidget) {
//                               return Theme(
//                                 data: Theme.of(context).copyWith(
//                                   inputDecorationTheme:
//                                       const InputDecorationTheme(isDense: true),
//                                 ),
//                                 child: Container(
//                                   constraints: BoxConstraints(maxHeight: 50.h),
//                                   color: Colors.white,
//                                   child: popupWidget,
//                                 ),
//                               );
//                             },
//                             itemBuilder:
//                                 (context, item, isSelected) => ListTile(
//                                   dense: true,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 12,
//                                     vertical: 4,
//                                   ),
//                                   leading:
//                                       item.image.isNotEmpty
//                                           ? ClipRRect(
//                                             borderRadius: BorderRadius.circular(
//                                               4,
//                                             ),
//                                             child: CachedNetworkImage(
//                                               imageUrl: item.image,
//                                               width: 30,
//                                               height: 22,
//                                               fit: BoxFit.cover,
//                                               placeholder:
//                                                   (context, url) => Container(
//                                                     width: 30,
//                                                     height: 22,
//                                                     color: Colors.grey.shade200,
//                                                   ),
//                                               errorWidget:
//                                                   (context, url, error) =>
//                                                       const Icon(
//                                                         Icons.flag_outlined,
//                                                         color: Colors.grey,
//                                                         size: 20,
//                                                       ),
//                                             ),
//                                           )
//                                           : const Icon(
//                                             Icons.flag_outlined,
//                                             color: Colors.grey,
//                                           ),
//                                   title: CommonViews().customText(
//                                     textContent: item.name.toString(),
//                                     textColor: Colors.black,
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                           ),
//                         );
//                       },
//                     ),
//                     SizedBox(height: AppSize.heightBetweenTextField),
//                     TextFieldWidget(
//                       controller: _profileController.phoneController,
//                       focusNode: _phoneFocusNode,
//                       onSubmitted: (v) => _countryFocusNode.requestFocus(),
//                       keyboardType: TextInputType.phone,
//                       prefixText: '$_dialCode | ',
//                       hint: S.of(context).phoneNumber,
//                       validator: (v) {
//                         if (v == null || v.isEmpty) {
//                           errorPhoneMessage.value =
//                               S.of(context).pleaseVerifyThePhoneNumber;
//                           return "";
//                         }
//                         if (v.length < 9 || v.length > 10) {
//                           errorPhoneMessage.value =
//                               S.of(context).pleaseEnterAValidPhoneNumber;
//                           return "";
//                         }
//                         return null;
//                       },
//                     ),
//                     Obx(() {
//                       return errorPhoneMessage.isNotEmpty
//                           ? _errorText(errorPhoneMessage.value)
//                           : const SizedBox.shrink();
//                     }),
//                     SizedBox(height: AppSize.heightBetweenTextField),
//                     ButtonWidget(
//                       color: AppColors.buttonColor,
//                       border: AppSize.radiusButtonSignInSignUp,
//                       onTap: () {
//                         errorNameMessage.value = '';
//                         errorEmailMessage.value = '';
//                         errorPhoneMessage.value = '';
//                         if (_key.currentState!.validate()) {
//                           AppNavigator.of(context).push(BottomNavBarScreen());
//                         }
//                       },
//                       child: Text(S.of(context).save, style: Styles().buttonText),
//                     ),
//                     SizedBox(height: AppSize.heightBetweenTextAndButton),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   bool isValidEmail(String value) {
//     const pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
//     return RegExp(pattern).hasMatch(value);
//   }
//
//   Padding _errorText(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         text,
//         style: Styles().errorText,
//         maxLines: 2,
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
//
//   OutlineInputBorder buildOutlineInputBorder() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
//     );
//   }
// }
