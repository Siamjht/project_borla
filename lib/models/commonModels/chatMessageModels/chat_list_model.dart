
class ChatListModel {
  final String id;
  final String status;
  final String bookingId;
  final ChatParticipantModel otherParticipant;
  final ChatLastMessageModel? lastMessage;
  final String createdAt;
  final String updatedAt;

  ChatListModel({
    this.id = '',
    this.status = '',
    this.bookingId = '',
    ChatParticipantModel? otherParticipant,
    this.lastMessage,
    this.createdAt = '',
    this.updatedAt = '',
  }) : otherParticipant = otherParticipant ?? ChatParticipantModel();

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      bookingId: json['bookingId'] ?? '',
      otherParticipant: json['otherParticipant'] != null
          ? ChatParticipantModel.fromJson(json['otherParticipant'])
          : null,
      lastMessage: json['lastMessage'] != null
          ? ChatLastMessageModel.fromJson(json['lastMessage'])
          : null,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

// ── Participant ───────────────────────────────────────────────
class ChatParticipantModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String profilePicture;
  final String role;

  ChatParticipantModel({
    this.id = '',
    this.name = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = '',
  });

  factory ChatParticipantModel.fromJson(Map<String, dynamic> json) {
    return ChatParticipantModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

// ── Last Message ──────────────────────────────────────────────
class ChatLastMessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String chatId;
  final String text;
  final bool seen;
  final String createdAt;
  final String updatedAt;
  final List<ChatImageModel> images;

  ChatLastMessageModel({
    this.id = '',
    this.senderId = '',
    this.receiverId = '',
    this.chatId = '',
    this.text = '',
    this.seen = false,
    this.createdAt = '',
    this.updatedAt = '',
    this.images = const [],
  });

  factory ChatLastMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatLastMessageModel(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      chatId: json['chatId'] ?? '',
      text: json['text'] ?? '',
      seen: json['seen'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ChatImageModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'chatId': chatId,
      'text': text,
      'seen': seen,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'images': images.map((e) => e.toJson()).toList(),
    };
  }

  // ✅ convert to UI message map
  Map<String, dynamic> toMessageMap(String myId) {
    return {
      'id': id,
      'text': text,
      'isMe': senderId == myId,
      'time': _formatTime(createdAt),
      'images': images.isNotEmpty
          ? images.map((e) => e.image).toList()
          : null,
      'seen': seen,
    };
  }

  static String _formatTime(String isoDate) {
    if (isoDate.isEmpty) return '';
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    } catch (_) {
      return '';
    }
  }

  String get displayText {
    if (text.isNotEmpty) return text;
    if (images.isNotEmpty) return '📷 Photo';
    return '';
  }

  bool get hasImages => images.isNotEmpty;
}

// ── Chat Image ────────────────────────────────────────────────
class ChatImageModel {
  final String id;
  final String image;
  final String referenceId;
  final String createdAt;
  final String updatedAt;

  ChatImageModel({
    this.id = '',
    this.image = '',
    this.referenceId = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory ChatImageModel.fromJson(Map<String, dynamic> json) {
    return ChatImageModel(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      referenceId: json['referenceId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'referenceId': referenceId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}


class CustomChatListItem {
  final String chatId;
  final String bookingId;
  final String participantId;
  final String participantName;
  final String participantProfile;
  final String lastMessage;
  final int unreadCount;
  final bool isSeen;
  final String time;

  CustomChatListItem({
    required this.chatId,
    required this.bookingId,
    required this.participantId,
    required this.participantName,
    required this.participantProfile,
    required this.lastMessage,
    required this.unreadCount,
    required this.isSeen,
    required this.time,
  });
}