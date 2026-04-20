class MarketResultResponse {
  final int id;
  final String name;
  final String ownerName;
  final String image;
  final double price;
  final double priceGrowthRate;
  final int copyCount;
  final String type;

  MarketResultResponse({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.image,
    required this.price,
    required this.priceGrowthRate,
    required this.copyCount,
    required this.type,
  });

  factory MarketResultResponse.fromJson(Map<String, dynamic> json) {
    return MarketResultResponse(
      id: json['id'] ?? 0,
      name: json['asset_name'] ?? '',
      ownerName: json['owner_name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      priceGrowthRate: (json['price_growth_rate'] ?? 0).toDouble(),
      copyCount: json['copy_count'] ?? 0,
      type: json['type']??'',
    );
  }
}