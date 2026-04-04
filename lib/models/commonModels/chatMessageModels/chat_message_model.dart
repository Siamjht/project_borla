
import '../../../utils/app_urls.dart';
import 'chat_list_model.dart';

class ChatMessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String chatId;
  final String? bookingId;
  final String text;
  final bool seen;
  final String createdAt;
  final String updatedAt;
  final List<ChatImageModel> images;

  ChatMessageModel({
    this.id = '',
    this.senderId = '',
    this.receiverId = '',
    this.chatId = '',
    this.bookingId,
    this.text = '',
    this.seen = false,
    this.createdAt = '',
    this.updatedAt = '',
    this.images = const [],
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      chatId: json['chatId'] ?? '',
      bookingId: json['bookingId'],
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

  // ✅ convert to map for UI
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

}