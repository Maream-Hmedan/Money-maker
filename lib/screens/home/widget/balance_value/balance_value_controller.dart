import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';


enum ApiStatus { loading, error, success, guest }

class BalanceValueController extends GetxController {
  double balanceValue = 0.0;
  ApiStatus balanceValueStatus = ApiStatus.loading;

  @override
  void onInit() {
    super.onInit();
    fetchBalanceValue();
  }

  Future<void> fetchBalanceValue() async {
    FocusManager.instance.primaryFocus?.unfocus();
    balanceValueStatus = ApiStatus.loading;
    update();
    if (CurrentSession().getUser() == null) {
      balanceValueStatus = ApiStatus.guest;
      update();
      return;
    }
    try {
      final url = Uri.parse(ApiEndPoint.BALANCE_VALUE_URL);
      final token = GetStorage().read(ConstantValues.TOKEN);

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
      );


      debugPrint('API Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        balanceValue = (data['balance'] ?? 0).toDouble();
        balanceValueStatus = ApiStatus.success;
        update();
      } else {
        balanceValueStatus = ApiStatus.error;
        update();
        debugPrint('Invalid response: ${response.body}');
      }
    } catch (e) {
      balanceValueStatus = ApiStatus.error;
      update();
      ProgressHud.shared.stopLoading();
      debugPrint('ERROR $e');
    }
  }

  bool get isLoading => balanceValueStatus == ApiStatus.loading;
  bool get isSuccess => balanceValueStatus == ApiStatus.success;
  bool get isError => balanceValueStatus == ApiStatus.error;
  bool get isGuest => balanceValueStatus == ApiStatus.guest;
}

