import 'dart:convert';

class RegisterResponse {
  final User user;
  final String accessToken;

  RegisterResponse({
    required this.user,
    required this.accessToken,
  });

  factory RegisterResponse.fromRawJson(String str) => RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    user: User.fromJson(json["user"]),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "access_token": accessToken,
  };
}

class User {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final Country country;
  final int balance;
  final int portoflioValue;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.balance,
    required this.portoflioValue,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    country: Country.fromJson(json["country"]),
    balance: json["balance"],
    portoflioValue: json["portoflio_value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "country": country.toJson(),
    "balance": balance,
    "portoflio_value": portoflioValue,
  };
}

class Country {
  final String name;
  final String isoCode;
  final String image;
  final int order;

  Country({
    required this.name,
    required this.isoCode,
    required this.image,
    required this.order,
  });

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
    isoCode: json["iso_code"],
    image: json["image"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "iso_code": isoCode,
    "image": image,
    "order": order,
  };
}
