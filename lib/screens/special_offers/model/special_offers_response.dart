import 'dart:convert';

class OffersResponse {
  final List<dynamic> errors;
  final String message;
  final List<OfferItem> result;

  OffersResponse({
    required this.errors,
    required this.message,
    required this.result,
  });

  factory OffersResponse.fromRawJson(String str) =>
      OffersResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OffersResponse.fromJson(Map<String, dynamic> json) =>
      OffersResponse(
        errors: List<dynamic>.from((json["errors"] ?? []).map((x) => x)),
        message: json["message"] ?? "",
        result: List<OfferItem>.from(
          (json["result"] ?? []).map((x) => OfferItem.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class OfferItem {
  final int id;
  final String title;
  final String description;
  final String type;
  final String discountPercent;
  final double? discountAmount;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final String image;
  final double offerPrice;

  OfferItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.discountPercent,
    required this.discountAmount,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.image,
    required this.offerPrice,
  });

  factory OfferItem.fromRawJson(String str) =>
      OfferItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  factory OfferItem.fromJson(Map<String, dynamic> json) => OfferItem(
    id: _toInt(json["id"]),
    title: json["title"]?.toString() ?? "",
    description: json["description"]?.toString() ?? "",
    type: json["type"]?.toString() ?? "",
    discountPercent: json["discount_percent"]?.toString() ?? "0",
    discountAmount: _toDouble(json["discount_amount"]),
    startDate: DateTime.tryParse(json["start_date"]?.toString() ?? "") ??
        DateTime.now(),
    endDate: DateTime.tryParse(json["end_date"]?.toString() ?? "") ??
        DateTime.now(),
    price: _toDouble(json["price"]) ?? 0.0,
    image: json["image"]?.toString() ?? "",
    offerPrice: _toDouble(json["offer_price"]) ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "type": type,
    "discount_percent": discountPercent,
    "discount_amount": discountAmount,
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "price": price,
    "image": image,
    "offer_price": offerPrice,
  };
}