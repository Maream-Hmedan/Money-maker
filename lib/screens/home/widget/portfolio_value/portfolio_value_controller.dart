import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';


enum PortfolioValueStatus { loading, error, success, guest }

class PortfolioValueController extends GetxController {
  double portfolioValue = 0.0;
  PortfolioValueStatus portfolioValueStatus = PortfolioValueStatus.loading;

  @override
  void onInit() {
    super.onInit();
    fetchPortfolioValue();
  }

  Future<void> fetchPortfolioValue() async {
    FocusManager.instance.primaryFocus?.unfocus();
    portfolioValueStatus = PortfolioValueStatus.loading;
    update();
    if (CurrentSession().getUser() == null) {
      portfolioValueStatus = PortfolioValueStatus.guest;
      update();
      return;
    }

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
        portfolioValueStatus = PortfolioValueStatus.success;
        update();
      } else {
        portfolioValueStatus = PortfolioValueStatus.error;
        update();
        debugPrint('Invalid response: ${response.body}');
      }
    } catch (e) {
      portfolioValueStatus = PortfolioValueStatus.error;
      update();
      ProgressHud.shared.stopLoading();
      debugPrint('ERROR $e');
    }
  }

  bool get isLoading => portfolioValueStatus == PortfolioValueStatus.loading;
  bool get isSuccess => portfolioValueStatus == PortfolioValueStatus.success;
  bool get isError => portfolioValueStatus == PortfolioValueStatus.error;
  bool get isGuest => portfolioValueStatus == PortfolioValueStatus.guest;
}

