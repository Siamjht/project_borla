
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../helpers/prefs_helper.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/commonModels/chatMessageModels/chat_list_model.dart';
import '../../../../models/commonModels/chatMessageModels/chat_message_model.dart';
import '../../../../models/commonModels/chatMessageModels/support_chat_model.dart';
import '../../../../services/api_service.dart';
import '../../../../services/socket_service.dart';
import '../../../../services/sound_service.dart';
import '../../../../utils/app_urls.dart';
import '../../../components/customSnackbar/custom_snackbar.dart';

class ChatController extends GetxController {

  static ChatController get instance => Get.find<ChatController>();

  final TextEditingController messageController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  // ── Observable States ──
  final RxBool isChatListLoading = false.obs;
  final RxBool isMessagesLoading = false.obs;
  final RxBool isSendingMessage = false.obs;
  final RxBool isSupportChatLoading = false.obs;
  final RxBool isSendingSupportMessage = false.obs;
  final RxList<String> selectedImagePaths = <String>[].obs;
  final RxString errorMessage = ''.obs;

  // ── Chat List Pagination ──
  final ScrollController chatListScrollController = ScrollController();
  final RxInt chatListPage = 1.obs;
  final RxBool hasMoreChats = false.obs;
  final RxBool isLoadingMoreChats = false.obs;
  final int chatListLimit = 20;

  // ── Normal Chat Pagination ──
  final ScrollController messageScrollController = ScrollController();
  final RxInt messagePage = 1.obs;
  final RxBool hasMoreMessages = false.obs;
  final RxBool isLoadingMoreMessages = false.obs;
  final int messageLimit = 20;

  // ── Support Chat Pagination ──
  final ScrollController supportScrollController = ScrollController();
  final RxInt supportPage = 1.obs;
  final RxBool hasMoreSupportMessages = false.obs;
  final RxBool isLoadingMoreSupportMessages = false.obs;
  final int supportLimit = 20;

  // ── Data ──
  String _currentBookingId = '';
  String _chatId = ''; // For normal chat if needed
  String supportChatId = ''; // For support chat

  String get currentBookingId => _currentBookingId;
  String get currentChatId => _chatId;

  final RxList<CustomChatListItem> chatList = <CustomChatListItem>[].obs;
  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  final RxList<Map<String, dynamic>> supportMessages = <Map<String, dynamic>>[].obs;
  final Rx<SupportChatModel?> supportChat = Rx<SupportChatModel?>(null);

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

  /// Fetch Chat List
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

    final timeStr = formatChatTime(lastMsg?['createdAt'] ?? json['updatedAt']);

    final isSeen = lastMsg?['seen'] ?? true;
    final senderId = lastMsg?['senderId'] ?? '';
    final myId = PrefsHelper.userId;
    final unreadCount = (!isSeen && senderId != myId) ? 1 : 0;

