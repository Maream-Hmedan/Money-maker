class MarketResultResponse {
  final int id;
  final String name;
  final String type;
  final String image;
  final double price;
  final double priceGrowthRate;
  final int copyCount;

  MarketResultResponse({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.price,
    required this.priceGrowthRate,
    required this.copyCount,
  });

  factory MarketResultResponse.fromJson(Map<String, dynamic> json) {
    return MarketResultResponse(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      priceGrowthRate: (json['price_growth_rate'] ?? 0).toDouble(),
      copyCount: json['copy_count'] ?? 0,
    );
  }
}
