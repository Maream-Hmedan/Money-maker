import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_local_controller.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/market_place/model/filter_response.dart';
import 'package:money_maker/screens/market_place/model/market_response.dart';
import 'package:money_maker/screens/market_place/model/sort_response.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';
import 'package:sizer/sizer.dart';

enum ApiStatus { loading, success, error, empty }

class MarketController extends GetxController with LocaleAwareController  {
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

        if (results.isEmpty) {
          status = ApiStatus.empty;
        } else {
          items = results.map((e) => MarketResultResponse.fromJson(e)).toList();
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

        if (decoded.sortResult.isEmpty) {
          status = ApiStatus.empty;
        } else {
          items = decoded.sortResult.map((e) {
            return MarketResultResponse(
              id: e.id,
              name: e.name,
              ownerName: '',
              image: e.image,
              price: e.price,
              priceGrowthRate: e.priceGrowthRate,
              copyCount: e.copyCount,
              type: e.type,
            );
          }).toList();

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

  Future<void> filterItems({
    required String type,
  }) async {
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

        if (decoded.result.isEmpty) {
          status = ApiStatus.empty;
        } else {
          items = decoded.result.map((e) {
            return MarketResultResponse(
              id: e.id,
              name: e.name,
              ownerName: '',
              image: e.image,
              price: e.price.toDouble(),
              priceGrowthRate: e.priceGrowthRate.toDouble(),
              copyCount: e.copyCount,
              type: e.type,
            );
          }).toList();

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

  Future<void> buyAssets({required String assetId }) async {
    try {
      ProgressHud.shared.startLoading(Get.context!);
      final url = Uri.parse(ApiEndPoint.BUY_ASSETS_URL);
      final token = GetStorage().read(ConstantValues.TOKEN);
      final body = {
        "asset_id":assetId,
      };
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      debugPrint('REQUEST URL: $url');
      debugPrint('REQUEST BODY: ${jsonEncode(body)}');
      debugPrint('RESPONSE STATUS: ${response.statusCode}');

      debugPrint('RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        ProgressHud.shared.stopLoading();
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            title:'',
            titleTextStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
            ),
            btnOkText: S.of(Get.context!).ok,
            btnOkOnPress: () {
             AppNavigator.of(Get.context!).pop();
            },
          ).show();
        } else {
          debugPrint('buy Assets failed: ${data['message']}');
          AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            title: data['message'],
            titleTextStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.darkBrandColor,
            ),
            btnOkText: S.of(Get.context!).ok,
            btnOkColor: Colors.red,
          ).show();
        }
      }
    } catch (e) {
      ProgressHud.shared.stopLoading();
      debugPrint('ERROR $e');
    }
  }

  Future<void> resetAllFilters() async {
    selectedSortBy = null;
    selectedOrder = null;
    selectedType = null;
    await fetchData();
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
