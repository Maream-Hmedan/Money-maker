import 'dart:convert';

class RegisterRequest {
  final String email;
  final String password;
  final String name;
  final String passwordConfirmation;
  final String phoneNumber;
  final String countryId;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.passwordConfirmation,
    required this.phoneNumber,
    required this.countryId,
  });

  factory RegisterRequest.fromRawJson(String str) => RegisterRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => RegisterRequest(
    email: json["email"],
    password: json["password"],
    name: json["name"],
    passwordConfirmation: json["password_confirmation"],
    phoneNumber: json["phone_number"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "name": name,
    "password_confirmation": passwordConfirmation,
    "phone_number": phoneNumber,
    "country_id": countryId,
  };
}
