import 'dart:convert';

class MyCompanyResponse {
  final List<dynamic> errors;
  final String message;
  final List<MyCompanyResponseResult> result;

  MyCompanyResponse({
    required this.errors,
    required this.message,
    required this.result,
  });

  factory MyCompanyResponse.fromRawJson(String str) =>
      MyCompanyResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyCompanyResponse.fromJson(Map<String, dynamic> json) =>
      MyCompanyResponse(
        errors: json["errors"] == null
            ? []
            : List<dynamic>.from(json["errors"]),
        message: json["message"] ?? '',
        result: json["result"] == null
            ? []
            : List<MyCompanyResponseResult>.from(
          json["result"].map((x) => MyCompanyResponseResult.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors),
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class MyCompanyResponseResult {
  final int id;
  final String name;
  final int categoryId;
  final int userId;
  final String? founderName;
  final String description;
  final String logo;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  MyCompanyResponseResult({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.userId,
    required this.founderName,
    required this.description,
    required this.logo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyCompanyResponseResult.fromRawJson(String str) =>
      MyCompanyResponseResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyCompanyResponseResult.fromJson(Map<String, dynamic> json) =>
      MyCompanyResponseResult(
        id: int.tryParse(json["id"].toString()) ?? 0,
        name: json["name"] ?? '',
        categoryId: int.tryParse(json["category_id"].toString()) ?? 0,
        userId: int.tryParse(json["user_id"].toString()) ?? 0,
        founderName: json["founder_name"],
        description: json["description"] ?? '',
        logo: json["logo"] ?? '',
        status: json["status"] ?? '',
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category_id": categoryId,
    "user_id": userId,
    "founder_name": founderName,
    "description": description,
    "logo": logo,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}