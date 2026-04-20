import 'dart:convert';

class BuyOfferRequest {
  final String copyCount;
  final String offerId;


  BuyOfferRequest({
    required this.copyCount,
    required this.offerId,
  });

  factory BuyOfferRequest.fromRawJson(String str) =>
      BuyOfferRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BuyOfferRequest.fromJson(Map<String, dynamic> json) =>
      BuyOfferRequest(
        copyCount: json["copy_count"] ?? "",
        offerId: json["offer_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "copy_count": copyCount,
    "offer_id": offerId,
  };
}