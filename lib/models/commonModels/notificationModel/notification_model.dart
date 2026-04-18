class NotificationModel {
  final String id;
  final String userId;
  final NotificationType type;
  final String title;
  final String message;
  final NotificationData data;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.message,
    required this.data,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      type: NotificationType.fromString(json['type'] ?? ''),
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      data: NotificationData.fromJson(json['data'] ?? {}),
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class NotificationData {
  final String bookingId;
  final String riderId;
  final String userId;
  final String status;
  final DateTime completedAt;
  final String stationId;

  NotificationData({
    this.bookingId = '',
    this.riderId = '',
    this.userId = '',
    this.status = '',
    DateTime? completedAt,
    this.stationId = '',
  }) : completedAt = completedAt ?? DateTime(0);

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      bookingId: json['bookingId'] ?? '',
      riderId: json['riderId'] ?? '',
      userId: json['userId'] ?? '',
      status: json['status'] ?? '',
      completedAt: json['completedAt'] != null
          ? DateTime.tryParse(json['completedAt']) ?? DateTime(0)
          : null,
      stationId: json['stationId'] ?? '',
    );
  }
}

class NotificationMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;
  final int unreadCount;

  NotificationMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
    required this.unreadCount,
  });

  factory NotificationMeta.fromJson(Map<String, dynamic> json) {
    return NotificationMeta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}

// ── Notification Type Enum ──
enum NotificationType {
  bookingCompleted,
  bookingHeadingToStation,
  bookingPaymentCollected,
  bookingPaymentInitiated,
  riderArrivedPickup,
  bookingAccepted,
  bookingCancelled,
  unknown;

  static NotificationType fromString(String value) {
    switch (value) {
      case 'booking_completed':
        return NotificationType.bookingCompleted;
      case 'booking_heading_to_station':
        return NotificationType.bookingHeadingToStation;
      case 'booking_payment_collected':
        return NotificationType.bookingPaymentCollected;
      case 'booking_payment_initiated':
        return NotificationType.bookingPaymentInitiated;
      case 'rider_arrived_pickup':
        return NotificationType.riderArrivedPickup;
      case 'booking_accepted':
        return NotificationType.bookingAccepted;
      case 'booking_cancelled':
        return NotificationType.bookingCancelled;
      default:
        return NotificationType.unknown;
    }
  }
}

// ── Helper Extensions ──
extension NotificationExtension on NotificationModel {
  String get typeLabel {
    switch (type) {
      case NotificationType.bookingCompleted:
        return 'Booking Completed';
      case NotificationType.bookingHeadingToStation:
        return 'Heading to Station';
      case NotificationType.bookingPaymentCollected:
        return 'Payment Collected';
      case NotificationType.bookingPaymentInitiated:
        return 'Payment Initiated';
      case NotificationType.riderArrivedPickup:
        return 'Rider Arrived';
      case NotificationType.bookingAccepted:
        return 'Booking Accepted';
      case NotificationType.bookingCancelled:
        return 'Booking Cancelled';
      default:
        return 'Notification';
    }
  }

  bool get isBookingRelated => type != NotificationType.unknown;

  String? get bookingId => data.bookingId;
}
