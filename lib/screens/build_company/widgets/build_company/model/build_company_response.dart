import 'dart:io';

class AddCompanyRequest {
  final String name;
  final int categoryId;
  final String founderName;
  final String description;
  final File logo;

  AddCompanyRequest({
    required this.name,
    required this.categoryId,
    required this.founderName,
    required this.description,
    required this.logo,
  });

  Map<String, String> toFields() {
    return {
      "name": name,
      "category_id": categoryId.toString(),
      "founder_name": founderName,
      "description": description,
    };
  }
}