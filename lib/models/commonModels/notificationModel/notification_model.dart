
class NotificationModel {
  final String id;
  final String receiver;
  final String reference;
  final String modelType;
  final String message;
  final String description;
  final bool read;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.receiver,
    required this.reference,
    required this.modelType,
    required this.message,
    required this.description,
    required this.read,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      receiver: json['receiver'] ?? '',
      reference: json['refference'] ?? '',
      modelType: json['model_type'] ?? '',
      message: json['message'] ?? '',
      description: json['description'] ?? '',
      read: json['read'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class NotificationMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  NotificationMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory NotificationMeta.fromJson(Map<String, dynamic> json) {
    return NotificationMeta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

// ── Model Type Constants ──
class NotificationModelType {
  static const joinRequest = 'JoinRequest';
  static const event = 'Event';
// add more as needed
}

// ── Message Constants ──
class NotificationMessage {
  static const approved = 'Great news! Your request was approved 🎉';
  static const declined = 'Your join request was declined';
  static const newRequest = 'You Have a New Event Join Request 🎉';
}

// ── Check model type and message ──
extension NotificationExtension on NotificationModel {
  bool get isJoinRequest => modelType == NotificationModelType.joinRequest;

  bool get isApproved =>
      isJoinRequest && message.contains('Your request was approved');

  bool get isDeclined =>
      isJoinRequest && message.contains('Your join request was declined');

  bool get isNewRequest =>
      isJoinRequest && message.contains('You Have a New Event Join Request');
}