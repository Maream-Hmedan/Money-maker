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
import 'package:money_maker/screens/market/model/filter_response.dart';
import 'package:money_maker/screens/market/model/market_response.dart';
import 'package:money_maker/screens/market/model/sort_response.dart';
import 'package:money_maker/screens/portfolio/controller/portfolio_controller.dart';
import 'package:money_maker/screens/settings/contact_us/controller/contact_us_controller.dart';
import 'package:money_maker/screens/top_up_balance/view/top_up_balance_screen.dart';
import 'package:money_maker/screens/transaction_history/controller/transaction_history_controller.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
import 'package:sizer/sizer.dart';

enum ApiStatus { loading, success, error, empty }

class MarketController extends GetxController with LocaleAwareController {
  List<MarketResultResponse> items = [];
  ApiStatus status = ApiStatus.loading;

  String? selectedSortBy;
  String? selectedOrder;

  String? selectedType;

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
        print("Market API url: $url");
        print("Market API response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['result'] ?? [];

        if (results.isEmpty ||
            results
                .map((e) => MarketResultResponse.fromJson(e))
                .where((item) => item.copyCount > 0)
                .toList()
                .isEmpty) {
          status = ApiStatus.empty;
        } else {
          items =
              results
                  .map((e) => MarketResultResponse.fromJson(e))
                  .where((item) => item.copyCount > 0)
                  .toList();
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

  Future<void> sortItems({
    required String sortBy,
    required String order,
  }) async {
    selectedSortBy = sortBy;
    selectedOrder = order;

    if (selectedType != null && selectedType!.isNotEmpty) {
      _applyLocalSort();
      update();
      return;
    }

    items.clear();
    status = ApiStatus.loading;
    update();

    final langCode = AppLocale().currentLocale.languageCode;

    final url = Uri.parse(
      'http://moneymaker-app.com/api/assets/sort_assets'
      '?sort_by=$sortBy&order=$order&language=$langCode',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/vnd.api+json',
          'accept': 'application/vnd.api+json',
        },
      );

      if (kDebugMode) {
        print("Sort API url: $url");
        print("Sort API response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final decoded = SortResponse.fromRawJson(response.body);
        final finalDecoded =
            decoded.sortResult
                .map(
                  (e) => MarketResultResponse(
                    id: e.id,
                    name: e.name,
                    image: e.image,
                    price: e.price,
                    priceGrowthRate: e.priceGrowthRate,
                    copyCount: e.copyCount,
                    type: e.type,
                  ),
                )
                .where((item) => item.copyCount > 0)
                .toList();

        if (decoded.sortResult.isEmpty || finalDecoded.isEmpty) {
          status = ApiStatus.empty;
        } else {
          items = finalDecoded;
          status = ApiStatus.success;
        }
      } else {
        status = ApiStatus.error;
      }
    } catch (e) {
      status = ApiStatus.error;
      if (kDebugMode) {
        print("Error sorting market data: $e");
      }
    }

    update();
  }

  void _applyLocalSort() {
    if (selectedSortBy == null || selectedOrder == null) return;

    items.sort((a, b) {
      double aValue;
      double bValue;

      if (selectedSortBy == 'price') {
        aValue = a.price;
        bValue = b.price;
      } else {
        aValue = a.priceGrowthRate;
        bValue = b.priceGrowthRate;
      }

      return selectedOrder == 'asc'
          ? aValue.compareTo(bValue)
          : bValue.compareTo(aValue);
    });
  }

  Future<void> filterItems({required String type}) async {
    items.clear();
    status = ApiStatus.loading;
    selectedType = type;
    update();

    final langCode = AppLocale().currentLocale.languageCode;

    final url = Uri.parse(
      'http://moneymaker-app.com/api/assets/filter_by_type?type=$type&language=$langCode',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/vnd.api+json',
          'accept': 'application/vnd.api+json',
        },
      );

      if (kDebugMode) {
        print("Filter API url: $url");
        print("Filter API response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final decoded = FilterResponse.fromRawJson(response.body);
        final finalDecoded =
            decoded.result
                .map(
                  (e) => MarketResultResponse(
                    id: e.id,
                    name: e.name,
                    image: e.image,
                    price: e.price.toDouble(),
                    priceGrowthRate: e.priceGrowthRate.toDouble(),
                    copyCount: e.copyCount,
                    type: e.type,
                  ),
                )
                .where((item) => item.copyCount > 0)
                .toList();

        if (decoded.result.isEmpty || finalDecoded.isEmpty) {
          status = ApiStatus.empty;
        } else {
          items = finalDecoded;
          _applyLocalSort();
          status = ApiStatus.success;
        }
      } else {
        status = ApiStatus.error;
      }
    } catch (e) {
      status = ApiStatus.error;
      if (kDebugMode) {
        print("Error filtering market data: $e");
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
          btnOkOnPress: (){}
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
            desc: S.of(Get.context!).theAssetHasBeenPurchasedSuccessfully,
            titleTextStyle: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            descTextStyle: TextStyle(fontSize: 16.sp, color: Colors.black87),
            btnOkText: S.of(Get.context!).ok,
            btnOkOnPress: () async {
              fetchData();
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

  Future<void> resetAllFilters() async {
    selectedSortBy = null;
    selectedOrder = null;
    selectedType = null;
    await fetchData();
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

  bool get isLoading => status == ApiStatus.loading;

  bool get isEmpty => status == ApiStatus.empty;

  bool get isError => status == ApiStatus.error;

  bool get isSuccess => status == ApiStatus.success;

  @override
  void onLocaleChanged() {
    fetchData();
  }
}
