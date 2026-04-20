import 'dart:convert';

class BuyOfferResponse {
  final String message;

  BuyOfferResponse({
    required this.message,
  });

  factory BuyOfferResponse.fromRawJson(String str) => BuyOfferResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BuyOfferResponse.fromJson(Map<String, dynamic> json) => BuyOfferResponse(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
