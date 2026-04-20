import 'dart:convert';

class GetPortfolioResponse {
  final List<dynamic> errors;
  final String message;
  final List<Portfolio> portfolio;

  GetPortfolioResponse({
    required this.errors,
    required this.message,
    required this.portfolio,
  });

  factory GetPortfolioResponse.fromRawJson(String str) =>
      GetPortfolioResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPortfolioResponse.fromJson(Map<String, dynamic> json) =>
      GetPortfolioResponse(
        errors: List<dynamic>.from((json["errors"] ?? []).map((x) => x)),
        message: json["message"] ?? "",
        portfolio: List<Portfolio>.from(
          (json["result"] ?? []).map((x) => Portfolio.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "message": message,
    "result": List<dynamic>.from(portfolio.map((x) => x.toJson())),
  };
}

class Portfolio {
  final int id;
  final String name;
  final String type;
  final String image;
  final double price;
  final double priceGrowthRate;
  final int totalCopyCount;
  final int restCopyCount;
  final int saleCopyCount;

  Portfolio({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.price,
    required this.priceGrowthRate,
    required this.totalCopyCount,
    required this.restCopyCount,
    required this.saleCopyCount,
  });

  factory Portfolio.fromRawJson(String str) =>
      Portfolio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    type: json["type"] ?? "",
    image: json["image"] ?? "",
    price: (json["price"] as num?)?.toDouble() ?? 0.0,
    priceGrowthRate:
    (json["price_growth_rate"] as num?)?.toDouble() ?? 0.0,
    totalCopyCount: (json["total_copy_count"] ?? 0).toInt(),
    restCopyCount: (json["rest_copy_count"] ?? 0).toInt(),
    saleCopyCount: (json["sale_copy_count"] ?? 0).toInt(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "image": image,
    "price": price,
    "price_growth_rate": priceGrowthRate,
    "total_copy_count": totalCopyCount,
    "rest_copy_count": restCopyCount,
    "sale_copy_count": saleCopyCount,
  };
}