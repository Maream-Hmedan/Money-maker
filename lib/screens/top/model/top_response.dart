import 'dart:convert';

class TopLeaderboardResponse {
  final String period;
  final DateTime from;
  final DateTime to;
  final List<Leaderboard> leaderboard;

  TopLeaderboardResponse({
    required this.period,
    required this.from,
    required this.to,
    required this.leaderboard,
  });

  factory TopLeaderboardResponse.fromRawJson(String str) =>
      TopLeaderboardResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopLeaderboardResponse.fromJson(Map<String, dynamic> json) =>
      TopLeaderboardResponse(
        period: json["period"]?.toString() ?? "",
        from: DateTime.tryParse(json["from"]?.toString() ?? "") ??
            DateTime.now(),
        to: DateTime.tryParse(json["to"]?.toString() ?? "") ??
            DateTime.now(),
        leaderboard: List<Leaderboard>.from(
          (json["leaderboard"] ?? [])
              .map((x) => Leaderboard.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "period": period,
    "from": from.toIso8601String(),
    "to": to.toIso8601String(),
    "leaderboard":
    List<dynamic>.from(leaderboard.map((x) => x.toJson())),
  };
}

class Leaderboard {
  final int userId;
  final String profit;
  final int rank;
  final User? user; // 👈 صار nullable

  Leaderboard({
    required this.userId,
    required this.profit,
    required this.rank,
    required this.user,
  });

  factory Leaderboard.fromRawJson(String str) =>
      Leaderboard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
    userId: _toInt(json["user_id"]),
    profit: json["profit"]?.toString() ?? "0",
    rank: _toInt(json["rank"]),
    user: json["user"] != null
        ? User.fromJson(json["user"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "profit": profit,
    "rank": rank,
    "user": user?.toJson(),
  };

  // helpers
  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}

class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromRawJson(String str) =>
      User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: _toInt(json["id"]),
    name: json["name"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}