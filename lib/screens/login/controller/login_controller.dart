import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/controller/build_company_controller.dart';
import 'package:money_maker/screens/home/widget/balance_value/balance_value_controller.dart';
import 'package:money_maker/screens/home/widget/portfolio_value/portfolio_value_controller.dart';
import 'package:money_maker/screens/login/model/login_request.dart';
import 'package:money_maker/screens/market/controller/market_controller.dart';
import 'package:money_maker/screens/market_place/controller/market_place_controller.dart';
import 'package:money_maker/screens/portfolio/controller/portfolio_controller.dart';
import 'package:money_maker/screens/register/model/register_response.dart';
import 'package:money_maker/screens/special_offers/controller/special_offers_controller.dart';
import 'package:money_maker/screens/top/controller/top_controller.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';

class LoginController extends GetxController {
  final SessionController _sessionController = Get.put(SessionController());

  Future<bool> login({
    required String email,
    required String password,
    bool showLoading = true,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      if (showLoading) {
        ProgressHud.shared.startLoading(Get.context!);
      }

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
      debugPrint('================ LOGIN REQUEST ================');
      debugPrint('URL: $url');
      debugPrint('REQUEST BODY: ${req.toJson()}');
      if (showLoading) {
        ProgressHud.shared.stopLoading();
      }

      debugPrint('================ LOGIN RESPONSE ================');
      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('BODY: ${response.body}');

      final data = jsonDecode(response.body);

      if (data.containsKey('access_token')) {
        final token = data['access_token'];
        await GetStorage().write(ConstantValues.TOKEN, token);

        if (kDebugMode) {
          print('TOKEN $token');
        }

        final user = UserModel.fromJson(data['user']);
        await GetStorage().write(ConstantValues.USER_EMAIL, email);
        await GetStorage().write(ConstantValues.USER_PASSWORD, password);
        _sessionController.setUser(user);
        Get.delete<PortfolioValueController>();
        Get.delete<MarketController>();
        Get.delete<CompanyController>();
        Get.delete<BalanceValueController>();
        Get.delete<MarketPlaceController>();
        Get.delete<PortfolioController>();
        Get.delete<SpecialOffersController>();
        Get.delete<TopLeaderBoardController>();

        return true;
      } else if (data.containsKey('message')) {
        final message = data['message'];
        final errors = data['errors'] as Map<String, dynamic>?;
        final allErrors =
            errors?.values.whereType<List>().expand((e) => e).join('\n') ?? '';

        String dialogMessage;

        if (message == 'Invalid credentials.') {
          dialogMessage = S.of(Get.context!).invalidLoginCredentials;
        } else {
          dialogMessage = allErrors.isNotEmpty ? allErrors.trim() : message;
        }

        if (showLoading) {
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            title: dialogMessage,
            titleTextStyle: TextStyle(fontSize: 15.sp, color: Colors.black),
            btnOkText: S.of(Get.context!).ok,
            btnOkOnPress: () {},
            btnOkColor: Colors.red,
          ).show();
        }

        return false;
      } else {
        if (showLoading) {
          showToast(
            S.of(Get.context!).unexpectedResponseFromServer,
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          );
        }

        return false;
      }
    } catch (e, s) {
      debugPrint('ERROR TYPE: ${e.runtimeType}');
      debugPrint('ERROR: $e');
      debugPrint('STACK: $s');

      if (showLoading) {
        ProgressHud.shared.stopLoading();
        showToast(
          S.of(Get.context!).somethingWentWrongPleaseTryAgain,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        );
      }

      return false;
    }
  }
}
