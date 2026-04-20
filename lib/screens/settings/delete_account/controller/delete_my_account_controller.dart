import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/login/view/login_screen.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
import 'package:sizer/sizer.dart';

class DeleteMyAccount extends GetxController {
  Future<void> deleteAccount() async {
    try {
      ProgressHud.shared.startLoading(Get.context!);
      final url = Uri.parse(ApiEndPoint.DELETE_ACCOUNT_URL);
      final token = GetStorage().read(ConstantValues.TOKEN);
      final body = {
        "password": GetStorage().read(ConstantValues.USER_PASSWORD),
      };
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      debugPrint('REQUEST URL: $url');
      debugPrint('REQUEST BODY: ${jsonEncode(body)}');
      debugPrint('RESPONSE STATUS: ${response.statusCode}');

      debugPrint('RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        ProgressHud.shared.stopLoading();
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          CurrentSession().clear();
          GetStorage().erase();
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            title: S.of(Get.context!).yourAccountHasBeenDeletedSuccessfully,
            titleTextStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
            ),
            btnOkText: S.of(Get.context!).ok,
            btnOkOnPress: () {
              GetStorage().erase();
              CurrentSession().clear();
              AppNavigator.of(Get.context!).pushAndRemoveUntil(LoginScreen());
            },
          ).show();
        } else {
          debugPrint('Delete failed: ${data['message']}');
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            title: data['message'],
            titleTextStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.darkBrandColor,
            ),
            btnOkText: S.of(Get.context!).ok,
            btnOkColor: Colors.red,
          ).show();
        }
      }
    } catch (e) {
      ProgressHud.shared.stopLoading();
      debugPrint('ERROR $e');
    }
  }
}
