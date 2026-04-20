import 'dart:convert';

class TopUpBalanceRequest {
  final String amount;
  final String method;

  TopUpBalanceRequest({
    required this.amount,
    required this.method,
  });

  factory TopUpBalanceRequest.fromRawJson(String str) =>
      TopUpBalanceRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopUpBalanceRequest.fromJson(Map<String, dynamic> json) =>
      TopUpBalanceRequest(
        amount: json["amount"] ?? '',
        method: json["method"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "method": method,
  };
}