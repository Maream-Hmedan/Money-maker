import 'dart:convert';

class CountriesResponse {
  final List<dynamic> errors;
  final String message;
  final List<Countries> countries;

  CountriesResponse({
    required this.errors,
    required this.message,
    required this.countries,
  });

  factory CountriesResponse.fromRawJson(String str) => CountriesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountriesResponse.fromJson(Map<String, dynamic> json) => CountriesResponse(
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    message: json["message"],
    countries: List<Countries>.from(json["result"].map((x) => Countries.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "message": message,
    "result": List<dynamic>.from(countries.map((x) => x.toJson())),
  };
}

class Countries {
  final int id;
  final String name;
  final String? prefix;
  final String isoCode;
  final String image;
  final int order;

  Countries({
    required this.id,
    required this.name,
    required this.isoCode,
    required this.image,
    required this.order,
    this.prefix,
  });

  factory Countries.fromRawJson(String str) => Countries.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    prefix: json["prefix"],
    isoCode: json["iso_code"] ?? '',
    image: json["image"] ?? '',
    order: json["order"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "prefix": prefix,
    "iso_code": isoCode,
    "image": image,
    "order": order,
  };

  @override
  String toString() => name;
}