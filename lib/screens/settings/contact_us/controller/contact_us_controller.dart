import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/l10n/app_local_controller.dart';
import 'package:money_maker/screens/settings/contact_us/model/contact_us_response.dart';

enum ContactUsStatus { loading, empty, error, success }

class ContactUsController extends GetxController with LocaleAwareController {
  ContactUsResponse? contactUsResponse;
  ContactUsStatus status = ContactUsStatus.loading;

  @override
  void onInit() {
    super.onInit();
    getContactUsFromApi();
  }


  @override
  void onLocaleChanged() {
    getContactUsFromApi();
  }

  Future<void> getContactUsFromApi() async {
    status = ContactUsStatus.loading;
    update();

    final url = Uri.parse(ApiEndPoint.CONTACT_US_URL);

    try {
      if (kDebugMode) {
        debugPrint('✅ ContactUs URL: $url');
      }

      final response = await http.get(
        url,
        headers: const {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );

      if (kDebugMode) {
        debugPrint('✅ ContactUs StatusCode: ${response.statusCode}');
        debugPrint('✅ ContactUs Body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        contactUsResponse = ContactUsResponse.fromJson(data);

        if (contactUsResponse != null &&
            contactUsResponse!.contactUsResult.name.isNotEmpty) {
          status = ContactUsStatus.success;
        } else {
          status = ContactUsStatus.empty;
        }
      } else {
        status = ContactUsStatus.error;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ ContactUs Error: $e');
      }
      status = ContactUsStatus.error;
    }

    update();
  }

  ContactUs? get contactUs => contactUsResponse?.contactUsResult;

  bool get isLoading => status == ContactUsStatus.loading;
  bool get isSuccess => status == ContactUsStatus.success;
  bool get isEmpty => status == ContactUsStatus.empty;
  bool get isError => status == ContactUsStatus.error;
}