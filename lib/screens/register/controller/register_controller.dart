import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/controller/build_company_controller.dart';
import 'package:money_maker/screens/build_company/widgets/exciting_game_start_screen.dart';
import 'package:money_maker/screens/home/widget/balance_value/balance_value_controller.dart';
import 'package:money_maker/screens/home/widget/portfolio_value/portfolio_value_controller.dart';
import 'package:money_maker/screens/market/controller/market_controller.dart';
import 'package:money_maker/screens/market_place/controller/market_place_controller.dart';
import 'package:money_maker/screens/portfolio/controller/portfolio_controller.dart';
import 'package:money_maker/screens/register/model/register_request.dart';
import 'package:money_maker/screens/register/model/register_response.dart';
import 'package:money_maker/screens/special_offers/controller/special_offers_controller.dart';
import 'package:money_maker/screens/top/controller/top_controller.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
import 'package:oktoast/oktoast.dart' ;
import 'package:sizer/sizer.dart';

class RegisterController extends GetxController {
  final SessionController _sessionController = Get.put(SessionController());
  register({
    required String name,
    required String companyName,
    required String email,
    required String password,
    required String confirmPassword,
    required String mobile,
    required String countryId,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      ProgressHud.shared.startLoading(Get.context!);
      final url = Uri.parse(ApiEndPoint.REGISTER_URL);

      final req = RegisterRequest(
        email: email,
        password: password,
        name: name,
        passwordConfirmation: confirmPassword,
        phoneNumber: mobile,
        countryId: countryId, companyName: companyName,
      );
      debugPrint('URL: $url');
      debugPrint('REQUEST BODY: ${jsonEncode(req.toJson())}');
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
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title:
          S.of(Get.context!).yourAccountHasBeenSuccessfullyCreatedPleaseLogInTo,
          titleTextStyle: TextStyle(fontSize: 15.sp, color: Colors.black),
          btnOkText:  S.of(Get.context!).ok,
          btnOkOnPress: () {
            AppNavigator.of(Get.context!).pushAndRemoveUntil(const ExcitingGameStartScreen());
          },
          btnOkColor: Colors.green,
        ).show();
      } else if (data.containsKey('message')) {
        final message = data['message'];
        final errors = data['errors'] as Map<String, dynamic>?;

        final allErrors = errors?.values
            .whereType<List>()
            .expand((e) => e)
            .join('\n') ??
            '';

        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: allErrors.isNotEmpty ? allErrors.trim() : message,
          titleTextStyle: TextStyle(fontSize: 15.sp, color: Colors.black),
          btnOkText:  S.of(Get.context!).ok,
          btnOkOnPress: () {},
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

