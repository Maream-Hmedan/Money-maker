import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:money_maker/screens/change_password/model/reset_password_request.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';

class ChangePasswordController extends GetxController {

  Future<void> resetPassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      ProgressHud.shared.startLoading(Get.context!);
      final url = Uri.parse(ApiEndPoint.RESET_PASSWORD_URL);
      final token = GetStorage().read(ConstantValues.TOKEN);


      final req = ChangePasswordRequest(
          password: password ,
          passwordConfirmation: passwordConfirmation);

      debugPrint('🔵 RESET PASSWORD URL: $url');

      debugPrint('🟢 REQUEST BODY: ${jsonEncode(req.toJson())}');

      final response = await http.post(
        url,
        body: jsonEncode(req.toJson()),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('🟡 RESPONSE STATUS: ${response.statusCode}');
      debugPrint('🟣 RESPONSE BODY: ${response.body}');

      ProgressHud.shared.stopLoading();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        if (data['message'] == 'Password updated successfully') {
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.success,
            desc: S.of(Get.context!).yourPasswordWasUpdatedSuccessfully,
            btnOkText: S.of(Get.context!).ok,
            btnOkOnPress: () {
              AppNavigator.of(Get.context!).push(BottomNavBarScreen());
            },
          ).show();
        } else {
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.error,
            title: data['message'] ?? S.of(Get.context!).failedToResetPassword,
            btnOkOnPress: () {},
            btnOkColor: Colors.red,
          ).show();
        }
      } else {
        debugPrint('Invalid response: ${response.body}');
      }
    } catch (e) {
      ProgressHud.shared.stopLoading();
      debugPrint('ERROR $e');
    }
  }
}
