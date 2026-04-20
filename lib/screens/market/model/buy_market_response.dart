import 'dart:convert';

class BuyAssetsResponse {
  final List<dynamic> errors;
  final String message;
  final dynamic result;

  BuyAssetsResponse({
    required this.errors,
    required this.message,
    required this.result,
  });

  factory BuyAssetsResponse.fromRawJson(String str) =>
      BuyAssetsResponse.fromJson(json.decode(str));

  factory BuyAssetsResponse.fromJson(Map<String, dynamic> json) =>
      BuyAssetsResponse(
        errors: List<dynamic>.from((json["errors"] ?? []).map((x) => x)),
        message: json["message"] ?? "",
        result: json["result"],
      );
}
