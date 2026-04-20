import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/l10n/app_local_controller.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/market_place/controller/market_place_controller.dart';
import 'package:money_maker/screens/portfolio/model/portfolio_response.dart';
import 'package:money_maker/screens/portfolio/model/sell_portfolio_request.dart';
import 'package:money_maker/screens/portfolio/model/sell_portfolio_response.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';

import '../../../generated/l10n.dart' show S;

enum ApiStatus { loading, success, error, empty, guest }

class PortfolioController extends GetxController with LocaleAwareController  {
  ApiStatus apiStatus = ApiStatus.loading;

  List<Portfolio> portfolioList = [];
  String errorMessage = '';

  @override
  void onInit() {
    super.onInit();
    getPortfolio();
  }

  @override
  void onLocaleChanged() {
    getPortfolio();
  }

  Future<void> getPortfolio() async {
    apiStatus = ApiStatus.loading;
    errorMessage = '';
    update();
    if (CurrentSession().getUser() == null) {
      apiStatus = ApiStatus.guest;
      portfolioList = [];
      update();
      return;
    }
    try {
      final langCode = AppLocale().currentLocale.languageCode;
      final url = Uri.parse(ApiEndPoint.getUserAssetsUrl(langCode));
      final token = GetStorage().read(ConstantValues.TOKEN);

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
      );
      if (kDebugMode) {
        print("URL Portfolio: $url");
        print("Status Code: ${response.statusCode}");

        print("Response Body: ${response.body}");
      }
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final portfolioResponse = GetPortfolioResponse.fromJson(data);

        if (portfolioResponse.portfolio.isEmpty) {
          portfolioList = [];
          apiStatus = ApiStatus.empty;
        } else {
          portfolioList = portfolioResponse.portfolio;
          apiStatus = ApiStatus.success;
        }
      } else {
        errorMessage = 'Server error: ${response.statusCode}';
        apiStatus = ApiStatus.error;
      }
    } catch (e) {
      errorMessage = e.toString();
      apiStatus = ApiStatus.error;
    }

    update();
  }

  Future<void> sellPortfolio({
    required String assetId,
    required String copyCount,
    required double price,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final context = Get.context;
      if (context == null) return;

      ProgressHud.shared.startLoading(context);

      final token = GetStorage().read(ConstantValues.TOKEN);
      final url = Uri.parse(ApiEndPoint.SELL_PORTFOLIO_URL);

      final req = SellPortfolioRequest(
        assetId: assetId,
        saleCopyCount: copyCount,
        price: price,
      );

      debugPrint('SELL PORTFOLIO URL: $url');
      debugPrint('REQUEST BODY: ${jsonEncode(req.toJson())}');

      final response = await http.post(
        url,
        body: jsonEncode(req.toJson()),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
      );

      ProgressHud.shared.stopLoading();

      debugPrint('RESPONSE STATUS: ${response.statusCode}');
      debugPrint('RESPONSE BODY: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final sellResponse = SellPortfolioResponse.fromJson(data);

        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: S.of(Get.context!).success,
          desc: sellResponse.message.isNotEmpty
              ? sellResponse.message
              : S.of(Get.context!).yourAssetHasBeenSuccessfullyListedInTheMarketplace,
          btnOkText: S.of(Get.context!).great,
          btnOkOnPress: () async {
            await getPortfolio();
            if (Get.isRegistered<PortfolioController>()) {
              await Get.find<PortfolioController>().getPortfolio();
            }
            final controller = Get.isRegistered<MarketPlaceController>()
                ? Get.find<MarketPlaceController>()
                : Get.put(MarketPlaceController());
            await controller.fetchMarketPlaceData();
          },
        ).show();
      } else {
        String userFriendlyMsg = S.of(Get.context!).unexpectedResponseFromServer;

        if (data['message'] != null && data['message'].toString().isNotEmpty) {
          userFriendlyMsg = data['message'].toString();
        } else if (data['result'] != null && data['result'] is String) {
          final serverMsg = data['result'] as String;

          if (serverMsg.contains("not own enough copies")) {
            userFriendlyMsg =
                S.of(Get.context!).youAreTryingToSellMoreCopiesThanYouOwn;
          } else {
            userFriendlyMsg = serverMsg;
          }
        }

        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: S.of(Get.context!).error,
          desc: userFriendlyMsg,
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        ).show();
      }
    } catch (e, s) {
      debugPrint('ERROR $e\n$s');

      ProgressHud.shared.stopLoading();
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        title: S.of(Get.context!).error,
        btnOkColor: Colors.red,
        desc: S.of(Get.context!).somethingWentWrongPleaseTryAgain,
        btnOkOnPress: () {},
      ).show();
    }
  }

}