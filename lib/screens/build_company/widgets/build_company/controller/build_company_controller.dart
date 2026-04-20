import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_local_controller.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/model/build_company_request.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/model/build_company_response.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/model/company_categories_response.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/model/my_company_info_response.dart';
import 'package:money_maker/widgets/helpers/progress_hud.dart';

enum ApiStatus { loading, empty, error, success, guest }

class CompanyController extends GetxController with LocaleAwareController {
  List<CompanyCategories> companyCategories = [];
  List<MyCompanyResponseResult> myCompanyResponseResult = [];

  ApiStatus companyInfoStatus = ApiStatus.guest;
  ApiStatus categoriesStatus = ApiStatus.loading;

  String errorMessage = '';
  String categoriesErrorMessage = '';

  @override
  void onInit() {
    super.onInit();
    fetchCompanyCategories();
  }

  Future<void> fetchCompanyCategories() async {
    categoriesStatus = ApiStatus.loading;
    categoriesErrorMessage = '';
    update();

    try {
      final langCode = AppLocale().currentLocale.languageCode;
      final url = Uri.parse(ApiEndPoint.companyCategoriesUrl(langCode));

      final res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/vnd.api+json',
          'accept': 'application/vnd.api+json',
        },
      );

      if (res.statusCode == 200) {
        final parsed = CompanyCategoriesResponse.fromRawJson(res.body);
        companyCategories = parsed.companyCategoriesResult;

        if (companyCategories.isEmpty) {
          categoriesStatus = ApiStatus.empty;
        } else {
          categoriesStatus = ApiStatus.success;
        }
      } else {
        categoriesStatus = ApiStatus.error;
        categoriesErrorMessage = 'Failed to load categories';
      }
    } catch (e) {
      categoriesStatus = ApiStatus.error;
      categoriesErrorMessage = e.toString();

      if (kDebugMode) {
        print('categories error $e');
      }
    }

    update();
  }

  String getCategoryNameById(int id) {
    try {
      return companyCategories.firstWhere((e) => e.id == id).localizedName;
    } catch (e) {
      return 'Unknown';
    }
  }

  Future<void> getMyCompanyInfo() async {
    if (CurrentSession().getUser() == null) {
      myCompanyResponseResult.clear();
      companyInfoStatus = ApiStatus.guest;
      errorMessage = '';
      update();
      return;
    }

    companyInfoStatus = ApiStatus.loading;
    errorMessage = '';
    update();

    try {
      final url = Uri.parse(ApiEndPoint.USER_COMPANY_URL);

      final res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/vnd.api+json',
          'accept': 'application/vnd.api+json',
          'Authorization': 'Bearer ${GetStorage().read(ConstantValues.TOKEN)}',
        },
      );

      if (res.statusCode == 200) {
        final parsed = MyCompanyResponse.fromRawJson(res.body);
        myCompanyResponseResult = parsed.result;

        if (myCompanyResponseResult.isEmpty) {
          companyInfoStatus = ApiStatus.empty;
        } else {
          companyInfoStatus = ApiStatus.success;
        }
      } else {
        companyInfoStatus = ApiStatus.error;
        errorMessage = S.of(Get.context!).failedToLoadCompanyInformation;
      }
    } catch (e) {
      companyInfoStatus = ApiStatus.error;
      errorMessage = e.toString();
    }

    update();
  }

  Future<bool> buildCompany({
    required String name,
    required String categoryId,
    required String categoryName,
    required String founderName,
    required String description,
    required File logo,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      ProgressHud.shared.startLoading(Get.context!);

      final url = Uri.parse(ApiEndPoint.ADD_COMPANY_URL);

      final req = AddCompanyRequest(
        name: name,
        categoryId: categoryId,
        founderName: founderName,
        description: description,
        logo: logo,
      );

      final request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Accept': 'application/vnd.api+json',
        'Authorization': 'Bearer ${GetStorage().read(ConstantValues.TOKEN)}',
      });

      request.fields.addAll(req.toFields());

      request.files.add(
        await http.MultipartFile.fromPath('logo', req.logo.path),
      );

      debugPrint('=========== REQUEST ===========');
      debugPrint('URL: $url');
      debugPrint('Headers: ${request.headers}');
      debugPrint('Fields: ${request.fields}');
      debugPrint('File: ${req.logo.path}');
      debugPrint('================================');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      ProgressHud.shared.stopLoading();

      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final buildCompanyResponse = BuildCompanyResponse.fromJson(data);
        final newCompany = buildCompanyResponse.result.toCompanyModel();

        final sessionController =
        Get.isRegistered<SessionController>()
            ? Get.find<SessionController>()
            : Get.put(SessionController());

        sessionController.addCompany(newCompany);

        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: S.of(Get.context!).success,
          desc: S.of(Get.context!).yourCompanyHasBeenCreatedSuccessfully,
          btnOkText: S.of(Get.context!).ok,
          btnOkOnPress: () {
            // AppNavigator.of(Get.context!).push(
            //   CompanyOverviewScreen(
            //     logoFile: logo,
            //     companyName: name,
            //     founderName: founderName,
            //     category: categoryName,
            //     description: description,
            //   ),
            // );
          },
        ).show();

        return true;
      } else {
        String errorMessage =
            S.of(Get.context!).unableToCreateTheCompanyPleaseTryAgain;

        if (data is Map<String, dynamic>) {
          if (data['message'] != null &&
              data['message'].toString().trim().isNotEmpty) {
            errorMessage = data['message'].toString();
          }

          if (data['errors'] != null) {
            final errors = data['errors'];

            if (errors is Map<String, dynamic>) {
              final allErrors =
              errors.values.whereType<List>().expand((e) => e).join('\n');

              if (allErrors.isNotEmpty) {
                errorMessage = allErrors;
              }
            } else if (errors is List && errors.isNotEmpty) {
              errorMessage = errors.join('\n');
            }
          }
        }

        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: S.of(Get.context!).error,
          desc: errorMessage,
          btnOkText: S.of(Get.context!).ok,
          btnOkColor: Colors.red,
          btnOkOnPress: () {},
        ).show();

        return false;
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
        btnOkColor: Colors.red,
        title: S.of(Get.context!).error,
        desc:
        S
            .of(Get.context!)
            .somethingWentWrongWhileCreatingTheCompanyPleaseTryAgain,
        btnOkText: S.of(Get.context!).ok,
        btnOkOnPress: () {},
      ).show();

      return false;
    }
  }

  @override
  void onLocaleChanged() {
    fetchCompanyCategories();
  }
}

