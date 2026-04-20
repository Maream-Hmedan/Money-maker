import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_local_controller.dart';
import 'package:money_maker/screens/home/widget/balance_value/balance_value_controller.dart';
import 'package:money_maker/screens/top_up_balance/model/balance_history_response.dart';
import 'package:money_maker/screens/top_up_balance/model/top_up_balance_request.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
enum ApiStatus { loading, success, error, empty }

class TopUpController extends GetxController with LocaleAwareController{
  ApiStatus status = ApiStatus.loading;

  List<Transaction> transaction = [];
  String errorMessage = S.of(Get.context!).somethingWentWrongPleaseTryAgain;
  Future<void> topUpBalance({
    required String amount,
    required String method,
    VoidCallback? onSuccess,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      ProgressHud.shared.startLoading(Get.context!);
      final url = Uri.parse(ApiEndPoint.TOP_UP_BALANCE_URL);
      final token = GetStorage().read(ConstantValues.TOKEN);

      final req = TopUpBalanceRequest(amount: amount, method: method);

      debugPrint('🔵topUpBalance URL: $url');
      debugPrint('🟢topUpBalance REQUEST BODY: ${jsonEncode(req.toJson())}');

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

        if (data['message'] == 'Balance charged successfully') {
          onSuccess?.call();

          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.success,
            desc: S.of(Get.context!).yourBalanceHasBeenSuccessfullyToppedUp,
            btnOkText: S.of(Get.context!).ok,
            btnOkOnPress: () {
              getBalanceHistory();
              if (Get.isRegistered<BalanceValueController>()) {
                Get.find<BalanceValueController>().fetchBalanceValue();
              }
            },
          ).show();
        } else {
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.error,
            desc: S.of(Get.context!).failedToTopUpBalancePleaseTryAgainLater,
            btnOkOnPress: () {},
            btnOkColor: Colors.red,
          ).show();
        }
      } else if (response.statusCode == 422) {
        final data = jsonDecode(response.body);

        String message = "Invalid input. Please check your data.";

        if (data['errors'] != null && data['errors']['amount'] != null) {
          message = S.of(Get.context!).pleaseEnterAnAmountOfAtLeast1ToProceed;
        }

        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          desc: message,
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        ).show();
      }else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          desc: S.of(Get.context!).somethingWentWrongPleaseTryAgain,
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        ).show();
      }
    } catch (e) {
      ProgressHud.shared.stopLoading();
      debugPrint('ERROR $e');
    }
  }

  @override
  void onLocaleChanged() {
    getBalanceHistory();
  }

  Future<void> getBalanceHistory() async {
    status = ApiStatus.loading;
    errorMessage = '';
    transaction = [];
    update();

    try {
      final token = GetStorage().read(ConstantValues.TOKEN);

      if (token == null || token.toString().isEmpty) {
        status = ApiStatus.error;
        update();
        return;
      }

      final response = await http.get(
        Uri.parse(ApiEndPoint.GET_TRANSACTION_URL),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final transactionResponse = BalanceHistoryResponse.fromJson(decoded);

        transaction = transactionResponse.transactions;

        if (transaction.isEmpty) {
          status = ApiStatus.empty;
        } else {
          status = ApiStatus.success;
        }
      } else {
        status = ApiStatus.error;
      }
    } catch (e) {
      status = ApiStatus.error;
      errorMessage = 'Something went wrong. Please try again later.';
      debugPrint('HistoryController error: $e');
    }

    update();
  }
}