import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/l10n/app_local_controller.dart';
import 'package:money_maker/screens/top/model/top_response.dart';

enum ApiStatus { loading, success, error, empty }

class TopLeaderBoardController extends GetxController
    with LocaleAwareController {
  List<Leaderboard> leaderboard = [];
  ApiStatus status = ApiStatus.loading;

  @override
  void onInit() {
    super.onInit();
    fetchLeaderBoard(period: 'week');
  }

  Future<void> fetchLeaderBoard({required String period}) async {
    status = ApiStatus.loading;
    update();

    final url = Uri.parse(ApiEndPoint.TOP_LEADERBOARD_URL);

    try {
      final response = await http.post(
        url,
        body: jsonEncode({'period': period}),
        headers: {
          'Content-Type': 'application/vnd.api+json',
          'accept': 'application/vnd.api+json',
        },
      );
      if (kDebugMode) {
        print('=========== REQUEST ===========');
        print('URL: $url');
        print('Body: { period: $period }');
        print('================================');
      }
      if (kDebugMode) {
        print('=========== RESPONSE ===========');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        print('================================');
      }
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final leaderBoardResponse = TopLeaderboardResponse.fromJson(data);

        if (leaderBoardResponse.leaderboard.isEmpty) {
          leaderboard = [];
          status = ApiStatus.empty;
        } else {
          leaderboard = leaderBoardResponse.leaderboard;
          status = ApiStatus.success;
        }
      } else {
        status = ApiStatus.error;
      }
    } catch (e) {
      status = ApiStatus.error;

      if (kDebugMode) {
        print("Error fetching leaderboard: $e");
      }
    }

    update();
  }

  bool get isLoading => status == ApiStatus.loading;
  bool get isEmpty => status == ApiStatus.empty;
  bool get isError => status == ApiStatus.error;
  bool get isSuccess => status == ApiStatus.success;

  @override
  void onLocaleChanged() {
    fetchLeaderBoard(period: 'week');
  }
}