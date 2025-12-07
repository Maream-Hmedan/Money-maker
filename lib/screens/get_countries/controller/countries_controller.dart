import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/get_countries/model/countries_response.dart';

class CountriesController extends GetxController{
  List<Countries> countries = [];


  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      final langCode = AppLocale().currentLocale.languageCode;
      final url = Uri.parse(ApiEndPoint.countryUrl(langCode));
      final res = await http.get(url, headers: {
        'Content-Type': 'application/vnd.api+json',
        'accept': 'application/vnd.api+json',
      });
      if (res.statusCode == 200) {
        final parsed = CountriesResponse.fromRawJson(res.body);
        countries = parsed.countries;

        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print('countries error $e');
      }
    }

  }
}