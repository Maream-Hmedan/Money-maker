import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_local_controller.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/controller/build_company_controller.dart';
import 'package:money_maker/screens/home/widget/balance_value/balance_value_controller.dart';
import 'package:money_maker/screens/home/widget/portfolio_value/portfolio_value_controller.dart';
import 'package:money_maker/screens/market/model/buy_market_request.dart';
import 'package:money_maker/screens/market/model/buy_market_response.dart';
import 'package:money_maker/screens/market_place/model/cancel_sale_request.dart';
import 'package:money_maker/screens/market_place/model/cancel_sale_response.dart';
import 'package:money_maker/screens/market_place/model/market_place_response.dart';
import 'package:money_maker/screens/portfolio/controller/portfolio_controller.dart';
import 'package:money_maker/screens/settings/contact_us/controller/contact_us_controller.dart';
import 'package:money_maker/screens/top_up_balance/view/top_up_balance_screen.dart';
import 'package:money_maker/screens/transaction_history/controller/transaction_history_controller.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
import 'package:sizer/sizer.dart';

enum ApiStatus { loading, success, error, empty }

class MarketPlaceController extends GetxController with LocaleAwareController {
  List<MarketItem> items = [];
  ApiStatus marketStatus = ApiStatus.loading;
  ApiStatus mineMarketStatus = ApiStatus.loading;
  final bool initialIsMineFilter;
  MarketPlaceController({this.initialIsMineFilter = false});

  bool isMineFilter = false;

  void toggleFilter(bool value) {
    if (isMineFilter == value) return;

    isMineFilter = value;
    update();

    if (isMineFilter) {
      fetchMineMarketPlaceData();
    } else {
      fetchMarketPlaceData();
    }
  }
  @override
  void onInit() {
    super.onInit();
    isMineFilter = initialIsMineFilter;

    if (isMineFilter) {
      fetchMineMarketPlaceData();
    } else {
      fetchMarketPlaceData();
    }
  }

  Future<void> fetchMarketPlaceData() async {
    marketStatus = ApiStatus.loading;
    update();

    final langCode = AppLocale().currentLocale.languageCode;
    final url = Uri.parse(ApiEndPoint.marketPlaceUrl(langCode));
    final token = GetStorage().read(ConstantValues.TOKEN);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/vnd.api+json',
          'accept': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
      );

      if (kDebugMode) {
        print("Market Place API url: $url");
        print("Market Place API response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final marketResponse = MarketPlaceResponse.fromJson(data);

        if (marketResponse.result.isEmpty) {
          items = [];
          marketStatus = ApiStatus.empty;
        } else {
          items = marketResponse.result;
          marketStatus = ApiStatus.success;
        }
      } else {
        marketStatus = ApiStatus.error;
      }
    } catch (e) {
      marketStatus = ApiStatus.error;

      if (kDebugMode) {
        print("Error fetching Market Place data: $e");
      }
    }

