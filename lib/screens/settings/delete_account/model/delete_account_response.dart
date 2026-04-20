import 'dart:convert';

class DeleteAccountResponse {
  final String theResult;
  final String resultFlag;

  DeleteAccountResponse({
    required this.theResult,
    required this.resultFlag,
  });

  factory DeleteAccountResponse.fromRawJson(String str) => DeleteAccountResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) => DeleteAccountResponse(
    theResult: json["theResult"],
    resultFlag: json["resultFlag"],
  );

  Map<String, dynamic> toJson() => {
    "theResult": theResult,
    "resultFlag": resultFlag,
  };
}
