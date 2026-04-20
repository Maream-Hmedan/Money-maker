import 'dart:convert';

class FilterResponse {
  final List<dynamic> errors;
  final String message;
  final List<FilterResult> result;

  FilterResponse({
    required this.errors,
    required this.message,
    required this.result,
  });

  factory FilterResponse.fromRawJson(String str) =>
      FilterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilterResponse.fromJson(Map<String, dynamic> json) => FilterResponse(
    errors: List<dynamic>.from((json["errors"] ?? []).map((x) => x)),
    message: json["message"] ?? "",
    result: List<FilterResult>.from(
      (json["result"] ?? []).map((x) => FilterResult.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class FilterResult {
  final int id;
  final String name;
  final String type;
  final String image;
  final double price;
  final double priceGrowthRate;
  final int copyCount;

  FilterResult({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.price,
    required this.priceGrowthRate,
    required this.copyCount,
  });

  factory FilterResult.fromRawJson(String str) =>
      FilterResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilterResult.fromJson(Map<String, dynamic> json) => FilterResult(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    type: json["type"] ?? "",
    image: json["image"] ?? "",
    price: (json["price"] as num?)?.toDouble() ?? 0.0,
    priceGrowthRate:
    (json["price_growth_rate"] as num?)?.toDouble() ?? 0.0,
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