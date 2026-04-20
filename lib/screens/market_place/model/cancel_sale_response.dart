class CancelSaleRequest {
  final String saleOfferId;


  CancelSaleRequest({
    required this.saleOfferId,
  });

  Map<String, dynamic> toJson() {
    return {
      'sale_offer_id': saleOfferId,
    };
  }

  factory CancelSaleRequest.fromJson(Map<String, dynamic> json) {
    return CancelSaleRequest(
      saleOfferId: json['sale_offer_id']?.toString() ?? '',
    );
  }
}