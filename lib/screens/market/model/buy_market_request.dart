import 'dart:convert';

class BuyAssetsRequest {
  final String assetId;
  final String copyCount;

  BuyAssetsRequest({
    required this.assetId,
    required this.copyCount,
  });

  factory BuyAssetsRequest.fromRawJson(String str) =>
      BuyAssetsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BuyAssetsRequest.fromJson(Map<String, dynamic> json) {
    return BuyAssetsRequest(
      assetId: json["asset_id"] ?? '',
      copyCount: json["copy_count"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "asset_id": assetId,
      "copy_count": copyCount,
    };
  }
}