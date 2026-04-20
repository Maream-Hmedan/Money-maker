import 'dart:convert';

class ContactUsResponse {
  final List<dynamic> errors;
  final String message;
  final ContactUs contactUsResult;

  ContactUsResponse({
    required this.errors,
    required this.message,
    required this.contactUsResult,
  });

  factory ContactUsResponse.fromRawJson(String str) =>
      ContactUsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) =>
      ContactUsResponse(
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        message: json["message"],
        contactUsResult: ContactUs.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "message": message,
    "result": contactUsResult.toJson(),
  };
}

class ContactUs {
  final int id;
  final String name;
  final String email;
  final String phone;
  final int? conditionValue;
  final String address;
  final String? logo;
  final String? facebook;
  final String? instagram;
  final String? linkedin;
  final String? youtube;
  final DateTime createdAt;
  final DateTime updatedAt;

  ContactUs({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.conditionValue,
    required this.address,
    this.logo,
    this.facebook,
    this.instagram,
    this.linkedin,
    this.youtube,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContactUs.fromRawJson(String str) =>
      ContactUs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactUs.fromJson(Map<String, dynamic> json) => ContactUs(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    conditionValue: json["condition_value"],
    address: json["address"],
    logo: json["logo"],
    facebook: json["facebook"],
    instagram: json["instagram"],
    linkedin: json["linkedin"],
    youtube: json["youtube"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "condition_value": conditionValue,
    "address": address,
    "logo": logo,
    "facebook": facebook,
    "instagram": instagram,
    "linkedin": linkedin,
    "youtube": youtube,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}