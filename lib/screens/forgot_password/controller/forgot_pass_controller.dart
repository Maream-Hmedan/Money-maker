import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/forgot_password/model/forgot_pass_request.dart';
import 'package:money_maker/screens/login/view/login_screen.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
import 'package:sizer/sizer.dart';


class ForgotPasswordController extends GetxController {

  Future<void> forgotPassword({required String email}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      ProgressHud.shared.startLoading(Get.context!);
      final url = Uri.parse(ApiEndPoint.FORGOT_PASSWORD_URL);

      final req = ForgotPasswordRequest(
        email: email,
      );

      final response = await http.post(
        url,
        body: jsonEncode(req.toJson()),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );
      ProgressHud.shared.stopLoading();
      if (response.statusCode == 200 ) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            title:S.of(Get.context!).weHaveEmailedYourPasswordResetLink,
            titleTextStyle: TextStyle(fontSize: 15.sp, color: Colors.black),
            btnOkText: S.of(Get.context!).ok,
            btnOkOnPress: () {
              AppNavigator.of(Get.context!).push(LoginScreen());
            },
            btnOkColor: Colors.green,
          ).show();
          
        } else {
          debugPrint('Error: ${data['message']}');
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