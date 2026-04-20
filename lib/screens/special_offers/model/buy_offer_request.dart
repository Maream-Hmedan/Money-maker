import 'dart:convert';

class BuyAssetsRequest {
  final String copyCount;
  final String saleOfferId;
  final String assetId;
  final String companyId;

  BuyAssetsRequest({
    required this.copyCount,
    required this.saleOfferId,
    required this.assetId,
    required this.companyId,
  });

  factory BuyAssetsRequest.fromRawJson(String str) =>
      BuyAssetsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BuyAssetsRequest.fromJson(Map<String, dynamic> json) =>
      BuyAssetsRequest(
        copyCount: json["copy_count"] ?? "",
        saleOfferId: json["sale_offer_id"] ?? "",
        assetId: json["asset_id"] ?? "",
        companyId: json["company_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "copy_count": copyCount,
    "sale_offer_id": saleOfferId,
    "asset_id": assetId,
    "company_id": companyId,
  };
}