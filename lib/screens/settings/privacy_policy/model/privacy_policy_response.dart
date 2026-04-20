import 'dart:convert';

class ContactUs {
  final List<dynamic> errors;
  final String message;
  final List<Result> result;

  ContactUs({
    required this.errors,
    required this.message,
    required this.result,
  });

  factory ContactUs.fromRawJson(String str) =>
      ContactUs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactUs.fromJson(Map<String, dynamic> json) =>
      ContactUs(
        errors: json["errors"] == null
            ? []
            : List<dynamic>.from(json["errors"].map((x) => x)),

        message: json["message"] ?? '',

        result: json["result"] == null
            ? []
            : List<Result>.from(
          json["result"].map((x) => Result.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  final int id;
  final Description title;
  final Description description;
  final String type;
  final dynamic createdAt;
  final dynamic updatedAt;

  Result({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Result.fromRawJson(String str) =>
      Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] ?? 0,

    title: json["title"] == null
        ? Description(en: '', ar: '')
        : Description.fromJson(json["title"]),

    description: json["description"] == null
        ? Description(en: '', ar: '')
        : Description.fromJson(json["description"]),

    type: json["type"] ?? '',

    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toJson(),
    "description": description.toJson(),
    "type": type,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Description {
  final String en;
  final String ar;

  Description({
    required this.en,
    required this.ar,
  });

  factory Description.fromRawJson(String str) =>
      Description.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    en: json["en"] ?? '',
    ar: json["ar"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "ar": ar,
  };
}