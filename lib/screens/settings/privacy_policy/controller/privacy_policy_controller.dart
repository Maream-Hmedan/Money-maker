import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/l10n/app_local_controller.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/settings/privacy_policy/model/privacy_policy_response.dart';

enum ApiStatus { loading, empty, error, success }

class TermsAndConditionController extends GetxController with LocaleAwareController {

  ContactUs? termsResponse;
  Result? termsData;
  ApiStatus status = ApiStatus.loading;

  @override
  void onInit() {
    super.onInit();
    getTermsAndConditionsFromApi();
  }
  @override
  void onLocaleChanged() {
    getTermsAndConditionsFromApi();
  }

  Future<void> getTermsAndConditionsFromApi() async {
    status = ApiStatus.loading;
    update();

    final langCode = AppLocale().currentLocale.languageCode;
    final url = Uri.parse(
      ApiEndPoint.privacyPolicyUrl(langCode),
    );

    try {
      if (kDebugMode) {
        debugPrint('✅ TERMS URL: $url');
      }

      final response = await http.get(
        url,
        headers: const {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );

      if (kDebugMode) {
        debugPrint('✅ TERMS StatusCode: ${response.statusCode}');
        debugPrint('✅ TERMS Body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final model = ContactUs.fromJson(data);

        termsResponse = model;

        final list = model.result;
        termsData = list.isNotEmpty ? list.first : null;

        status = termsData == null
            ? ApiStatus.empty
            : ApiStatus.success;
      } else {
        status = ApiStatus.error;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ TERMS Error: $e');
      }
      status = ApiStatus.error;
    }

    update();
  }

  // ================================
  // Status Helpers
  // ================================

  bool get isLoading => status == ApiStatus.loading;
  bool get isSuccess => status == ApiStatus.success;
  bool get isEmpty => status == ApiStatus.empty;
  bool get isError => status == ApiStatus.error;

  // ================================
  // Localized Text Getters
  // ================================

  String get titleText {
    final t = termsData?.title;
    if (t == null) return '';
    return AppLocale().isArabic() ? t.ar : t.en;
  }

  String get descriptionText {
    final d = termsData?.description;
    if (d == null) return '';
    return AppLocale().isArabic() ? d.ar : d.en;
  }
}