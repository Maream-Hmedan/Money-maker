import 'package:money_maker/screens/register/model/register_response.dart';

class BuildCompanyResponse {
  final List<dynamic> errors;
  final String message;
  final CompanyResponse result;

  BuildCompanyResponse({
    required this.errors,
    required this.message,
    required this.result,
  });

  factory BuildCompanyResponse.fromJson(Map<String, dynamic> json) =>
      BuildCompanyResponse(
        errors: json["errors"] == null
            ? []
            : List<dynamic>.from(json["errors"]),
        message: json["message"] ?? '',
        result: CompanyResponse.fromJson(json["result"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "errors": errors,
    "message": message,
    "result": result.toJson(),
  };
}

class CompanyResponse {
  final int id;
  final String name;
  final int categoryId;
  final int userId;
  final String? founderName;
  final String description;
  final String logo;
  final DateTime createdAt;
  final DateTime updatedAt;

  CompanyResponse({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.userId,
    required this.founderName,
    required this.description,
    required this.logo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CompanyResponse.fromJson(Map<String, dynamic> json) =>
      CompanyResponse(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        categoryId: int.tryParse(json["category_id"].toString()) ?? 0,
        userId: json["user_id"] ?? 0,
        founderName: json["founder_name"], // nullable
        description: json["description"] ?? '',
        logo: json["logo"] ?? '',
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };


  CompanyModel toCompanyModel() {
    return CompanyModel(
      id: id,
      name: name,
      categoryId: categoryId,
      userId: userId,
      founderName: founderName ?? '',
      description: description,
      logo: logo,
      status: '',
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}