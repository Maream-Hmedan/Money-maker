import 'dart:convert';

class UserProfileResponse {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final CountryProfile country;
  final double balance;
  final double portoflioValue;

  UserProfileResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.balance,
    required this.portoflioValue,
  });

  factory UserProfileResponse.fromRawJson(String str) =>
      UserProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      id: _toInt(json["id"]) ?? 0,
      name: json["name"]?.toString() ?? '',
      email: json["email"]?.toString() ?? '',
      phoneNumber: json["phone_number"]?.toString() ?? '',
      country: CountryProfile.fromJson(json["country"] ?? {}),
      balance: _toDouble(json["balance"]),
      portoflioValue: _toDouble(json["portoflio_value"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "country": country.toJson(),
      "balance": balance,
      "portoflio_value": portoflioValue,
    };
  }

  UserProfileResponse copyWith({
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
    CountryProfile? country,
    double? balance,
    double? portoflioValue,
  }) {
    return UserProfileResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      balance: balance ?? this.balance,
      portoflioValue: portoflioValue ?? this.portoflioValue,
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}

class CountryProfile {
  final int id;
  final String name;
  final String? prefix;
  final String isoCode;
  final String image;
  final int order;

  CountryProfile({
    required this.id,
    required this.name,
    required this.prefix,
    required this.isoCode,
    required this.image,
    required this.order,
  });

  factory CountryProfile.fromRawJson(String str) =>
      CountryProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryProfile.fromJson(Map<String, dynamic> json) {
    return CountryProfile(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      prefix: json["prefix"],
      isoCode: json["iso_code"] ?? '',
      image: json["image"] ?? '',
      order: json["order"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "prefix": prefix,
      "iso_code": isoCode,
      "image": image,
      "order": order,
    };
  }
}