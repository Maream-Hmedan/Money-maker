import 'dart:convert';

class CancelSaleResponse {
  final List<dynamic> errors;
  final String message;
  final String result;

  CancelSaleResponse({
    required this.errors,
    required this.message,
    required this.result,
  });

  factory CancelSaleResponse.fromRawJson(String str) => CancelSaleResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CancelSaleResponse.fromJson(Map<String, dynamic> json) => CancelSaleResponse(
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    message: json["message"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "message": message,
    "result": result,
  };
}
