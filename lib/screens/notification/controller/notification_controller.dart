import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:read_and_listen_app/configuration/api_end_point.dart';
import 'package:read_and_listen_app/configuration/constant_values.dart';
import 'package:read_and_listen_app/l10n/app_local_controller.dart';
import 'package:read_and_listen_app/l10n/app_locale.dart';
import 'package:read_and_listen_app/screens/profile/model/notification_response.dart';

enum ApiStatus { loading, success, error, empty }


class NotificationController extends GetxController with LocaleAwareController {
  ApiStatus status = ApiStatus.loading;

  NotificationResponse? notificationResponse;


  List<NotificationItem> get notificationsList =>
      notificationResponse?.notifications ?? [];

  @override
  void onInit() {
    super.onInit();
    getNotification();
  }
  @override
  void onLocaleChanged() {
    getNotification();
  }
  Future<void> getNotification() async {
    status = ApiStatus.loading;
    update();

    try {
      final langCode = AppLocale().currentLocale.languageCode;
      final url = Uri.parse(ApiEndPoint.notificationsUrl(langCode));
      final token = GetStorage().read(ConstantValues.TOKEN_ID);

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
        update();
        return;
      }
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      notificationResponse = NotificationResponse.fromJson(decoded);

      if (notificationsList.isEmpty) {
        status = ApiStatus.empty;
      } else {
        status = ApiStatus.success;
      }
    } catch (e) {
      status = ApiStatus.error;
    }
    update();
  }

  bool get isLoading => status == ApiStatus.loading;
  bool get isEmpty => status == ApiStatus.empty;
  bool get isError => status == ApiStatus.error;
  bool get isSuccess => status == ApiStatus.success;


}
