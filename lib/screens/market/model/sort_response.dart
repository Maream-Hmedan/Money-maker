import 'dart:convert';

class SortResponse {
  final List<dynamic> errors;
  final String message;
  final List<SortResult> sortResult;

  SortResponse({
    required this.errors,
    required this.message,
    required this.sortResult,
  });

  factory SortResponse.fromRawJson(String str) => SortResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SortResponse.fromJson(Map<String, dynamic> json) => SortResponse(
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    message: json["message"],
    sortResult: List<SortResult>.from(json["result"].map((x) => SortResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "message": message,
    "result": List<dynamic>.from(sortResult.map((x) => x.toJson())),
  };
}

class SortResult {
  final int id;
  final String name;
  final String type;
  final String image;
  final double price;
  final double priceGrowthRate;
  final int copyCount;

  SortResult({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.price,
    required this.priceGrowthRate,
    required this.copyCount,
  });

  factory SortResult.fromRawJson(String str) =>
      SortResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SortResult.fromJson(Map<String, dynamic> json) => SortResult(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    type: json["type"] ?? '',
    image: json["image"] ?? '',
    price: (json["price"] ?? 0).toDouble(),
    priceGrowthRate: (json["price_growth_rate"] ?? 0).toDouble(),
    copyCount: json["copy_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "image": image,
    "price": price,
    "price_growth_rate": priceGrowthRate,
    "copy_count": copyCount,
  };
}
