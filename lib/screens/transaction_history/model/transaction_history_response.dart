import 'dart:convert';

class TransactionHistoryResponse {
  final List<dynamic> errors;
  final String message;
  final List<Order> result;

  TransactionHistoryResponse({
    required this.errors,
    required this.message,
    required this.result,
  });

  factory TransactionHistoryResponse.fromRawJson(String str) =>
      TransactionHistoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryResponse(
      errors: json["errors"] == null
          ? []
          : List<dynamic>.from(json["errors"].map((x) => x)),
      message: json["message"]?.toString() ?? "",
      result: json["result"] == null
          ? []
          : List<Order>.from(
        (json["result"] as List).map((x) => Order.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Order {
  final int id;
  final int? buyerId;
  final String? buyerName;
  final String? buyerImage;
  final int? sellerId;
  final String? sellerName;
  final int? companyId;
  final int? saleOfferId;
  final int? assetId;
  final String? assetImage;
  final String? assetName;
  final String? price;
  final String? type;
  final int? copyCount;

  Order({
    required this.id,
    this.buyerId,
    this.buyerName,
    this.buyerImage,
    this.sellerId,
    this.sellerName,
    this.companyId,
    this.saleOfferId,
    this.assetId,
    this.assetImage,
    this.assetName,
    this.price,
    this.type,
    this.copyCount,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: _toInt(json["id"]) ?? 0,
      buyerId: _toInt(json["buyer_id"]),
      buyerName: json["buyer_name"]?.toString(),
      buyerImage: json["buyer_image"]?.toString(),
      sellerId: _toInt(json["seller_id"]),
      sellerName: json["seller_name"]?.toString(),
      companyId: _toInt(json["company_id"]),
      saleOfferId: _toInt(json["sale_offer_id"]),
      assetId: _toInt(json["asset_id"]),
      assetImage: json["asset_image"]?.toString(),
      assetName: json["asset_name"]?.toString(),
      price: json["price"]?.toString(),
      type: json["type"]?.toString(),
      copyCount: _toInt(json["copy_count"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "buyer_id": buyerId,
    "buyer_name": buyerName,
    "buyer_image": buyerImage,
    "seller_id": sellerId,
    "seller_name": sellerName,
    "company_id": companyId,
    "sale_offer_id": saleOfferId,
    "asset_id": assetId,
    "asset_image": assetImage,
    "asset_name": assetName,
    "price": price,
    "type": type,
    "copy_count": copyCount,
  };

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  double get priceAsDouble => double.tryParse(price ?? '0') ?? 0.0;

  bool get hasValidImage =>
      assetImage != null &&
          assetImage!.isNotEmpty &&
          (assetImage!.startsWith('http://') || assetImage!.startsWith('https://'));

  String get displayUserName {
    if ((sellerName ?? '').trim().isNotEmpty) return sellerName!.trim();
    if ((buyerName ?? '').trim().isNotEmpty) return buyerName!.trim();
    return '';
  }

  bool get isBuy => type?.toLowerCase() == 'buy';
  bool get isSell => type?.toLowerCase() == 'sell';
  bool get isBuyOffer => type?.toLowerCase() == 'buy_offer';
}