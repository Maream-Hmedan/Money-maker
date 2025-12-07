import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/market_place/model/market_response.dart';

enum ApiStatus { loading, success, error, empty }

class MarketController extends GetxController {
  List<MarketResultResponse> items = [];
  ApiStatus status = ApiStatus.loading;


  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    items.clear();
    status = ApiStatus.loading;
    update();

    final langCode = AppLocale().currentLocale.languageCode;
    final url = Uri.parse(ApiEndPoint.marketUrl(langCode));

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/vnd.api+json',
          'accept': 'application/vnd.api+json',
        },
      );

      if (kDebugMode) {
        print("Market API response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['result'] ?? [];

        if (results.isEmpty) {
          status = ApiStatus.empty;
        } else {
          items = results.map((e) => MarketResultResponse.fromJson(e)).toList();
          status = ApiStatus.success;
        }
      } else {
        status = ApiStatus.error;
      }
    } catch (e) {
      status = ApiStatus.error;
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    }

    update();
  }



  bool get isLoading => status == ApiStatus.loading;
  bool get isEmpty => status == ApiStatus.empty;
  bool get isError => status == ApiStatus.error;
  bool get isSuccess => status == ApiStatus.success;
}
