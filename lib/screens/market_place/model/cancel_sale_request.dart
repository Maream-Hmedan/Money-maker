class CancelPortfolioRequest {
  final String saleOfferId;


  CancelPortfolioRequest({
    required this.saleOfferId,
  });

  Map<String, dynamic> toJson() {
    return {
      'sale_offer_id': saleOfferId,
    };
  }

  factory CancelPortfolioRequest.fromJson(Map<String, dynamic> json) {
    return CancelPortfolioRequest(
      saleOfferId: json['sale_offer_id']?.toString() ?? '',
    );
  }
}