
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../theme/app_color.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../../components/gradient_scafold.dart';
import '../../components/image/shimmer_image_loader.dart';
import '../../components/text/common_text.dart';
import 'innerController/chat_controller.dart';

class RiderSupportChatScreen extends StatefulWidget {
  const RiderSupportChatScreen({super.key});

  @override
  State<RiderSupportChatScreen> createState() => _StartChatScreenState();
}

class _StartChatScreenState extends State<RiderSupportChatScreen> {
  final ChatController supportChatCtrl = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      supportChatCtrl.getSupportChatID();
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
                  Obx(() => CommonText(
                    text: supportChatCtrl.supportChat.value?.supportAgent.name.isNotEmpty ?? false
                        ? supportChatCtrl.supportChat.value!.supportAgent.name
                        : 'Customer Support',
                    fontSize: 18,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  )),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // ── Messages ─────────────────────────────────
            Expanded(
              child: Obx(() {
                if (supportChatCtrl.isSupportChatLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (supportChatCtrl.supportMessages.isEmpty) {
                  return const Center(
                    child: CommonText(
                      text: 'Start a conversation with support',
                      color: Colors.grey,
                    ),
                  );
                }

                return ListView.builder(
                  controller: supportChatCtrl.supportScrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: supportChatCtrl.supportMessages.length,
                  itemBuilder: (context, index) {
                    final msg = supportChatCtrl.supportMessages[index];
                    return Align(
                      alignment: msg['isMe']
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: MessageBubble(message: msg),
                    );
                  },
                );
              }),
            ),

            // ── Selected Images Preview ───────────────────
            Obx(() {
              if (supportChatCtrl.selectedImagePaths.isEmpty) {
                return const SizedBox.shrink();
              }
              return Container(
                height: 80,
                color: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: supportChatCtrl.selectedImagePaths.length,
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
                                File(supportChatCtrl.selectedImagePaths[index]),
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
                                supportChatCtrl.removeSelectedImage(index),
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
            _SupportChatInputBar(controller: supportChatCtrl),
          ],
        ),
      ),
    );
  }
}

// ── Support Input Bar ─────────────────────────────────────────
class _SupportChatInputBar extends StatelessWidget {
  final ChatController controller;

  const _SupportChatInputBar({required this.controller});

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
              onSubmitted: (_) => controller.sendSupportMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
            onPressed: () => controller.pickImage(ImageSource.camera),
          ),
          Obx(() => controller.isSendingSupportMessage.value
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : IconButton(
            icon: const Icon(Icons.send,
                color: AppColors.primaryColor),
            onPressed: controller.sendSupportMessage,
          )),
        ],
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isMe = message['isMe'];
    final List? images = message['images'];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [

          if (images != null && images.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                alignment: isMe ? WrapAlignment.end : WrapAlignment.start,
                children: images.map((url) {
                  return ShimmerImageLoader(
                    url: url,
                    width: 100,
                    height: 100,
                    borderRadius: 8,
                  );
                }).toList(),
              ),
            ),
          if (message['text'] != null &&
              (message['text'] as String).isNotEmpty)
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
                text: message['text'],
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),

          const SizedBox(height: 4),
          CommonText(
            text: message['time'] ?? '',
            fontSize: 12,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}