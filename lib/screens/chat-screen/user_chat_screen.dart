
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_borla/helpers/prefs_helper.dart';
import 'package:project_borla/models/commonModels/chatMessageModels/chat_message_model.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../role/commonScreens/chat/innerController/chat_controller.dart';
import '../../role/components/image/shimmer_image_loader.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/common_back_button_copy.dart';
import '../../theme/gradient_scaffold_copy.dart';


class UserChattingScreen extends StatefulWidget {
  final String bookingId;
  final String participantName;
  final String? participantPhone;

  const UserChattingScreen({
    super.key,
    required this.bookingId,
    this.participantName = '',
    this.participantPhone,
  });

  @override
  State<UserChattingScreen> createState() => _UserChattingScreenState();
}

class _UserChattingScreenState extends State<UserChattingScreen> {
  final ChatController userChatCtrl = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userChatCtrl.fetchMessages(
        bookingId: widget.bookingId,
        participantName: widget.participantName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(
      gradientOne: AppColors.orange100,
      child: SafeArea(
        child: Column(
          children: [
            /// Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonBackButton(),
                  CommonText(
                    text: widget.participantName.isNotEmpty
                        ? widget.participantName
                        : 'Chat',
                    fontSize: 18,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.participantPhone != null) {
                        userChatCtrl.makePhoneCall(widget.participantPhone!);
                      }
                      // else {
                      //   Get.to(() => UserOutgoingCallScreen());
                      // }
                    },
                    child: _circleAction(Icons.phone),
                  ),
                ],
              ),
            ),

            /// Messages
            Expanded(
              child: Obx(() {
                if (userChatCtrl.isMessagesLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (userChatCtrl.messages.isEmpty) {
                  return const Center(
                    child: CommonText(
                      text: 'No messages yet',
                      color: Colors.grey,
                    ),
                  );
                }

                return ListView.builder(
                  controller: userChatCtrl.messageScrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: userChatCtrl.messages.length,
                  itemBuilder: (context, index) {
                    final msg = userChatCtrl.messages[index];
                    return _MessageBubble(message: msg);
                  },
                );
              }),
            ),

            /// Selected Images Preview
            Obx(() {
              if (userChatCtrl.selectedImagePaths.isEmpty) {
                return const SizedBox.shrink();
              }
              return Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: userChatCtrl.selectedImagePaths.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: FileImage(
                                File(userChatCtrl.selectedImagePaths[index]),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -6,
                          right: 2,
                          child: GestureDetector(
                            onTap: () => userChatCtrl.removeSelectedImage(index),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close,
                                  color: Colors.white, size: 14),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }),

            /// Input Bar
            _ChatInputBar(controller: userChatCtrl),
          ],
        ),
      ),
    );
  }

  Widget _circleAction(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.orange300),
      ),
      child: Icon(icon, color: AppColors.orange300, size: 20),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessageModel message;

  _MessageBubble({required this.message});

  final chatCtrl = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    final bool isMe = message.senderId == PrefsHelper.userId;
    final images = message.images;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // ── Images ──────────────────────────────────
          if (images.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                alignment: isMe ? WrapAlignment.end : WrapAlignment.start,
                children: images.map((url) {
                  return ShimmerImageLoader(
                    url: url.image,
                    width: 100,
                    height: 100,
                    borderRadius: 8,
                  );
                }).toList(),
              ),
            ),
          // ── Text ────────────────────────────────────
          if (message.text.isNotEmpty)
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.75),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.orange300 : Colors.white,
                borderRadius: BorderRadius.only(
                  topRight:
                      isMe ? const Radius.circular(0) : const Radius.circular(20),
                  topLeft:
                      isMe ? const Radius.circular(20) : const Radius.circular(0),
                  bottomRight: const Radius.circular(20),
                  bottomLeft: const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: CommonText(
                textAlign: isMe ? TextAlign.right : TextAlign.left,
                text: message.text,
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
          const SizedBox(height: 4),
          CommonText(
            text: chatCtrl.formatChatTime(message.createdAt),
            fontSize: 12,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class _ChatInputBar extends StatelessWidget {
  final ChatController controller;

  const _ChatInputBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.grey),
            onPressed: () => controller.pickImage(ImageSource.gallery),
          ),
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: InputDecoration(
                hintText: 'Send a message',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => controller.sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
            onPressed: () => controller.pickImage(ImageSource.camera),
          ),
          // ✅ show loading or send button
          Obx(() => controller.isSendingMessage.value
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : IconButton(
                  icon: const Icon(Icons.send, color: AppColors.orange300),
                  onPressed: controller.sendMessage,
                )),
        ],
      ),
    );
  }
}
