import 'dart:convert';

class SellPortfolioResponse {
  final List<dynamic> errors;
  final String message;
  final SellResponse result;

  SellPortfolioResponse({
    required this.errors,
    required this.message,
    required this.result,
  });

  factory SellPortfolioResponse.fromRawJson(String str) => SellPortfolioResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellPortfolioResponse.fromJson(Map<String, dynamic> json) => SellPortfolioResponse(
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    message: json["message"],
    result: SellResponse.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "message": message,
    "result": result.toJson(),
  };
}

class SellResponse {
  final int id;
  final String assetName;
  final double price; // <- double
  final String type;
  final String ownerName;
  final String copyCount;
  final DateTime publishDate;
  final String image;
  final int priceGrowthRate;

  SellResponse({
    required this.id,
    required this.assetName,
    required this.price,
    required this.type,
    required this.ownerName,
    required this.copyCount,
    required this.publishDate,
    required this.image,
    required this.priceGrowthRate,
  });

  factory SellResponse.fromJson(Map<String, dynamic> json) => SellResponse(
    id: json["id"],
    assetName: json["asset_name"],
    price: (json["price"] is int)
        ? (json["price"] as int).toDouble()
        : double.tryParse(json["price"].toString()) ?? 0.0,
    type: json["type"],
    ownerName: json["owner_name"],
    copyCount: json["copy_count"].toString(),
    publishDate: DateTime.parse(json["publish_date"]),
    image: json["image"],
    priceGrowthRate: json["price_growth_rate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "asset_name": assetName,
    "price": price,
    "type": type,
    "owner_name": ownerName,
    "copy_count": copyCount,
    "publish_date": publishDate.toIso8601String(),
    "image": image,
    "price_growth_rate": priceGrowthRate,
  };
}
