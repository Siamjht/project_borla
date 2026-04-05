
import 'chat_list_model.dart';
import 'chat_message_model.dart';

class SupportChatModel {
  final String id;
  final String status;
  final SupportAgentModel supportAgent;
  final ChatLastMessageModel? lastMessage;
  final String createdAt;
  final String updatedAt;

  SupportChatModel({
    this.id = '',
    this.status = '',
    SupportAgentModel? supportAgent,
    this.lastMessage,
    this.createdAt = '',
    this.updatedAt = '',
  }) : supportAgent = supportAgent ?? SupportAgentModel();

  factory SupportChatModel.fromJson(Map<String, dynamic> json) {
    return SupportChatModel(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      supportAgent: json['supportAgent'] != null
          ? SupportAgentModel.fromJson(json['supportAgent'])
          : null,
      lastMessage: json['lastMessage'] != null
          ? ChatLastMessageModel.fromJson(json['lastMessage'])
          : null,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class SupportAgentModel {
  final String id;
  final String name;
  final String profilePicture;
  final String role;

  SupportAgentModel({
    this.id = '',
    this.name = '',
    this.profilePicture = '',
    this.role = '',
  });

  factory SupportAgentModel.fromJson(Map<String, dynamic> json) {
    return SupportAgentModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class SendSupportMessageModel {
  final String chatId;
  final ChatMessageModel message;

  SendSupportMessageModel({
    this.chatId = '',
    required this.message,
  });

  factory SendSupportMessageModel.fromJson(Map<String, dynamic> json) {
    return SendSupportMessageModel(
      chatId: json['chatId'] ?? '',
      message: ChatMessageModel.fromJson(json['message'] ?? {}),
    );
  }
}