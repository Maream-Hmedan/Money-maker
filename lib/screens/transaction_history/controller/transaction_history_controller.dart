import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_local_controller.dart';
import 'package:money_maker/screens/transaction_history/model/transaction_history_response.dart';

enum ApiStatus { loading, success, error, empty }

class TransactionHistoryController extends GetxController
    with LocaleAwareController {
  ApiStatus status = ApiStatus.loading;

  List<Order> orders = [];
  String errorMessage = S.of(Get.context!).somethingWentWrongPleaseTryAgain;

  bool get isLoading => status == ApiStatus.loading;
  bool get isSuccess => status == ApiStatus.success;
  bool get isError => status == ApiStatus.error;
  bool get isEmpty => status == ApiStatus.empty;

  @override
  void onInit() {
    super.onInit();
    getTransactionHistory();
  }

  @override
  void onLocaleChanged() {
    getTransactionHistory();
  }

  Future<void> getTransactionHistory() async {
    status = ApiStatus.loading;
    errorMessage = '';
    orders = [];
    update();

    try {
      final token = GetStorage().read(ConstantValues.TOKEN);

      if (token == null || token.toString().isEmpty) {
        status = ApiStatus.error;
        update();
        return;
      }

      final response = await http.get(
        Uri.parse(ApiEndPoint.GET_ORDERS_URL),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final transactionResponse = TransactionHistoryResponse.fromJson(decoded);

        orders = transactionResponse.result;

        if (orders.isEmpty) {
          status = ApiStatus.empty;
        } else {
          status = ApiStatus.success;
        }
      } else {
        status = ApiStatus.error;
        errorMessage = S.of(Get.context!).unableToLoadTransactionHistory;
      }
    } catch (e) {
      status = ApiStatus.error;
      errorMessage = S.of(Get.context!).somethingWentWrongPleaseTryAgainLater;
      debugPrint('TransactionHistoryController error: $e');
    }

    update();
  }

  Future<void> refreshHistory() async {
    await getTransactionHistory();
  }
}