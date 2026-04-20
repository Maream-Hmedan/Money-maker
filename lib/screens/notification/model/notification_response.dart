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
  final String type;
  final String notifiableType;
  final int notifiableId;
  final NotificationData data;
  final String? readAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationItem({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationItem.fromRawJson(String str) =>
      NotificationItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      NotificationItem(
        id: (json["id"] ?? "").toString(),
        type: (json["type"] ?? "").toString(),
        notifiableType: (json["notifiable_type"] ?? "").toString(),
        notifiableId: (json["notifiable_id"] as num?)?.toInt() ?? 0,
        data: NotificationData.fromJson(
          json["data"] as Map<String, dynamic>? ?? {},
        ),
        readAt: json["read_at"]?.toString(),
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"].toString())
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"].toString())
            : null,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "notifiable_type": notifiableType,
    "notifiable_id": notifiableId,
    "data": data.toJson(),
    "read_at": readAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  bool get isRead => readAt != null;

  String get bodyEn => data.body.en;
  String get bodyAr => data.body.ar;
  String get icon => data.icon;
  String get url => data.url;
  int get assetId => data.assetId;
}

class NotificationData {
  final NotificationBody body;
  final String icon;
  final String url;
  final int assetId;

  NotificationData({
    required this.body,
    required this.icon,
    required this.url,
    required this.assetId,
  });

  factory NotificationData.fromRawJson(String str) =>
      NotificationData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        body: NotificationBody.fromJson(
          json["body"] as Map<String, dynamic>? ?? {},
        ),
        icon: (json["icon"] ?? "").toString(),
        url: (json["url"] ?? "").toString(),
        assetId: (json["asset_id"] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "body": body.toJson(),
    "icon": icon,
    "url": url,
    "asset_id": assetId,
  };
}

class NotificationBody {
  final String en;
  final String ar;

  NotificationBody({
    required this.en,
    required this.ar,
  });

  factory NotificationBody.fromRawJson(String str) =>
      NotificationBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationBody.fromJson(Map<String, dynamic> json) =>
      NotificationBody(
        en: (json["en"] ?? "").toString(),
        ar: (json["ar"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
    "en": en,
    "ar": ar,
  };
}