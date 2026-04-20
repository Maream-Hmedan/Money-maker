// ignore_for_file: constant_identifier_names

import 'dart:convert';

class BalanceHistoryResponse {
  final List<Transaction> transactions;

  BalanceHistoryResponse({
    required this.transactions,
  });

  factory BalanceHistoryResponse.fromRawJson(String str) =>
      BalanceHistoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BalanceHistoryResponse.fromJson(Map<String, dynamic> json) =>
      BalanceHistoryResponse(
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
          json["transactions"].map((x) => Transaction.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class Transaction {
  final int userId;
  final int? orderId;
  final TransactionType type;
  final String amount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TransactionDetails details;

  Transaction({
    required this.userId,
    required this.orderId,
    required this.type,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.details,
  });

  factory Transaction.fromRawJson(String str) =>
      Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    userId: json["user_id"] ?? 0,
    orderId: json["order_id"],
    type: transactionTypeValues.map[json["type"]] ?? TransactionType.CREDIT,
    amount: json["amount"]?.toString() ?? '0.00',
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"])
        : DateTime.now(),
    updatedAt: json["updated_at"] != null
        ? DateTime.parse(json["updated_at"])
        : DateTime.now(),
    details: transactionDetailsValues.map[json["details"]] ??
        TransactionDetails.CHARGE_USER_BALANCE,
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "order_id": orderId,
    "type": transactionTypeValues.reverse[type],
    "amount": amount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "details": transactionDetailsValues.reverse[details],
  };
}

enum TransactionDetails {
  ASSET_IS_BOUGHT,
  ASSET_IS_SOLD,
  CHARGE_USER_BALANCE,
}

final transactionDetailsValues = EnumValues({
  "Asset is bought": TransactionDetails.ASSET_IS_BOUGHT,
  "Asset is sold": TransactionDetails.ASSET_IS_SOLD,
  "Charge user balance": TransactionDetails.CHARGE_USER_BALANCE,
});

enum TransactionType {
  CREDIT,
  DEBIT,
}

final transactionTypeValues = EnumValues({
  "credit": TransactionType.CREDIT,
  "debit": TransactionType.DEBIT,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}