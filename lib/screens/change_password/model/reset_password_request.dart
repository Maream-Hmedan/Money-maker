import 'dart:convert';

class ChangePasswordRequest {
  final String password;
  final String passwordConfirmation;

  ChangePasswordRequest({
    required this.password,
    required this.passwordConfirmation,
  });

  factory ChangePasswordRequest.fromRawJson(String str) =>
      ChangePasswordRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      ChangePasswordRequest(
        password: json["password"] ?? '',
        passwordConfirmation: json["password_confirmation"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "password": password,
    "password_confirmation": passwordConfirmation,
  };
}