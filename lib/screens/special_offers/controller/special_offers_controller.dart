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
import 'package:money_maker/screens/login/view/login_screen.dart';
import 'package:money_maker/screens/portfolio/controller/portfolio_controller.dart';
import 'package:money_maker/screens/settings/contact_us/controller/contact_us_controller.dart';
import 'package:money_maker/screens/special_offers/model/buy_offer_request.dart';
import 'package:money_maker/screens/special_offers/model/buy_offer_response.dart';
import 'package:money_maker/screens/special_offers/model/special_offers_response.dart';
import 'package:money_maker/screens/top_up_balance/view/top_up_balance_screen.dart';
import 'package:money_maker/screens/transaction_history/controller/transaction_history_controller.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
import 'package:sizer/sizer.dart';

enum ApiStatus { loading, success, error, empty }

class SpecialOffersController extends GetxController
    with LocaleAwareController {
  ApiStatus apiStatus = ApiStatus.loading;
  List<OfferItem> offers = [];
  String errorMessage = '';

  bool get isLoading => apiStatus == ApiStatus.loading;
  bool get isSuccess => apiStatus == ApiStatus.success;
  bool get isError => apiStatus == ApiStatus.error;
  bool get isEmpty => apiStatus == ApiStatus.empty;

  @override
  void onInit() {
    super.onInit();
    getSpecialOffers();
  }

  @override
  void onLocaleChanged() {
    getSpecialOffers();
  }

  Future<void> getSpecialOffers() async {
    try {
      apiStatus = ApiStatus.loading;
      errorMessage = '';
      update();

      final langCode = AppLocale().currentLocale.languageCode;
      final url = Uri.parse(ApiEndPoint.specialOffersUrl(langCode));
      final token = GetStorage().read(ConstantValues.TOKEN);

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (kDebugMode) {
        print("Request Special Offer URL: $url");
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }

      final decodedBody = json.decode(response.body);

      if (response.statusCode == 200) {
        final offersResponse = OffersResponse.fromJson(decodedBody);
        offers = offersResponse.result;

        if (offers.isEmpty) {
          apiStatus = ApiStatus.empty;
        } else {
          apiStatus = ApiStatus.success;
        }
      } else {
        apiStatus = ApiStatus.error;
      }
    } catch (e) {
      apiStatus = ApiStatus.error;
      errorMessage = e.toString();
      if (kDebugMode) {
        print('errorMessage $errorMessage');
      }
    }

    update();
  }

  Future<void> buyOffers({
    required String offerId,
  }) async {
    if (CurrentSession().getUser() == null) {
      final context = Get.context;
      if (context == null) return;

      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        dismissOnTouchOutside: true,
        title: S.of(context).startYourInvestmentJourney,
        desc: S.of(context).logInOrSignUpToUnlockYourBalanceBuild,
        btnOkText: S.of(context).getStarted,
        btnOkColor: Colors.orange,
        btnOkOnPress: () {
          AppNavigator.of(context).pushAndRemoveUntil(LoginScreen());
        },
      ).show();

      return;
    }
    try {
      
      final context = Get.context;
      if (context == null) {
        debugPrint('Context is null');
        return;
      }

      ProgressHud.shared.startLoading(context);

      final url = Uri.parse(ApiEndPoint.BUY_OFFER_URL);
      final token = GetStorage().read(ConstantValues.TOKEN);



      final body = BuyOfferRequest(
        offerId: offerId, copyCount: '1',
      );

      debugPrint('BuyOfferRequest URL: $url');
      debugPrint('BuyOfferRequest BODY: ${jsonEncode(body.toJson())}');

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
      final result = BuyOfferResponse.fromRawJson(response.body);
      if (response.statusCode == 200) {
        if (result.message=="Offer purchased successfully") {
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
              getSpecialOffers();
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
      } else if (result.message.toString() == 'Insufficient balance') {
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

  Future<void> refreshOffers() async {
    await getSpecialOffers();
  }
}