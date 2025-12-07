import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';


enum ApiStatus { loading, error, success }

class PortfolioValueController extends GetxController {
  double portfolioValue = 0.0;
  ApiStatus portfolioValueStatus = ApiStatus.loading;

  @override
  void onInit() {
    super.onInit();
    fetchPortfolioValue();
  }

  Future<void> fetchPortfolioValue() async {
    FocusManager.instance.primaryFocus?.unfocus();
    portfolioValueStatus = ApiStatus.loading;
    update();

    try {

      final url = Uri.parse(ApiEndPoint.PORTFOLIO_VALUE_URL);
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
        portfolioValue = (data['portoflio_value'] ?? 0).toDouble();
        portfolioValueStatus = ApiStatus.success;
        update();
      } else {
        portfolioValueStatus = ApiStatus.error;
        update();
        debugPrint('Invalid response: ${response.body}');
      }
    } catch (e) {
      portfolioValueStatus = ApiStatus.error;
      update();
      ProgressHud.shared.stopLoading();
      debugPrint('ERROR $e');
    }
  }

  bool get isLoading => portfolioValueStatus == ApiStatus.loading;
  bool get isSuccess => portfolioValueStatus == ApiStatus.success;
  bool get isError => portfolioValueStatus == ApiStatus.error;
}

