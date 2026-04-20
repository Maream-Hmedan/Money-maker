import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/get_countries/model/countries_response.dart';
import 'package:money_maker/screens/profile/model/edit_profile_request.dart';
import 'package:money_maker/screens/profile/model/edit_profile_response.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
import 'package:sizer/sizer.dart';

class ProfileController extends GetxController {
  bool isLoading = true;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyNameController = TextEditingController();

  Countries? selectedCountry;
  final RxString dialCode = ''.obs;


  String _originalName = '';
  String _originalEmail = '';
  String _originalPhone = '';
  Countries? _originalCountry;

  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  Future<void> getProfileData() async {
    isLoading = true;
    update();

    try {
      final url = Uri.parse(ApiEndPoint.PROFILE_URL);
      final token = GetStorage().read(ConstantValues.TOKEN);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );

      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone_number'] ?? '';

  if (data['companies'] != null && data['companies'].isNotEmpty) {
    companyNameController.text = data['companies'][0]['name'] ?? '';
  }
        if (data['country'] != null) {
          final countryData = data['country'];
          selectedCountry = Countries(
            name: countryData['name'] ?? '',
            isoCode: countryData['iso_code'] ?? '',
            image: countryData['image'] ?? '',
            order: countryData['order'] ?? 0,
            id: countryData['order'] ?? 1,
            prefix: countryData['prefix'],
          );
          dialCode.value = selectedCountry?.prefix ?? '';
        }

        _saveOriginalData();
      }
    } catch (e) {
      debugPrint('ERROR $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void _saveOriginalData() {
    _originalName = nameController.text;
    _originalEmail = emailController.text;
    _originalPhone = phoneController.text;
    _originalCountry = selectedCountry;
  }

  void resetToOriginalData() {
    nameController.text = _originalName;
    emailController.text = _originalEmail;
    phoneController.text = _originalPhone;
    selectedCountry = _originalCountry;
    dialCode.value = selectedCountry?.prefix ?? '';
    update();
  }

  bool get hasChanges {
    return nameController.text != _originalName ||
        emailController.text != _originalEmail ||
        phoneController.text != _originalPhone ||
        selectedCountry?.id != _originalCountry?.id;
  }

  Future<void> editProfileData({
    required String fullName,
    required String email,
    required String mobile,
    required String companyName,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      ProgressHud.shared.startLoading(Get.context!);
      final context = Get.context;
      if (context == null) {
        debugPrint('Context is null');
        return;
      }
      final url = Uri.parse(ApiEndPoint.EDIT_PROFILE_URL);
      final token = GetStorage().read(ConstantValues.TOKEN);
      final controller = Get.find<SessionController>();

      if (controller.user == null || controller.user!.companies.isEmpty) {
        ProgressHud.shared.stopLoading();

        AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.bottomSlide,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            title: S.of(context).companyNotFound,
            desc:
            S.of(context).noCompanyIsLinkedToYourAccountPleaseContactSupport,
            titleTextStyle: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            descTextStyle: TextStyle(fontSize: 15.sp, color: Colors.black87),
            btnOkText: S.of(context).ok,
            btnOkColor: Colors.orange,
            btnOkOnPress: (){}
        ).show();
        return;
      }

      final String companyId = controller.user!.companies.first.id.toString();

      final req = EditProfileRequest(
        name: fullName,
        email: email,
        phoneNumber: mobile, companyName: companyName, companyId:companyId,
      );

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/vnd.api+json',
        },
        body: req.toJson(),
      );

      if (response.statusCode != 200) {
        ProgressHud.shared.stopLoading();
        return;
      }

      final res = EditProfileResponse.fromRawJson(response.body);

      if (res.message == 'Profile updated successfully') {
        _saveOriginalData();
        GetStorage().write(ConstantValues.USER_EMAIL, res.user.email);
        ProgressHud.shared.stopLoading();
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: S.of(Get.context!).success,
          desc: S.of(Get.context!).yourProfileHasBeenUpdatedSuccessfully,
          btnOkOnPress: () {
          },
          btnOkText: S
              .of(Get.context!)
              .ok,
        ).show();
      } else {
        ProgressHud.shared.stopLoading();
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: S.of(Get.context!).updateFailed,
          desc: S.of(Get.context!).somethingWentWrongWhileUpdatingYourProfilePleaseTryAgain,
          btnOkText: S.of(Get.context!).ok,
          btnOkOnPress: () {},
        ).show();

        return;
      }
    } catch (e) {
      ProgressHud.shared.stopLoading();
      debugPrint('editProfileData ERROR: $e');
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        title: S.of(Get.context!).updateFailed,
        desc: S.of(Get.context!).somethingWentWrongWhileUpdatingYourProfilePleaseTryAgain,
        btnOkText: S.of(Get.context!).ok,
        btnOkColor: Colors.red,
        btnOkOnPress: () {},
      ).show();

      return;
    }
  }

  void setSelectedCountry(Countries? country) {
    selectedCountry = country;
    dialCode.value = country?.prefix ?? '';
    update();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyNameController.dispose();
    super.onClose();
  }
}
