import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_borla/models/commonModels/chatMessageModels/chat_message_model.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../helpers/prefs_helper.dart';
import '../../components/gradient_scafold.dart';
import '../../components/image/shimmer_image_loader.dart';
import 'innerController/chat_controller.dart';

class ChattingScreen extends StatefulWidget {
  final String bookingId;
  final String participantName;
  final String? participantPhone;

  const ChattingScreen({
    super.key,
    required this.bookingId,
    this.participantName = '',
    this.participantPhone,
  });

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final ChatController controller = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMessages(
        bookingId: widget.bookingId,
        participantName: widget.participantName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────
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
                        controller.makePhoneCall(widget.participantPhone!);
                      }
                    },
                    child: _circleAction(Icons.phone),
                  ),
                ],
              ),
            ),

            // ── Messages ─────────────────────────────────
            Expanded(
              child: Obx(() {
                if (controller.isMessagesLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.messages.isEmpty) {
                  return const Center(
                    child: CommonText(
                      text: 'No messages yet',
                      color: Colors.grey,
                    ),
                  );
                }

                return ListView.builder(
                  controller: controller.messageScrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    return _MessageBubble(message: msg);
                  },
                );
              }),
            ),

            // ── Selected Images Preview ───────────────────
            Obx(() {
              if (controller.selectedImagePaths.isEmpty) {
                return const SizedBox.shrink();
              }
              return Container(
                height: 80,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 6),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.selectedImagePaths.length,
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
                                File(controller
                                    .selectedImagePaths[index]),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -6,
                          right: 2,
                          child: GestureDetector(
                            onTap: () =>
                                controller.removeSelectedImage(index),
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

            // ── Input Bar ─────────────────────────────────
            _ChatInputBar(controller: controller),
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
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Icon(icon, color: AppColors.primaryColor, size: 20),
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
    log(" image path: ${images.toString()}");
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
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primaryColor : Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(20),
                  topLeft: isMe
                      ? const Radius.circular(20)
                      : const Radius.circular(0),
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
            icon: const Icon(Icons.send, color: AppColors.primaryColor),
            onPressed: controller.sendMessage,
          )),
        ],
      ),
    );
  }
}
