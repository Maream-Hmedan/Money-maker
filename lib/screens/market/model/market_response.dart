import 'dart:convert';

class MarketResponse {
  final List<dynamic> errors;
  final String message;
  final List<MarketResultResponse> result;

  MarketResponse({
    required this.errors,
    required this.message,
    required this.result,
  });

  factory MarketResponse.fromRawJson(String str) =>
      MarketResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarketResponse.fromJson(Map<String, dynamic> json) {
    return MarketResponse(
      errors: json['errors'] is List ? json['errors'] : [],
      message: json['message']?.toString() ?? '',
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => MarketResultResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errors': errors,
      'message': message,
      'result': result.map((e) => e.toJson()).toList(),
    };
  }
}

class MarketResultResponse {
  final int id;
  final String name;
  final String image;
  final double price;
  final double priceGrowthRate;
  final int copyCount;
  final String type;
  final String? typeEn;

  MarketResultResponse({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.priceGrowthRate,
    required this.copyCount,
    required this.type,
    this.typeEn,
  });

  factory MarketResultResponse.fromJson(Map<String, dynamic> json) {
    return MarketResultResponse(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      priceGrowthRate:
      (json['price_growth_rate'] as num?)?.toDouble() ?? 0.0,
      copyCount: json['copy_count'] is int
          ? json['copy_count']
          : int.tryParse('${json['copy_count']}') ?? 0,
      type: json['type']?.toString() ?? '',
      typeEn: json['type_en']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'price_growth_rate': priceGrowthRate,
      'copy_count': copyCount,
      'type': type,
      'type_en': typeEn,
    };
  }
}