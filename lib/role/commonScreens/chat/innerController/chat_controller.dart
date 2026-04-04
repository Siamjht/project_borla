
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../helpers/prefs_helper.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/commonModels/chatMessageModels/chat_list_model.dart';
import '../../../../models/commonModels/chatMessageModels/chat_message_model.dart';
import '../../../../services/api_service.dart';
import '../../../../services/socket_service.dart';
import '../../../../utils/app_urls.dart';
import '../../../components/customSnackbar/custom_snackbar.dart';

class ChatController extends GetxController {

  static ChatController get instance => Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
  }


  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
    log("Phone number: $uri");
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Dialer error: $e');
    }
  }

  // ── Chat List Pagination ──
  final ScrollController chatListScrollController = ScrollController();
  final RxInt chatListPage = 1.obs;
  final RxBool hasMoreChats = false.obs;
  final RxBool isLoadingMoreChats = false.obs;
  final int chatListLimit = 20;
  String _bookingId = '';

  String get currentBookingId => _bookingId;

  /// Fetch Chat List
  final RxList<CustomChatListItem> chatList = <CustomChatListItem>[].obs;
  final RxBool isChatListLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> fetchChatList() async {
    isChatListLoading.value = true;
    chatListPage.value = 1;
    chatList.clear();
    errorMessage.value = '';

    try {
      final response = await ApiService.get(
        '${AppUrls.getChatList}?page=1&limit=$chatListLimit',
      );

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        chatList.value = data
            .map((e) => _mapToChatListItem(e))
            .toList();

        final meta = response.body['meta'];
        hasMoreChats.value = (meta?['page'] ?? 1) < (meta?['totalPage'] ?? 1);
      } else {
        errorMessage.value = response.message;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isChatListLoading.value = false;
    }
  }

  Future<void> _loadMoreChats() async {
    if (!hasMoreChats.value || isLoadingMoreChats.value) return;

    isLoadingMoreChats.value = true;
    chatListPage.value++;

    try {
      final response = await ApiService.get(
        '${AppUrls.getChatList}?page=${chatListPage.value}&limit=$chatListLimit',
      );

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        chatList.addAll(data.map((e) => _mapToChatListItem(e)).toList());

        final meta = response.body['meta'];
        hasMoreChats.value =
            (meta?['page'] ?? 1) < (meta?['totalPage'] ?? 1);
      }
    } finally {
      isLoadingMoreChats.value = false;
    }
  }

// ── Map API response → CustomChatListItem ─────────────────────
  CustomChatListItem _mapToChatListItem(Map<String, dynamic> json) {
    final participant = json['otherParticipant'] ?? {};
    final lastMsg = json['lastMessage'];

    // ✅ extract last message text or image
    String lastMessageText = '';
    if (lastMsg != null) {
      final text = lastMsg['text'] ?? '';
      final images = lastMsg['images'] as List? ?? [];
      if (text.isNotEmpty) {
        lastMessageText = text;
      } else if (images.isNotEmpty) {
        lastMessageText = '📷 Photo';
      }
    }

    // ✅ format time from createdAt
    final timeStr = formatChatTime(lastMsg?['createdAt'] ?? json['updatedAt']);

    // ✅ unread = last message not seen and not sent by current user
    final isSeen = lastMsg?['seen'] ?? true;
    final senderId = lastMsg?['senderId'] ?? '';
    final myId = PrefsHelper.userId; // your local user id
    final unreadCount = (!isSeen && senderId != myId) ? 1 : 0;

    return CustomChatListItem(
      chatId: json['id'] ?? '',
      participantId: participant['id'] ?? '',
      participantName: participant['name'] ?? '',
      participantProfile: participant['profilePicture'] ?? '',
      lastMessage: lastMessageText,
      unreadCount: unreadCount,
      isSeen: isSeen,
      time: timeStr,
    );
  }

  String formatChatTime(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '';
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      final now = DateTime.now();
      final diff = now.difference(dt);

      if (diff.inDays == 0) {
        // ✅ today → show time
        final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
        final minute = dt.minute.toString().padLeft(2, '0');
        final period = dt.hour >= 12 ? 'PM' : 'AM';
        return '$hour:$minute $period';
      } else if (diff.inDays == 1) {
        return 'Yesterday';
      } else if (diff.inDays < 7) {
        // ✅ this week → show day name
        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return days[dt.weekday - 1];
      } else {
        // ✅ older → show date
        return '${dt.day}/${dt.month}/${dt.year}';
      }
    } catch (_) {
      return '';
    }
  }

  Future<void> refresh() async {
    errorMessage.value = '';
    await fetchChatList();
  }

  // ── State ──────────────────────────────────────────────
  final RxBool isMessagesLoading = false.obs;
  final RxBool isSendingMessage = false.obs;
  final RxList<String> selectedImagePaths = <String>[].obs;
  String _currentBookingId = '';
  String _currentParticipantName = '';
  // final messages = <Map<String, dynamic>>[].obs;
  RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;

// ── Fetch Messages ─────────────────────────────────────
  Future<void> fetchMessages({
    required String bookingId,
    String participantName = '',
  }) async {
    _currentBookingId = bookingId;
    _currentParticipantName = participantName;
    isMessagesLoading.value = true;
    _bookingId = bookingId;
    messages.clear();

    try {
      final response = await ApiService.get(
        AppUrls.getMessages(bookingId: bookingId),
      );

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        final myId = PrefsHelper.userId;
        messages.value = data.map((e) => ChatMessageModel.fromJson(e)).toList();

        if (messages.isNotEmpty) {
          SocketServices.joinChat(chatId: messages.first.chatId);
        }
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isMessagesLoading.value = false;
    }
  }

// ── Send Message ───────────────────────────────────────
  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty && selectedImagePaths.isEmpty) return;
    if (_currentBookingId.isEmpty) {
      CustomSnackbar.error('No active booking found');
      return;
    }

    isSendingMessage.value = true;
    try {
      ApiResponseModel response;

      if (selectedImagePaths.isNotEmpty) {
        // ✅ multipart with images
        final imageList = selectedImagePaths
            .map((path) => {
          'imagePath': path,
          'imageName': 'images',
        }).toList();

        response = await ApiService.multipartRequestWithMultipleImages(
          url: AppUrls.sendMessages(bookingId: _currentBookingId),
          body: {'text': text},
          imageList: imageList,
          method: HttpMethod.post,
        );
      } else {
        // ✅ text only
        response = await ApiService.post(
          AppUrls.sendMessages(bookingId: _currentBookingId),
          body: {'text': text},
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {

        final newMsg = ChatMessageModel.fromJson(response.body['data']);
        messages.add(newMsg);

        messageController.clear();
        selectedImagePaths.clear();

        // ✅ scroll to bottom
        scrollToBottom();
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isSendingMessage.value = false;
    }
  }

// ── Pick Image ─────────────────────────────────────────
  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      selectedImagePaths.add(image.path);
    }
  }

  void removeSelectedImage(int index) {
    selectedImagePaths.removeAt(index);
  }

// ── Scroll to bottom ───────────────────────────────────
  final ScrollController messageScrollController = ScrollController();

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (messageScrollController.hasClients) {
        messageScrollController.animateTo(
          messageScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}