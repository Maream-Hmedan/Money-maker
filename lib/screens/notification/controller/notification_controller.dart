import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/l10n/app_local_controller.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/notification/model/notification_response.dart';


enum ApiStatus { loading, success, error, empty }

class NotificationController extends GetxController with LocaleAwareController {
  ApiStatus status = ApiStatus.loading;

  NotificationResponse? notificationResponse;

  List<NotificationItem> get notificationsList =>
      notificationResponse?.notifications ?? [];

  bool get isLoading => status == ApiStatus.loading;
  bool get isEmpty => status == ApiStatus.empty;
  bool get isError => status == ApiStatus.error;
  bool get isSuccess => status == ApiStatus.success;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  @override
  void onLocaleChanged() {
    getNotifications();
  }

  Future<void> getNotifications() async {
    status = ApiStatus.loading;
    notificationResponse = null;
    update();

    try {
      final langCode = AppLocale().currentLocale.languageCode;
      final url = Uri.parse(ApiEndPoint.notificationsUrl(langCode));
      final token = GetStorage().read(ConstantValues.TOKEN);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        status = ApiStatus.error;
        notificationResponse = null;
        update();
        return;
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        status = ApiStatus.error;
        notificationResponse = null;
        update();
        return;
      }

      notificationResponse = NotificationResponse.fromJson(decoded);

      if (notificationsList.isEmpty) {
        status = ApiStatus.empty;
      } else {
        status = ApiStatus.success;
      }
    } catch (e) {
      notificationResponse = null;
      status = ApiStatus.error;
      debugPrint('getNotifications error: $e');
    }

    update();
  }

  String notificationBody(NotificationItem item) {
    final langCode = AppLocale().currentLocale.languageCode;
    return langCode == 'ar' ? item.bodyAr : item.bodyEn;
  }
}