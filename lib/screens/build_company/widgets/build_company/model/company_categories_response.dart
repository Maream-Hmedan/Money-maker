import 'dart:convert';

import 'package:money_maker/l10n/app_locale.dart';

class CompanyCategoriesResponse {
  final List<dynamic> errors;
  final String message;
  final List<CompanyCategories> companyCategoriesResult;

  CompanyCategoriesResponse({
    required this.errors,
    required this.message,
    required this.companyCategoriesResult,
  });

  factory CompanyCategoriesResponse.fromRawJson(String str) =>
      CompanyCategoriesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CompanyCategoriesResponse(
        errors: json["errors"] == null
            ? []
            : List<dynamic>.from(json["errors"].map((x) => x)),
        message: json["message"] ?? '',
        companyCategoriesResult: json["result"] == null
            ? []
            : List<CompanyCategories>.from(
          json["result"].map((x) => CompanyCategories.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "message": message,
    "result":
    List<dynamic>.from(companyCategoriesResult.map((x) => x.toJson())),
  };
}

class CompanyCategories {
  final int id;
  final Name name;
  final Name description;
  final dynamic image;
  final dynamic createdAt;
  final dynamic updatedAt;

  CompanyCategories({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CompanyCategories.fromJson(Map<String, dynamic> json) =>
      CompanyCategories(
        id: json["id"] ?? 0,
        name: Name.fromJson(json["name"] ?? {}),
        description: Name.fromJson(json["description"] ?? {}),
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name.toJson(),
    "description": description.toJson(), // ✅ fix
    "image": image,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  String get localizedName {
    final langCode = AppLocale().currentLocale.languageCode;
    return langCode == 'ar' ? name.ar : name.en;
  }

  String get localizedDescription {
    final langCode = AppLocale().currentLocale.languageCode;
    return langCode == 'ar' ? description.ar : description.en;
  }
}

class Name {
  final String ar;
  final String en;

  Name({
    required this.ar,
    required this.en,
  });

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    ar: json["ar"] ?? '',
    en: json["en"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "ar": ar,
    "en": en,
  };
}
