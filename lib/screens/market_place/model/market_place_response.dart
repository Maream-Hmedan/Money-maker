class MarketPlaceResponse {
  final List<String> errors;
  final String message;
  final List<MarketItem> result;

  MarketPlaceResponse({
    required this.errors,
    required this.message,
    required this.result,
  });

  factory MarketPlaceResponse.fromJson(Map<String, dynamic> json) {
    return MarketPlaceResponse(
      errors: List<String>.from(json['errors'] ?? []),
      message: json['message'] ?? '',
      result: (json['result'] as List<dynamic>? ?? [])
          .map((e) => MarketItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class MarketItem {
  final int id;
  final String assetName;
  final double price;
  final String type;
  final String? ownerName;
  final int copyCount;
  final DateTime? publishDate;
  final String image;
  final double priceGrowthRate;
  final bool isMine;

  MarketItem({
    required this.id,
    required this.assetName,
    required this.price,
    required this.type,
    this.ownerName,
    required this.copyCount,
    this.publishDate,
    required this.image,
    required this.priceGrowthRate,
    required this.isMine,
  });

  factory MarketItem.fromJson(Map<String, dynamic> json) {
    return MarketItem(
      id: json['id'] ?? 0,
      assetName: json['asset_name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      type: json['type'] ?? '',
      ownerName: json['owner_name'],
      copyCount: json['copy_count'] ?? 0,
      publishDate: json['publish_date'] != null
          ? DateTime.tryParse(json['publish_date'])
          : null,
      image: json['image'] ?? '',
      priceGrowthRate:
      (json['price_growth_rate'] as num?)?.toDouble() ?? 0.0,
      isMine: json['is_mine'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'asset_name': assetName,
      'price': price,
      'type': type,
      'owner_name': ownerName,
      'copy_count': copyCount,
      'publish_date': publishDate?.toIso8601String(),
      'image': image,
      'price_growth_rate': priceGrowthRate,
      'is_mine': isMine,
    };
  }
}