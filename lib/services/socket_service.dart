
import 'dart:developer';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/foundation.dart';
import '../helpers/prefs_helper.dart';
import '../models/commonModels/chatMessageModels/chat_message_model.dart';
import '../role/commonScreens/chat/innerController/chat_controller.dart';
import '../utils/app_urls.dart';
import 'sound_service.dart';


class SocketServices {
  static late io.Socket socket;
  bool show = false;

  // <<<============ Connect with socket ====================>>>
  static void connectToSocket() {
    socket = io.io(
      AppUrls.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({'Authorization': "Bearer ${PrefsHelper.token}"})
          .enableAutoConnect()
          .build(),
    );

    socket.onConnect((data) {
      listenForNewMessages();
      listenForNotificationEvents();
      if(PrefsHelper.myRole == 'rider'){
        listenForNewBooking();
      }else if(PrefsHelper.myRole == 'user'){
        listenForBookingAccepted();
        listenForDriverArrivedAtPickup();
        listenForCashPaymentCompleted();
        listenForPaymentCollected();
        listenForDriverHeadingToStation();
      }
      debugPrint("Socket connected: $data");
    });

    socket.onConnectError((data) {
      if (kDebugMode) {
        print("Socket Connection Error $data");
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

        // ✅ Play message receive tone (only when user is in app)
        SoundService.instance.playMessageReceive();

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

  // <<<============ Listen for all Payment Events ====================>>>
  static void listenForPaymentEvents() {

    // ── payment:initiated ──
    // Fired when a payment is initiated/started
    socket.off(SocketEvents.paymentInitiatedOn);
    socket.on(SocketEvents.paymentInitiatedOn, (data) {
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
    socket.off(SocketEvents.paymentCashCompletedOn);
    socket.on(SocketEvents.paymentCashCompletedOn, (data) {
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
    socket.off(SocketEvents.paymentCallbackOn);
    socket.on(SocketEvents.paymentCallbackOn, (data) {
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
    socket.off(SocketEvents.notificationNewOn);
    socket.on(SocketEvents.notificationNewOn, (data) {
      log('notification:new received: $data');
      
      // ✅ Play message receive tone for notifications (only when user is in app)
      SoundService.instance.playMessageReceive();
      
      try {
        // TODO: Parse with model when response structure is known
        // final model = NotificationModel.fromJson(Map<String, dynamic>.from(data));
      } catch (e) {
        log('Error parsing notification:new: $e');
      }
    });
  }

  // <<<============ Additional Socket Listing Methods ====================>>>

  /// Listens for chat typing events from other users
  /// Event: chat:typing
  /// Triggered when another user starts typing in a shared chat
  static void listenForTypingEvents() {
    socket.off(SocketEvents.chatTypingOn);
    socket.on(SocketEvents.chatTypingOn, (data) {
      log('chat:typing received: $data');
      try {
        // TODO: Update UI to show typing indicator for the user
        // Extract chatId and userId from data
        // final chatId = data['chatId'];
        // final userId = data['userId'];
      } catch (e) {
        log('Error parsing chat:typing: $e');
      }
    });
  }

  /// Emits an event to indicate the current user is typing in a chat
  /// Event: chat:typing
  /// Parameter: chatId - The ID of the chat where typing is occurring
  static void emitTypingEvent({required String chatId}) {
    if (!socket.connected) return;
    socket.emit(SocketEvents.chatTypingEmit, {'chatId': chatId});
    log('chat:typing emitted for chatId: $chatId');
  }

  /// Emits an event to indicate the current user has stopped typing
  /// Event: chat:typing (can also be chat:stopTyping depending on server setup)
  /// Parameter: chatId - The ID of the chat where typing has stopped
  static void emitStopTypingEvent({required String chatId}) {
    if (!socket.connected) return;
    // Note: You may need to define a separate event for stopTyping if server expects it
    socket.emit('chat:stopTyping', {'chatId': chatId});
    log('chat:stopTyping emitted for chatId: $chatId');
  }

  /// Listens for users leaving a chat room
  /// Event: chat:leave
  /// Triggered when a user disconnects or leaves the chat
  static void listenForLeaveChat() {
    socket.off(SocketEvents.leaveChatRoomEmit);
    socket.on(SocketEvents.leaveChatRoomEmit, (data) {
      log('chat:leave received: $data');
      try {
        // TODO: Update UI to show user left the chat
        // final chatId = data['chatId'];
        // final userId = data['userId'];
      } catch (e) {
        log('Error parsing chat:leave: $e');
      }
    });
  }

  /// Emits an event to leave a specific chat room
  /// Event: chat:leave
  /// Parameter: chatId - The ID of the chat room to leave
  static void emitLeaveChat({required String chatId}) {
    if (!socket.connected) return;
    socket.emit(SocketEvents.leaveChatRoomEmit, {'chatId': chatId});
    log('chat:leave emitted for chatId: $chatId');
  }

  /// Listens for new booking events using SocketEvents constants
  /// Event: booking:new
  /// Triggered when a new booking request is created in the system
  static void listenForNewBooking() {
    socket.off(SocketEvents.bookingNewOn);
    socket.on(SocketEvents.bookingNewOn, (data) {
      log('booking:new received: $data');
      
      // ✅ Play dispatch tone for new booking (only when user is in app)
      SoundService.instance.playDispatch();
      
      try {
        // TODO: Parse with BookingModel when response structure is known
        // final model = BookingModel.fromJson(Map<String, dynamic>.from(data));
        // TODO: Update UI or show notification for new booking
      } catch (e) {
        log('Error parsing booking:new: $e');
      }
    });
  }

  /// Listens for booking acceptance events using SocketEvents constants
  /// Event: booking:accepted
  /// Triggered when a driver/provider accepts a booking request
  static void listenForBookingAccepted() {
    socket.off(SocketEvents.bookingAcceptedOn);
    socket.on(SocketEvents.bookingAcceptedOn, (data) {
      log('booking:accepted received: $data');
      try {
        // TODO: Parse with BookingModel when response structure is known
        // final model = BookingModel.fromJson(Map<String, dynamic>.from(data));
        // TODO: Update booking status UI to show accepted state
      } catch (e) {
        log('Error parsing booking:accepted: $e');
      }
    });
  }

  /// Listens for driver arrival at pickup location events
  /// Event: booking:arrived_pickup
  /// Triggered when the driver has arrived at the passenger's pickup location
  static void listenForDriverArrivedAtPickup() {
    socket.off(SocketEvents.bookingArrivedPickupOn);
    socket.on(SocketEvents.bookingArrivedPickupOn, (data) {
      log('booking:arrived_pickup received: $data');
      try {
        // TODO: Parse with BookingModel when response structure is known
        // final model = BookingModel.fromJson(Map<String, dynamic>.from(data));
        // TODO: Update UI to show driver has arrived
      } catch (e) {
        log('Error parsing booking:arrived_pickup: $e');
      }
    });
  }

  /// Listens for driver heading to station events
  /// Event: booking:heading_to_station
  /// Triggered when the driver is en route to the station/destination
  static void listenForDriverHeadingToStation() {
    socket.off(SocketEvents.bookingHeadingToStationOn);
    socket.on(SocketEvents.bookingHeadingToStationOn, (data) {
      log('booking:heading_to_station received: $data');
      try {
        // TODO: Parse with BookingModel when response structure is known
        // final model = BookingModel.fromJson(Map<String, dynamic>.from(data));
        // TODO: Update UI to show driver is en route to destination
      } catch (e) {
        log('Error parsing booking:heading_to_station: $e');
      }
    });
  }

  /// Listens for payment collection events
  /// Event: booking:payment_collected
  /// Triggered when the driver has collected payment from the passenger
  static void listenForPaymentCollected() {
    socket.off(SocketEvents.bookingPaymentCollectedOn);
    socket.on(SocketEvents.bookingPaymentCollectedOn, (data) {
      log('booking:payment_collected received: $data');
      try {
        // TODO: Parse with BookingPaymentModel when response structure is known
        // final model = BookingPaymentModel.fromJson(Map<String, dynamic>.from(data));
        // TODO: Update UI to show payment collected status
      } catch (e) {
        log('Error parsing booking:payment_collected: $e');
      }
    });
  }

  /// Listens for booking completion events
  /// Event: booking:completed
  /// Triggered when a booking/ride is fully completed
  static void listenForBookingCompleted() {
    socket.off(SocketEvents.bookingCompletedOn);
    socket.on(SocketEvents.bookingCompletedOn, (data) {
      log('booking:completed received: $data');
      try {
        // TODO: Parse with BookingModel when response structure is known
        // final model = BookingModel.fromJson(Map<String, dynamic>.from(data));
        // TODO: Update UI to show booking is complete, prompt for review/rating
      } catch (e) {
        log('Error parsing booking:completed: $e');
      }
    });
  }

  /// Listens for payment initiation events
  /// Event: payment:initiated
  /// Triggered when a user starts the payment process
  static void listenForPaymentInitiated() {
    socket.off(SocketEvents.paymentInitiatedOn);
    socket.on(SocketEvents.paymentInitiatedOn, (data) {
      log('payment:initiated received: $data');
      try {
        // TODO: Parse with PaymentModel when response structure is known
        // final model = PaymentModel.fromJson(Map<String, dynamic>.from(data));
        // TODO: Update UI to show payment is being processed
      } catch (e) {
        log('Error parsing payment:initiated: $e');
      }
    });
  }

  /// Listens for payment callback events (online/gateway payments)
  /// Event: payment:callback
  /// Triggered after an online payment attempt (success or failure)
  static void listenForPaymentCallback() {
    socket.off(SocketEvents.paymentCallbackOn);
    socket.on(SocketEvents.paymentCallbackOn, (data) {
      log('payment:callback received: $data');
      try {
        // TODO: Parse with PaymentCallbackModel when response structure is known
        // final model = PaymentCallbackModel.fromJson(Map<String, dynamic>.from(data));
        // TODO: Update UI based on payment success/failure
      } catch (e) {
        log('Error parsing payment:callback: $e');
      }
    });
  }

  /// Listens for cash payment completion events
  /// Event: payment:cash_completed
  /// Triggered when a cash payment transaction is completed
  static void listenForCashPaymentCompleted() {
    socket.off(SocketEvents.paymentCashCompletedOn);
    socket.on(SocketEvents.paymentCashCompletedOn, (data) {
      log('payment:cash_completed received: $data');
      try {
        // TODO: Parse with PaymentModel when response structure is known
        // final model = PaymentModel.fromJson(Map<String, dynamic>.from(data));
        // TODO: Update UI to confirm cash payment received
      } catch (e) {
        log('Error parsing payment:cash_completed: $e');
      }
    });
  }

  /// Listens for new notification events using SocketEvents constants
  /// Event: notification:new
  /// Triggered when a new notification is sent to the user
  static void listenForNewNotification() {
    socket.off(SocketEvents.notificationNewOn);
    socket.on(SocketEvents.notificationNewOn, (data) {
      log('notification:new received: $data');
      try {
        // TODO: Parse with NotificationModel when response structure is known
        // final model = NotificationModel.fromJson(Map<String, dynamic>.from(data));
        // TODO: Show notification badge or toast message
      } catch (e) {
        log('Error parsing notification:new: $e');
      }
    });
  }

  /// Disconnects the socket connection
  /// Should be called when logging out or closing the app
  static void disconnect() {
    if (socket.connected) {
      socket.disconnect();
      log('Socket disconnected');
    }
  }

  /// Checks if the socket is currently connected
  /// Returns: true if connected, false otherwise
  static bool get isConnected => socket.connected;
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

