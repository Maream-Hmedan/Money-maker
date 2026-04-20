import 'dart:convert';

class EditProfileResponse {
  final String message;
  final User user;

  EditProfileResponse({
    required this.message,
    required this.user,
  });

  factory EditProfileResponse.fromRawJson(String str) =>
      EditProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) =>
      EditProfileResponse(
        message: json["message"]?.toString() ?? "",
        user: User.fromJson(json["user"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double balance;
  final double portoflioValue;
  final int countryId;
  final String phoneNumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.twoFactorSecret,
    required this.twoFactorRecoveryCodes,
    required this.twoFactorConfirmedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.balance,
    required this.portoflioValue,
    required this.countryId,
    required this.phoneNumber,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: _toInt(json["id"]) ?? 0,
    name: json["name"]?.toString() ?? "",
    email: json["email"]?.toString() ?? "",
    emailVerifiedAt: json["email_verified_at"],
    twoFactorSecret: json["two_factor_secret"],
    twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
    twoFactorConfirmedAt: json["two_factor_confirmed_at"],
    createdAt:
    DateTime.tryParse(json["created_at"]?.toString() ?? "") ??
        DateTime.now(),
    updatedAt:
    DateTime.tryParse(json["updated_at"]?.toString() ?? "") ??
        DateTime.now(),
    balance: _toDouble(json["balance"]),
    portoflioValue: _toDouble(json["portoflio_value"]),
    countryId: _toInt(json["country_id"]) ?? 0,
    phoneNumber: json["phone_number"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "two_factor_secret": twoFactorSecret,
    "two_factor_recovery_codes": twoFactorRecoveryCodes,
    "two_factor_confirmed_at": twoFactorConfirmedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "balance": balance,
    "portoflio_value": portoflioValue,
    "country_id": countryId,
    "phone_number": phoneNumber,
  };

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString());
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}