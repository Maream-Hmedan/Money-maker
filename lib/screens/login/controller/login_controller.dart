import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:money_maker/screens/login/model/login_request.dart';
import 'package:money_maker/screens/register/model/register_response.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';

class LoginController extends GetxController {
  login({required String email, required String password}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      ProgressHud.shared.startLoading(Get.context!);
      final url = Uri.parse(ApiEndPoint.LOGIN_URL);

      final req = LoginRequest(email: email, password: password);

      final response = await http.post(
        url,
        body: jsonEncode(req.toJson()),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );

      ProgressHud.shared.stopLoading();

      debugPrint('Response: ${response.body}');
      final data = jsonDecode(response.body);
      if (data.containsKey('access_token')) {
        final token = data['access_token'];
        await GetStorage().write(ConstantValues.TOKEN, token);
        final user = User.fromJson(data['user']);
        CurrentSession().setUser(user);
        AppNavigator.of(Get.context!).push(BottomNavBarScreen());
      } else if (data.containsKey('message')) {
        final message = data['message'];
        final errors = data['errors'] as Map<String, dynamic>?;
        final allErrors =
            errors?.values.whereType<List>().expand((e) => e).join('\n') ?? '';

        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: allErrors.isNotEmpty ? allErrors.trim() : message,
          titleTextStyle: TextStyle(fontSize: 15.sp, color: Colors.black),
          btnOkText: 'Ok',
          btnOkOnPress: (){},
          btnOkColor: Colors.red,
        ).show();
      } else {
        showToast(
          S.of(Get.context!).unexpectedResponseFromServer,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e, s) {
      debugPrint('ERROR $e\n$s');
      ProgressHud.shared.stopLoading();
      showToast(
        S.of(Get.context!).somethingWentWrongPleaseTryAgain,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
    }
  }
}
