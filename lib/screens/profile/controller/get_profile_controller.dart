import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:money_maker/controllers/api_end_point.dart';
import 'package:money_maker/controllers/constant_values.dart';
import 'package:money_maker/screens/get_countries/model/countries_response.dart';

class ProfileController extends GetxController {
  bool isLoading = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  Countries? selectedCountry;
  final RxString dialCode = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  Future<void> getProfileData() async {
    isLoading = true;
    update();

    try {
      final url = Uri.parse(ApiEndPoint.PROFILE_URL);
      final token = GetStorage().read(ConstantValues.TOKEN);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
        },
      );

      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone_number'] ?? '';

        if (data['country'] != null) {
          final countryData = data['country'];
          selectedCountry = Countries(
            name: countryData['name'] ?? '',
            isoCode: countryData['iso_code'] ?? '',
            image: countryData['image'] ?? '',
            order: countryData['order'] ?? 0,
            id: countryData['order'] ?? 1,
            prefix: countryData['prefix'],
          );
          WidgetsBinding.instance.addPostFrameCallback((_) {
            dialCode.value = selectedCountry?.prefix ?? '';
          });
        }
      }
    } catch (e) {
      debugPrint('ERROR $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void setSelectedCountry(Countries? country) {
    selectedCountry = country;
    dialCode.value = country?.prefix ?? '';
    update();
  }
}
