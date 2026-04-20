class SellPortfolioRequest {
  final String assetId;
  final String saleCopyCount;
  final double price;

  SellPortfolioRequest({
    required this.assetId,
    required this.saleCopyCount,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'asset_id': assetId,
      'sale_copy_count': saleCopyCount,
      'price': price.toString(),
    };
  }

  factory SellPortfolioRequest.fromJson(Map<String, dynamic> json) {
    return SellPortfolioRequest(
      assetId: json['asset_id']?.toString() ?? '',
      saleCopyCount: json['sale_copy_count']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0,
    );
  }
}