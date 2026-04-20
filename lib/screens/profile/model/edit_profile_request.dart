class EditProfileRequest {
  final String name;
  final String email;
  final String phoneNumber;
  final String companyName;
  final String companyId;

  EditProfileRequest({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.companyName,
    required this.companyId,
  });

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) {
    return EditProfileRequest(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      companyName: json['company_name'] ?? '',
      companyId: json['company_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "company_name": companyName,
      "company_id": companyId,
    };
  }
}