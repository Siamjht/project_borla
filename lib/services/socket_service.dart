import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/foundation.dart';
import '../helpers/other_helper.dart';
import '../helpers/prefs_helper.dart';
import '../utils/app_urls.dart';



class SocketServices {
  static late io.Socket socket;
  bool show = false;

  ///<<<============ Connect with socket ====================>>>
  static void connectToSocket() {
    socket = io.io(
      AppUrls.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({'token': PrefsHelper.token})
          .enableAutoConnect()
          .build(),
    );

    socket.onConnect((data) {
      // listenForNewMessages();
      debugPrint("=============================> Connection $data");
    });
    socket.onConnectError((data) {
      if (kDebugMode) {
        print("============================>Connection Error $data");
      }
    });

    socket.connect();

    socket.on("user-notification::${PrefsHelper.userId}", (data) {
      if (kDebugMode) {
        print("================> get Data on socket: $data");
      }
    });
  }

  // static void listenForNewMessages() {
  //   socket.off('new_message');
  //   socket.on('new_message', (data) {
  //     log('new_message received: $data');
  //
  //     try {
  //       final messageData = Map<String, dynamic>.from(data['message'] ?? {});
  //       final sentMessage = SentMessageModel.fromJson(messageData);
  //
  //       // ✅ Only add if it's from the other person
  //       if (sentMessage.sender != PrefsHelper.userId) {
  //         ChatController.instance.messages.add(MessageModel(
  //           id: DateTime.now().millisecondsSinceEpoch.toString(),
  //           text: sentMessage.text,
  //           imageUrl: sentMessage.imageUrl,
  //           seen: false,
  //           sender: sentMessage.sender,
  //           receiver: sentMessage.receiver,
  //           chat: sentMessage.chat,
  //           createdAt: sentMessage.createdAt,
  //           updatedAt: sentMessage.createdAt,
  //         ));
  //
  //         ChatController.instance.scrollToBottom();
  //       }
  //     } catch (e) {
  //       log('Error parsing new_message: $e');
  //     }
  //   });
  // }
  //
  //
  // /// Get Chat List
  // static Future<List<CustomChatListItem>> getChatList({
  //   int page = 1,
  //   int limit = 20,
  // }) async {
  //   try {
  //     log('get chat list is being called');
  //
  //     if (!socket.connected) {
  //       log('Socket is not connected. Unable to emit event.');
  //       return [];
  //     }
  //
  //     log('Socket is connected. Emitting my_chat_list...');
  //
  //     final completer = Completer<List<CustomChatListItem>>();
  //
  //     socket.emitWithAck(
  //       "my_chat_list",
  //       {"page": page, "limit": limit}, // ✅ send pagination
  //       ack: (response) {
  //         if (response == null) {
  //           log('No acknowledgment received or timeout occurred.');
  //           completer.complete([]);
  //           return;
  //         }
  //
  //         log('Acknowledgment received: $response');
  //
  //         final model = ChatListResponseModel.fromJson(
  //           Map<String, dynamic>.from(response),
  //         );
  //
  //         final List<CustomChatListItem> items = model.data.map((item) {
  //           final participant = item.chat.participants.isNotEmpty
  //               ? item.chat.participants.first
  //               : ChatParticipantModel.fromJson({});
  //
  //           return CustomChatListItem(
  //             chatId: item.chat.id,
  //             participantId: participant.id,
  //             participantName: participant.name,
  //             participantProfile: participant.profile,
  //             lastMessage: item.message.text.isNotEmpty
  //                 ? item.message.text
  //                 : item.message.imageUrl.isNotEmpty
  //                 ? '📷 Image'
  //                 : '',
  //             unreadCount: item.unreadMessageCount,
  //             isSeen: item.message.seen,
  //             time: OtherHelper.timeAgo(item.message.createdAt),
  //           );
  //         }).toList();
  //
  //         completer.complete(items);
  //       },
  //     );
  //
  //     return completer.future;
  //
  //   } catch (error, stackTrace) {
  //     log('Error in getChatList: $error');
  //     log('Stack Trace: $stackTrace');
  //     return [];
  //   }
  // }