    return CustomChatListItem(
      chatId: json['id'] ?? '',
      bookingId: json['bookingId'] ?? '',
      participantId: participant['id'] ?? '',
      participantName: participant['name'] ?? '',
      participantProfile: participant['profilePicture'] ?? '',
      participantRole: participant['role'] ?? '',
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
        final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
        final minute = dt.minute.toString().padLeft(2, '0');
        final period = dt.hour >= 12 ? 'PM' : 'AM';
        return '$hour:$minute $period';
      } else if (diff.inDays == 1) {
        return 'Yesterday';
      } else if (diff.inDays < 7) {
        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return days[dt.weekday - 1];
      } else {
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

  // ── Normal Chat Methods ──
  Future<void> fetchMessages({
    required String bookingId,
    String participantName = '',
  }) async {
    _currentBookingId = bookingId;
    isMessagesLoading.value = true;
    messagePage.value = 1;
    messages.clear();

    try {
      final response = await ApiService.get(
        '${AppUrls.getMessages(bookingId: bookingId)}?page=1&limit=$messageLimit',
      );

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        messages.value = data.map((e) => ChatMessageModel.fromJson(e)).toList();

        final meta = response.body['meta'];
        if (meta != null) {
          hasMoreMessages.value = (meta['page'] ?? 1) < (meta['totalPage'] ?? 1);
        }

        if (messages.isNotEmpty) {
          _chatId = messages.first.chatId;
          SocketServices.joinChat(chatId: _chatId);
        }
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isMessagesLoading.value = false;
    }
  }

  Future<void> loadMoreMessages() async {
    if (!hasMoreMessages.value || isLoadingMoreMessages.value || _currentBookingId.isEmpty) return;

    isLoadingMoreMessages.value = true;
    messagePage.value++;

    try {
      final response = await ApiService.get(
        '${AppUrls.getMessages(bookingId: _currentBookingId)}?page=${messagePage.value}&limit=$messageLimit',
      );

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        final List<ChatMessageModel> moreMessages =
            data.map((e) => ChatMessageModel.fromJson(e)).toList();
        
        messages.addAll(moreMessages);

        final meta = response.body['meta'];
        if (meta != null) {
          hasMoreMessages.value = (meta['page'] ?? 1) < (meta['totalPage'] ?? 1);
        }
      }
    } finally {
      isLoadingMoreMessages.value = false;
    }
  }

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
        response = await ApiService.post(
          AppUrls.sendMessages(bookingId: _currentBookingId),
          body: {'text': text},
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newMsg = ChatMessageModel.fromJson(response.body['data']);
        messages.insert(0, newMsg);
        messageController.clear();
        selectedImagePaths.clear();
        SoundService.instance.playMessageSend();
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isSendingMessage.value = false;
    }
  }

  // ── Image Picking ──
  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      selectedImagePaths.add(image.path);
    }
  }

  void removeSelectedImage(int index) {
    selectedImagePaths.removeAt(index);
  }

  // ── Support Chat Methods ──
  Future<void> getSupportChatID() async {
    isSupportChatLoading.value = true;
    try {
      final response = await ApiService.get(AppUrls.getSupportChatID);

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        if (data.isNotEmpty) {
          supportChat.value = SupportChatModel.fromJson(data.first);
          supportChatId = supportChat.value!.lastMessage!.chatId;
          await getSupportMessages(chatId: supportChatId);
        }
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isSupportChatLoading.value = false;
    }
  }

  Future<void> getSupportMessages({required String chatId}) async {
    isSupportChatLoading.value = true;
    supportPage.value = 1;
    supportMessages.clear();
    supportChatId = chatId;

    try {
      final response = await ApiService.get(
        '${AppUrls.getSupportMessages(chatId: chatId)}?page=1&limit=$supportLimit',
      );

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        final myId = PrefsHelper.userId;

        supportMessages.value = data
            .map((e) => ChatMessageModel.fromJson(e).toMessageMap(myId))
            .toList();

        final meta = response.body['meta'];
        if (meta != null) {
          hasMoreSupportMessages.value = (meta['page'] ?? 1) < (meta['totalPage'] ?? 1);
        }
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isSupportChatLoading.value = false;
    }
  }

  Future<void> loadMoreSupportMessages() async {
    if (!hasMoreSupportMessages.value || isLoadingMoreSupportMessages.value || supportChatId.isEmpty) return;

    isLoadingMoreSupportMessages.value = true;
    supportPage.value++;

    try {
      final response = await ApiService.get(
        '${AppUrls.getSupportMessages(chatId: supportChatId)}?page=${supportPage.value}&limit=$supportLimit',
      );

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        final myId = PrefsHelper.userId;
        final List<Map<String, dynamic>> moreMessages = data
            .map((e) => ChatMessageModel.fromJson(e).toMessageMap(myId))
            .toList();

        supportMessages.addAll(moreMessages);

        final meta = response.body['meta'];
        if (meta != null) {
          hasMoreSupportMessages.value = (meta['page'] ?? 1) < (meta['totalPage'] ?? 1);
        }
      }
    } finally {
      isLoadingMoreSupportMessages.value = false;
    }
  }

  Future<void> sendSupportMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty && selectedImagePaths.isEmpty) return;

    isSendingSupportMessage.value = true;
    try {
      ApiResponseModel response;

      if (selectedImagePaths.isNotEmpty) {
        final imageList = selectedImagePaths
            .map((path) => {
          'imagePath': path,
          'imageName': 'images',
        }).toList();

        response = await ApiService.multipartRequestWithMultipleImages(
          url: AppUrls.sendSupportChat,
          body: {'text': text},
          imageList: imageList,
          method: HttpMethod.post,
        );
      } else {
        response = await ApiService.post(
          AppUrls.sendSupportChat,
          body: {'text': text},
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final myId = PrefsHelper.userId;
        final result = SendSupportMessageModel.fromJson(response.body['data']);
        supportMessages.insert(0, result.message.toMessageMap(myId));
        messageController.clear();
        selectedImagePaths.clear();
        SoundService.instance.playMessageSend();
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isSendingSupportMessage.value = false;
    }
  }
}
