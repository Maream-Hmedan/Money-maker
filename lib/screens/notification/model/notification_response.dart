import 'dart:convert';

class NotificationResponse {
  final List<NotificationItem> notifications;

  NotificationResponse({
    required this.notifications,
  });

  factory NotificationResponse.fromRawJson(String str) =>
      NotificationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        notifications: (json["notifications"] as List? ?? [])
            .map((x) => NotificationItem.fromJson(x as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    "notifications": notifications.map((x) => x.toJson()).toList(),
  };
}

class NotificationItem {
  final String id;
  final String body;
  final String icon;
  final String url;
  final int bookId;
  final bool isRead;
  final String createdAt; // "11 hours ago"

  NotificationItem({
    required this.id,
    required this.body,
    required this.icon,
    required this.url,
    required this.bookId,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationItem.fromRawJson(String str) =>
      NotificationItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      NotificationItem(
        id: (json["id"] ?? "").toString(),
        body: (json["body"] ?? "").toString(),
        icon: (json["icon"] ?? "").toString(),
        url: (json["url"] ?? "").toString(),
        bookId: (json["book_id"] as num?)?.toInt() ?? 0,
        isRead: json["is_read"] ?? false,
        createdAt: (json["created_at"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "body": body,
    "icon": icon,
    "url": url,
    "book_id": bookId,
    "is_read": isRead,
    "created_at": createdAt,
  };
}