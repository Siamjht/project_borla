
import 'dart:developer';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/foundation.dart';
import '../helpers/prefs_helper.dart';
import '../models/commonModels/chatMessageModels/chat_message_model.dart';
import '../role/commonScreens/chat/innerController/chat_controller.dart';
import '../utils/app_urls.dart';


class SocketServices {
  static late io.Socket socket;
  bool show = false;

  // <<<============ Connect with socket ====================>>>
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
      listenForNewMessages();
      listenForBookingEvents();   // ✅ Register all booking/payment listeners on connect
      listenForNotificationEvents();
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

  // <<<============ Listen for new chat messages ====================>>>
  static void listenForNewMessages() {
    socket.off(SocketEvents.newMessageOn);
    socket.on(SocketEvents.newMessageOn, (data) {
      log('new_message received: $data');

      try {
        final messageData = Map<String, dynamic>.from(data['message'] ?? {});
        final newMessage = ChatMessageModel.fromJson(messageData);

        // ✅ Only add if it's from the other person
        if (newMessage.senderId == PrefsHelper.userId) return;

        // ✅ Only add if message belongs to current open chat
        final isChatOpen = Get.isRegistered<ChatController>();
        if (isChatOpen) {
          final chatCtrl = ChatController.instance;
          final isCurrentChat = newMessage.bookingId == chatCtrl.currentBookingId;
          if (isCurrentChat) {
            final newMessage = ChatMessageModel.fromJson(messageData);
            chatCtrl.messages.add(newMessage);
            chatCtrl.scrollToBottom();
          }
        }

        // TODO: Show global snackbar notification if needed
        // _showMessageSnackbar(sentMessage);

      } catch (e) {
        log('Error parsing new_message: $e');
      }
    });
  }

  // <<<============ Join a chat room ====================>>>
  static void joinChat({required String chatId}) {
    if (!socket.connected) return;
    socket.emit(SocketEvents.joinChatEmit, {chatId});
    log('joinChat emitted for chatId: $chatId');
  }

  // <<<============ Listen for all Booking Events ====================>>>
  static void listenForBookingEvents() {

    // ── booking:new ──
    // Fired when a new booking is created
    socket.off('booking:new');
    socket.on('booking:new', (data) {
      log('booking:new received: $data');
      try {
        // TODO: Parse with model when response structure is known
        // final model = BookingModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        log('Error parsing booking:new: $e');
      }
    });

    // ── booking:accepted ──
    // Fired when the driver/provider accepts the booking
    socket.off('booking:accepted');
    socket.on('booking:accepted', (data) {
      log('booking:accepted received: $data');
      try {
        // TODO: Parse with model when response structure is known
        // final model = BookingModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        log('Error parsing booking:accepted: $e');
      }
    });

    // ── booking:arrived_pickup ──
    // Fired when the driver has arrived at the pickup location
    socket.off('booking:arrived_pickup');
    socket.on('booking:arrived_pickup', (data) {
      log('booking:arrived_pickup received: $data');
      try {
        // TODO: Parse with model when response structure is known
        // final model = BookingModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        log('Error parsing booking:arrived_pickup: $e');
      }
    });

    // ── booking:heading_to_station ──
    // Fired when the driver is heading to the station/destination
    socket.off('booking:heading_to_station');
    socket.on('booking:heading_to_station', (data) {
      log('booking:heading_to_station received: $data');
      try {
        // TODO: Parse with model when response structure is known
        // final model = BookingModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        log('Error parsing booking:heading_to_station: $e');
      }
    });

    // ── booking:payment_collected ──
    // Fired when payment is collected for the booking (e.g. cash collected by driver)
    socket.off('booking:payment_collected');
    socket.on('booking:payment_collected', (data) {
      log('booking:payment_collected received: $data');
      try {
        // TODO: Parse with model when response structure is known
        // final model = BookingPaymentModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        log('Error parsing booking:payment_collected: $e');
      }
    });

    // ── booking:completed ──
    // Fired when the booking/ride is fully completed
    socket.off('booking:completed');
    socket.on('booking:completed', (data) {
      log('booking:completed received: $data');
      try {
        // TODO: Parse with model when response structure is known
        // final model = BookingModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        log('Error parsing booking:completed: $e');
      }
    });
  }

  // <<<============ Listen for all Payment Events ====================>>>
  static void listenForPaymentEvents() {

    // ── payment:initiated ──
    // Fired when a payment is initiated/started
    socket.off('payment:initiated');
    socket.on('payment:initiated', (data) {
      log('payment:initiated received: $data');
      try {
        // TODO: Parse with model when response structure is known
        // final model = PaymentModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        log('Error parsing payment:initiated: $e');
      }
    });

    // ── payment:cash_completed ──
    // Fired when a cash payment is successfully completed
    socket.off('payment:cash_completed');
    socket.on('payment:cash_completed', (data) {
      log('payment:cash_completed received: $data');
      try {
        // TODO: Parse with model when response structure is known
        // final model = PaymentModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        log('Error parsing payment:cash_completed: $e');
      }
    });

    // ── payment:callback ──
    // Fired as a callback after an online/gateway payment attempt (success or failure)
    socket.off('payment:callback');
    socket.on('payment:callback', (data) {
      log('payment:callback received: $data');
      try {
        // TODO: Parse with model when response structure is known
        // final model = PaymentCallbackModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        log('Error parsing payment:callback: $e');
      }
    });
  }

  // <<<============ Listen for Notification Events ====================>>>
  static void listenForNotificationEvents() {

    // ── notification:new ──
    // Fired when a new in-app notification arrives for the user
    socket.off('notification:new');
    socket.on('notification:new', (data) {
      log('notification:new received: $data');
      try {
        // TODO: Parse with model when response structure is known
        // final model = NotificationModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        log('Error parsing notification:new: $e');
      }
    });
  }

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