  /// Get Chat Messages
//   static Future<ChatMessageData> getChatMessages({
//     required String userId,
//     String? chatId,
//     int page = 1,
//     int limit = 20,
//   }) async {
//     try {
//       if (!socket.connected) {
//         log('Socket is not connected.');
//         return ChatMessageData(
//           getPreMessage: [],
//           userDetails: ChatUserDetailsModel.fromJson({}),
//           pagination: ChatPaginationModel.fromJson({}),
//         );
//       }
//
//       final completer = Completer<ChatMessageData>();
//
//       socket.emitWithAck(
//         "message_page",
//         {
//           "userId": userId,
//           "page": page,
//           "limit": limit,
//         },
//         ack: (response) {
//           if (response == null) {
//             completer.complete(ChatMessageData(
//               getPreMessage: [],
//               userDetails: ChatUserDetailsModel.fromJson({}),
//               pagination: ChatPaginationModel.fromJson({}),
//             ));
//             return;
//           }
//
//           log('getChatMessages response: $response');
//
//           final model = ChatMessagesResponseModel.fromJson(
//             Map<String, dynamic>.from(response),
//           );
//
//           completer.complete(model.data);
//         },
//       );
//
//       return completer.future;
//
//     } catch (error, stackTrace) {
//       log('Error in getChatMessages: $error');
//       log('Stack Trace: $stackTrace');
//       return ChatMessageData(
//         getPreMessage: [],
//         userDetails: ChatUserDetailsModel.fromJson({}),
//         pagination: ChatPaginationModel.fromJson({}),
//       );
//     }
//   }
//
//   /// Send Message
//   static Future<SentMessageModel?> sendMessage({
//     required String receiverId,
//     required String text,
//     List<String> imageUrl = const [],
//   }) async {
//     try {
//       log('sendMessage is being called');
//
//       if (!socket.connected) {
//         log('Socket is not connected.');
//         return null;
//       }
//
//       final completer = Completer<SentMessageModel?>();
//
//       socket.emitWithAck(
//         "send_message",
//         {
//           "receiver": receiverId,
//           "text": text,
//           "imageUrl": imageUrl,
//         },
//         ack: (response) {
//           if (response == null) {
//             log('No acknowledgment received.');
//             completer.complete(null);
//             return;
//           }
//
//           log('Send message response: $response');
//
//           final model = SendMessageResponseModel.fromJson(
//             Map<String, dynamic>.from(response),
//           );
//
//           completer.complete(model.success ? model.data : null);
//         },
//       );
//
//       return completer.future;
//
//     } catch (error, stackTrace) {
//       log('Error in sendMessage: $error');
//       log('Stack Trace: $stackTrace');
//       return null;
//     }
//   }
//
//
//   /// Mark messages seen
//   static Future<bool> markMessagesSeen({required String chatId}) async {
//     try {
//       log('markMessagesSeen is being called');
//
//       if (!socket.connected) {
//         log('Socket is not connected.');
//         return false;
//       }
//
//       final completer = Completer<bool>();
//
//       socket.emitWithAck(
//         "seen",
//         {"chatId": chatId},
//         ack: (response) {
//           if (response == null) {
//             log('No acknowledgment received.');
//             completer.complete(false);
//             return;
//           }
//
//           log('Seen response: $response');
//
//           final success = response['success'] ?? false;
//           completer.complete(success);
//         },
//       );
//
//       return completer.future;
//
//     } catch (error, stackTrace) {
//       log('Error in markMessagesSeen: $error');
//       log('Stack Trace: $stackTrace');
//       return false;
//     }
//   }
//
//   /// Online users
//   static void listenForOnlineUsers() {
//     socket.off('onlineUsersList');
//     socket.on('onlineUsersList', (data) {
//       log('Online users: $data');
//
//       try {
//         final List<String> onlineUserIds = List<String>.from(data ?? []);
//
//         // ✅ Update in ChatController if registered
//         if (Get.isRegistered<ChatController>()) {
//           Get.find<ChatController>().onlineUserIds.value = onlineUserIds;
//         }
//       } catch (e) {
//         log('Error in listenForOnlineUsers: $e');
//       }
//     });
//   }
//
//   /// =============>>> Typing <<<=======================
//   // ── Emit Typing ──
//   static void startTyping({required String chatId}) {
//     if (!socket.connected) return;
//     socket.emit("typing", {"chatId": chatId});
//     log('typing emitted for chatId: $chatId');
//   }
//
// // ── Emit Stop Typing ──
//   static void stopTyping({required String chatId}) {
//     if (!socket.connected) return;
//     socket.emit("stopTyping", {"chatId": chatId});
//     log('stopTyping emitted for chatId: $chatId');
//   }
//
// // ── Listen Typing Events ──
//   static void listenTypingEvents() {
//     socket.off('typing');
//     socket.off('stopTyping');
//
//     socket.on('typing', (data) {
//       log('typing received: $data');
//       if (Get.isRegistered<ChatController>()) {
//         Get.find<ChatController>().isOtherPersonTyping.value = true;
//       }
//     });
//
//     socket.on('stopTyping', (data) {
//       log('stopTyping received: $data');
//       if (Get.isRegistered<ChatController>()) {
//         Get.find<ChatController>().isOtherPersonTyping.value = false;
//       }
//     });
//   }

// static void _showMessageSnackbar(SentMessageModel message) {
//   if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
//
//   Get.rawSnackbar(
//     snackPosition: SnackPosition.TOP,
//     backgroundColor: Colors.transparent,
//     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
//     duration: const Duration(seconds: 4),
//     animationDuration: const Duration(milliseconds: 400),
//     forwardAnimationCurve: Curves.easeOutBack,
//     reverseAnimationCurve: Curves.easeIn,
//     isDismissible: true,
//     dismissDirection: DismissDirection.horizontal,
//     snackStyle: SnackStyle.FLOATING,
//     onTap: (_) {
//       // ✅ Navigate to chat screen on tap
//       Get.closeCurrentSnackbar();
//       Get.to(
//             () => ChatScreen(chatId: message.chat),
//         arguments: {
//           'chatId': message.chat,
//           'receiverId': message.sender,
//         },
//       );
//     },
//     messageText: Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF1A1A2E),
//         borderRadius: BorderRadius.circular(12),
//         border: Border(
//           left: BorderSide(color: AppColors.gradientFirst, width: 4),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.3),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Row(
//         children: [
//           // ── Avatar ──
//           ShimmerImageLoader(
//             url: '',
//             width: 42,
//             height: 42,
//             isCircle: true,
//           ),
//
//           const SizedBox(width: 12),
//
//           // ── Message Content ──
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // ── Name ──
//                 Text(
//                   'New Message',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 // ── Message text ──
//                 Text(
//                   message.imageUrl.isNotEmpty
//                       ? '📷 Image'
//                       : message.text,
//                   style: TextStyle(
//                     color: Colors.white.withValues(alpha: 0.7),
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(width: 8),
//
//           // ── Tap hint ──
//           Text(
//             'Tap to open',
//             style: TextStyle(
//               color: AppColors.gradientSecond,
//               fontSize: 11,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

}
