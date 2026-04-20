import 'dart:convert';

class RegisterResponse {
  final UserModel user;
  final String accessToken;

  RegisterResponse({
    required this.user,
    required this.accessToken,
  });

  factory RegisterResponse.fromRawJson(String str) =>
      RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        user: UserModel.fromJson(json["user"] ?? {}),
        accessToken: json["access_token"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "access_token": accessToken,
  };
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final CountryModel country;
  final double balance;
  final double portfolioValue;
  final bool hasCompanies;
  final List<CompanyModel> companies;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.balance,
    required this.portfolioValue,
    required this.hasCompanies,
    required this.companies,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    email: json["email"] ?? '',
    phoneNumber: json["phone_number"] ?? '',
    country: CountryModel.fromJson(json["country"] ?? {}),
    balance: (json["balance"] as num?)?.toDouble() ?? 0.0,
    portfolioValue: (json["portoflio_value"] as num?)?.toDouble() ?? 0.0,
    hasCompanies: json["has_companies"] ?? false,
    companies: json["companies"] == null
        ? []
        : List<CompanyModel>.from(
      (json["companies"] as List)
          .map((x) => CompanyModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "country": country.toJson(),
    "balance": balance,
    "portoflio_value": portfolioValue,
    "has_companies": hasCompanies,
    "companies": List<dynamic>.from(companies.map((x) => x.toJson())),
  };

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
    CountryModel? country,
    double? balance,
    double? portfolioValue,
    bool? hasCompanies,
    List<CompanyModel>? companies,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      balance: balance ?? this.balance,
      portfolioValue: portfolioValue ?? this.portfolioValue,
      hasCompanies: hasCompanies ?? this.hasCompanies,
      companies: companies ?? this.companies,
    );
  }
}

class CountryModel {
  final int id;
  final String name;
  final String? prefix;
  final String isoCode;
  final String image;
  final int order;

  CountryModel({
    required this.id,
    required this.name,
    required this.prefix,
    required this.isoCode,
    required this.image,
    required this.order,
  });

  factory CountryModel.fromRawJson(String str) =>
      CountryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    prefix: json["prefix"],
    isoCode: json["iso_code"] ?? '',
    image: json["image"] ?? '',
    order: json["order"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "prefix": prefix,
    "iso_code": isoCode,
    "image": image,
    "order": order,
  };
}

class CompanyModel {
  final int id;
  final String name;
  final int categoryId;
  final int userId;
  final String founderName;
  final String description;
  final String logo;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CompanyModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.userId,
    required this.founderName,
    required this.description,
    required this.logo,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CompanyModel.fromRawJson(String str) =>
      CompanyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    categoryId: json["category_id"] ?? 0,
    userId: json["user_id"] ?? 0,
    founderName: json["founder_name"] ?? '',
    description: json["description"] ?? '',
    logo: json["logo"] ?? '',
    status: json["status"] ?? '',
    createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category_id": categoryId,
    "user_id": userId,
    "founder_name": founderName,
    "description": description,
    "logo": logo,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}