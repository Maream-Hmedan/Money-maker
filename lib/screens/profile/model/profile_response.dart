import 'dart:convert';

class{
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final CountryProfile country;
  final int balance;
  final int portoflioValue;

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
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      phoneNumber: json["phone_number"] ?? '',
      country: CountryProfile.fromJson(json["country"] ?? {}),
      balance: json["balance"] ?? 0,
      portoflioValue: json["portoflio_value"] ?? 0,
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
    int? balance,
    int? portoflioValue,
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