    update();
  }

  Future<void> fetchMineMarketPlaceData() async {
    mineMarketStatus = ApiStatus.loading;
    update();

    final langCode = AppLocale().currentLocale.languageCode;
    final url = Uri.parse(ApiEndPoint.mineMarketPlaceUrl(langCode));
    final token = GetStorage().read(ConstantValues.TOKEN);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/vnd.api+json',
          'accept': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
      );

      if (kDebugMode) {
        print("Mine Market Place API url: $url");
        print("Mine Market Place API response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final marketResponse = MarketPlaceResponse.fromJson(data);

        if (marketResponse.result.isEmpty) {
          items = [];
          mineMarketStatus = ApiStatus.empty;
        } else {
          items = marketResponse.result;
          mineMarketStatus = ApiStatus.success;
        }
      } else {
        mineMarketStatus = ApiStatus.error;
      }
    } catch (e) {
      mineMarketStatus = ApiStatus.error;

      if (kDebugMode) {
        print("Error fetching Mine Market Place data: $e");
      }
    }

    update();
  }

  Future<void> buyAssets({
    required String assetId,
    required String copyCount,
    required String saleOfferId,
  }) async {
    try {
      final context = Get.context;
      if (context == null) {
        debugPrint('Context is null');
        return;
      }

      ProgressHud.shared.startLoading(context);

      final url = Uri.parse(ApiEndPoint.BUY_ASSETS_URL);
      final token = GetStorage().read(ConstantValues.TOKEN);
      final controller = Get.find<SessionController>();

      if (controller.user == null || controller.user!.companies.isEmpty) {
        ProgressHud.shared.stopLoading();

        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: S.of(context).companyNotFound,
          desc:
              S.of(context).noCompanyIsLinkedToYourAccountPleaseContactSupport,
          titleTextStyle: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          descTextStyle: TextStyle(fontSize: 15.sp, color: Colors.black87),
          btnOkText: S.of(context).ok,
          btnOkColor: Colors.orange,

          btnOkOnPress: () {},
        ).show();
        return;
      }

      final String companyId = controller.user!.companies.first.id.toString();

      final body = BuyAssetsRequest(
        copyCount: copyCount,
        saleOfferId: saleOfferId,
        assetId: assetId,
        companyId: companyId,
      );

      debugPrint('REQUEST URL: $url');
      debugPrint('REQUEST BODY: ${jsonEncode(body.toJson())}');

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body.toJson()),
      );

      debugPrint('RESPONSE STATUS: ${response.statusCode}');
      debugPrint('RESPONSE BODY: ${response.body}');

      ProgressHud.shared.stopLoading();
      final result = BuyAssetsResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        if (result.result) {
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            title: S.of(Get.context!).purchaseSuccessful,
            desc: S.of(Get.context!).purchaseCompletedDesc,
            titleTextStyle: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            descTextStyle: TextStyle(fontSize: 16.sp, color: Colors.black87),
            btnOkText: S.of(Get.context!).ok,
            btnOkOnPress: () async {
              fetchMarketPlaceData();
              if (Get.isRegistered<PortfolioValueController>()) {
                await Get.find<PortfolioValueController>()
                    .fetchPortfolioValue();
              }
              if (Get.isRegistered<PortfolioController>()) {
                await Get.find<PortfolioController>().getPortfolio();
              }
              if (Get.isRegistered<BalanceValueController>()) {
                Get.find<BalanceValueController>().fetchBalanceValue();
              }
              final controller =
              Get.isRegistered<TransactionHistoryController>()
                  ? Get.find<TransactionHistoryController>()
                  : Get.put(TransactionHistoryController());
              await controller.getTransactionHistory();
              await _checkAndRefreshCompanyAfterFirstQualifiedPurchase();
            },
          ).show();
        } else {
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            title: S.of(Get.context!).purchaseFailed,
            desc:
                result.message.isNotEmpty
                    ? result.message
                    : S
                        .of(Get.context!)
                        .weWereUnableToCompleteYourPurchasePleaseTryAgain,
            titleTextStyle: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            descTextStyle: TextStyle(fontSize: 15.sp, color: Colors.black87),
            btnOkText: S.of(Get.context!).ok,
            btnOkColor: Colors.red,
          ).show();
        }
      } else if (result.result.toString() == 'Insufficient balance') {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: S.of(Get.context!).insufficientBalance,
          desc:
              S
                  .of(Get.context!)
                  .yourCurrentBalanceIsNotEnoughToCompleteThisPurchase,
          titleTextStyle: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          descTextStyle: TextStyle(fontSize: 15.sp, color: Colors.black87),
          btnOkText: S.of(Get.context!).topUpYourBalance,
          btnOkColor: Colors.red,
          btnOkOnPress: () {
            AppNavigator.of(Get.context!).push(BalanceTopUpScreen());
          },
        ).show();
      } else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: S.of(Get.context!).requestFailed,
          desc:
              S
                  .of(Get.context!)
                  .somethingWentWrongWhileProcessingYourRequestPleaseTryAgain,
          titleTextStyle: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          descTextStyle: TextStyle(fontSize: 15.sp, color: Colors.black87),
          btnOkText: S.of(Get.context!).ok,
          btnOkColor: Colors.red,
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      ProgressHud.shared.stopLoading();
      debugPrint('ERROR: $e');

      final context = Get.context;
      if (context != null) {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: S.of(Get.context!).unexpectedError,
          desc:
              S
                  .of(Get.context!)
                  .anUnexpectedErrorOccurredWhileBuyingTheAssetPleaseTry,
          titleTextStyle: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          descTextStyle: TextStyle(fontSize: 15.sp, color: Colors.black87),
          btnOkText: S.of(Get.context!).ok,
          btnOkColor: Colors.red,
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

 Future<void> _checkAndRefreshCompanyAfterFirstQualifiedPurchase() async {
    final sessionController = Get.find<SessionController>();
    final user = sessionController.user;

    if (user == null || user.companies.isEmpty) return;

    final company = user.companies.first;

    if (company.status != 'pending') return;

    ContactUsController contactUsController;
    if (Get.isRegistered<ContactUsController>()) {
      contactUsController = Get.find<ContactUsController>();
    } else {
      contactUsController = Get.put(ContactUsController());
      await contactUsController.getContactUsFromApi();
    }

    final conditionValue = contactUsController.contactUs?.conditionValue ?? 0;

    PortfolioValueController? portfolioValueController;
    if (Get.isRegistered<PortfolioValueController>()) {
      portfolioValueController = Get.find<PortfolioValueController>();
      await portfolioValueController.fetchPortfolioValue();
    }

    final portfolioValue =
        portfolioValueController?.portfolioValue ?? user.portfolioValue;


    if (portfolioValue >= conditionValue) {
      CompanyController companyController;
      if (Get.isRegistered<CompanyController>()) {
        companyController = Get.find<CompanyController>();
      } else {
        companyController = Get.put(CompanyController());
      }

      await companyController.getMyCompanyInfo();
    }
  }
  Future<void> cancelSaleAssets({required String saleOfferId}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final context = Get.context;
      if (context == null) return;

      ProgressHud.shared.startLoading(context);

      final token = GetStorage().read(ConstantValues.TOKEN);
      final url = Uri.parse(ApiEndPoint.CANCEL_PORTFOLIO_URL);

      final req = CancelSaleRequest(saleOfferId: saleOfferId);

      debugPrint('cancel Sale URL: $url');
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
        final sellResponse = CancelSaleResponse.fromJson(data);
        if (sellResponse.result == "Sale offer cancelled successfully") {
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: S.of(Get.context!).success,
            desc: S.of(Get.context!).saleCancelledSuccessfullynyourAssetIsNowBackInYourPortfolio,
            btnOkText: S.of(Get.context!).ok,
            btnOkOnPress: () async {
              if (isMineFilter) {
                await fetchMineMarketPlaceData();
              } else {
                await fetchMarketPlaceData();
              }

              final controllerPortfolio =
              Get.isRegistered<PortfolioController>()
                  ? Get.find<PortfolioController>()
                  : Get.put(PortfolioController());
              await controllerPortfolio.getPortfolio();
            },
          ).show();
        }
      } else {
        String userFriendlyMsg =
            S.of(Get.context!).unexpectedResponseFromServer;

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
  ApiStatus get currentStatus =>
      isMineFilter ? mineMarketStatus : marketStatus;

  bool get isLoading => currentStatus == ApiStatus.loading;
  bool get isEmpty => currentStatus == ApiStatus.empty;
  bool get isError => currentStatus == ApiStatus.error;
  bool get isSuccess => currentStatus == ApiStatus.success;

  @override
  void onLocaleChanged() {
    if (isMineFilter) {
      fetchMineMarketPlaceData();
    } else {
      fetchMarketPlaceData();
    }
  }
}