//
// class CompanyController extends GetxController with LocaleAwareController {
//   List<CompanyCategories> companyCategories = [];
//   List<MyCompanyResponseResult> myCompanyResponseResult = [];
//   ApiStatus apiStatus = ApiStatus.loading;
//   String errorMessage = '';
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCompanyCategories();
//   }
//
//   Future<void> fetchCompanyCategories() async {
//     apiStatus = ApiStatus.loading;
//     update();
//
//     try {
//       final langCode = AppLocale().currentLocale.languageCode;
//       final url = Uri.parse(ApiEndPoint.companyCategoriesUrl(langCode));
//
//       final res = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/vnd.api+json',
//           'accept': 'application/vnd.api+json',
//         },
//       );
//
//       if (res.statusCode == 200) {
//         final parsed = CompanyCategoriesResponse.fromRawJson(res.body);
//         companyCategories = parsed.companyCategoriesResult;
//
//         if (companyCategories.isEmpty) {
//           apiStatus = ApiStatus.empty;
//         } else {
//           apiStatus = ApiStatus.success;
//         }
//       } else {
//         apiStatus = ApiStatus.error;
//         errorMessage = 'Failed to load categories';
//       }
//     } catch (e) {
//       apiStatus = ApiStatus.error;
//       errorMessage = e.toString();
//
//       if (kDebugMode) {
//         print('categories error $e');
//       }
//     }
//
//     update();
//   }
//
//   String getCategoryNameById(int id) {
//     try {
//       return companyCategories.firstWhere((e) => e.id == id).localizedName;
//     } catch (e) {
//       return 'Unknown';
//     }
//   }
//
//   Future<void> getMyCompanyInfo() async {
//     if (CurrentSession().getUser() == null) {
//       myCompanyResponseResult.clear();
//       apiStatus = ApiStatus.guest;
//       errorMessage = '';
//       update();
//       return;
//     }
//
//     apiStatus = ApiStatus.loading;
//     errorMessage = '';
//     update();
//
//     try {
//       final url = Uri.parse(ApiEndPoint.USER_COMPANY_URL);
//
//       final res = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/vnd.api+json',
//           'accept': 'application/vnd.api+json',
//           'Authorization': 'Bearer ${GetStorage().read(ConstantValues.TOKEN)}',
//         },
//       );
//
//       if (res.statusCode == 200) {
//         final parsed = MyCompanyResponse.fromRawJson(res.body);
//         myCompanyResponseResult = parsed.result;
//
//         if (myCompanyResponseResult.isEmpty) {
//           apiStatus = ApiStatus.empty;
//         } else {
//           apiStatus = ApiStatus.success;
//         }
//       } else {
//         apiStatus = ApiStatus.error;
//         errorMessage = S.of(Get.context!).failedToLoadCompanyInformation;
//       }
//     } catch (e) {
//       apiStatus = ApiStatus.error;
//       errorMessage = e.toString();
//     }
//
//     update();
//   }
//
//   Future<bool> buildCompany({
//     required String name,
//     required String categoryId,
//     required String categoryName,
//     required String founderName,
//     required String description,
//     required File logo,
//   }) async {
//     FocusManager.instance.primaryFocus?.unfocus();
//
//     try {
//       ProgressHud.shared.startLoading(Get.context!);
//
//       final url = Uri.parse(ApiEndPoint.ADD_COMPANY_URL);
//
//       final req = AddCompanyRequest(
//         name: name,
//         categoryId: categoryId,
//         founderName: founderName,
//         description: description,
//         logo: logo,
//       );
//
//       final request = http.MultipartRequest('POST', url);
//
//       request.headers.addAll({
//         'Accept': 'application/vnd.api+json',
//         'Authorization': 'Bearer ${GetStorage().read(ConstantValues.TOKEN)}',
//       });
//
//       request.fields.addAll(req.toFields());
//
//       request.files.add(
//         await http.MultipartFile.fromPath('logo', req.logo.path),
//       );
//       debugPrint('=========== REQUEST ===========');
//       debugPrint('URL: $url');
//       debugPrint('Headers: ${request.headers}');
//       debugPrint('Fields: ${request.fields}');
//       debugPrint('File: ${req.logo.path}');
//       debugPrint('================================');
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//
//       ProgressHud.shared.stopLoading();
//
//       debugPrint('Status Code: ${response.statusCode}');
//       debugPrint('Response Body: ${response.body}');
//
//       final data = jsonDecode(response.body);
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final buildCompanyResponse = BuildCompanyResponse.fromJson(data);
//
//         final newCompany = buildCompanyResponse.result.toCompanyModel();
//
//         final sessionController =
//             Get.isRegistered<SessionController>()
//                 ? Get.find<SessionController>()
//                 : Get.put(SessionController());
//
//         sessionController.addCompany(newCompany);
//
//         AwesomeDialog(
//           context: Get.context!,
//           dialogType: DialogType.success,
//           animType: AnimType.bottomSlide,
//           dismissOnTouchOutside: false,
//           dismissOnBackKeyPress: false,
//           title: S.of(Get.context!).success,
//           desc: S.of(Get.context!).yourCompanyHasBeenCreatedSuccessfully,
//           btnOkText: S.of(Get.context!).ok,
//           btnOkOnPress: () {
//             AppNavigator.of(Get.context!).push(
//               CompanyOverviewScreen(
//                 logoFile: logo,
//                 companyName: name,
//                 founderName: founderName,
//                 category: categoryName,
//                 description: description,
//               ),
//             );
//           },
//         ).show();
//
//         return true;
//       } else {
//         String errorMessage =
//             S.of(Get.context!).unableToCreateTheCompanyPleaseTryAgain;
//
//         if (data is Map<String, dynamic>) {
//           if (data['message'] != null &&
//               data['message'].toString().trim().isNotEmpty) {
//             errorMessage = data['message'].toString();
//           }
//
//           if (data['errors'] != null) {
//             final errors = data['errors'];
//
//             if (errors is Map<String, dynamic>) {
//               final allErrors = errors.values
//                   .whereType<List>()
//                   .expand((e) => e)
//                   .join('\n');
//
//               if (allErrors.isNotEmpty) {
//                 errorMessage = allErrors;
//               }
//             } else if (errors is List && errors.isNotEmpty) {
//               errorMessage = errors.join('\n');
//             }
//           }
//         }
//
//         AwesomeDialog(
//           context: Get.context!,
//           dialogType: DialogType.error,
//           animType: AnimType.bottomSlide,
//           dismissOnTouchOutside: false,
//           dismissOnBackKeyPress: false,
//           title: S.of(Get.context!).error,
//           desc: errorMessage,
//           btnOkText: S.of(Get.context!).ok,
//           btnOkColor: Colors.red,
//           btnOkOnPress: () {},
//         ).show();
//
//         return false;
//       }
//     } catch (e, s) {
//       debugPrint('ERROR $e\n$s');
//       ProgressHud.shared.stopLoading();
//
//       AwesomeDialog(
//         context: Get.context!,
//         dialogType: DialogType.error,
//         animType: AnimType.bottomSlide,
//         dismissOnTouchOutside: false,
//         dismissOnBackKeyPress: false,
//         btnOkColor: Colors.red,
//         title: S.of(Get.context!).error,
//         desc:
//             S
//                 .of(Get.context!)
//                 .somethingWentWrongWhileCreatingTheCompanyPleaseTryAgain,
//         btnOkText: S.of(Get.context!).ok,
//         btnOkOnPress: () {},
//       ).show();
//
//       return false;
//     }
//   }
//
//   @override
//   void onLocaleChanged() {
//     fetchCompanyCategories();
//   }
// }
