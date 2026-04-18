
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/gradient_scaffold_copy.dart';
import '../../../role/commonScreens/chat/innerController/chat_controller.dart';
import '../../../role/components/commonBackButton/common_back_button.dart';
import '../../../role/components/image/shimmer_image_loader.dart';
import '../../../role/components/text/common_text.dart';

class UserSupportChatScreen extends StatefulWidget {
  const UserSupportChatScreen({super.key});

  @override
  State<UserSupportChatScreen> createState() => _UserSupportChatScreenState();
}

class _UserSupportChatScreenState extends State<UserSupportChatScreen> {
  final ChatController supportChatCtrl = ChatController.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      supportChatCtrl.getSupportChatID();
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(
      child: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const CommonBackButton(),
                  const SizedBox(width: 54),
                  Obx(() => CommonText(
                    text: supportChatCtrl.supportChat.value?.supportAgent.name.isNotEmpty ?? false
                        ? supportChatCtrl.supportChat.value!.supportAgent.name
                        : 'Customer Support',
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  )),
                ],
              ),
            ),

            // ── Messages ─────────────────────────────────
            Expanded(
              child: Obx(() {
                if (supportChatCtrl.isSupportChatLoading.value) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.orange300));
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                            onTap: () => supportChatCtrl.removeSelectedImage(index),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, color: Colors.white, size: 14),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }),

            const Divider(
              height: 20,
              color: Color.fromRGBO(232, 232, 232, 1),
            ),

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
                hintText: 'Type your message...',
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(174, 174, 174, 1),
                  fontSize: 15,
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(230, 230, 230, 1),
                    width: 1.2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(230, 230, 230, 1),
                    width: 1.5,
                  ),
                ),
              ),
              onSubmitted: (_) => controller.sendSupportMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
            onPressed: () => controller.pickImage(ImageSource.camera),
          ),
          const SizedBox(width: 8),
          Obx(() => controller.isSendingSupportMessage.value
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.orange300),
                )
              : GestureDetector(
                  onTap: controller.sendSupportMessage,
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.orange300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/send_iconn.png',
                          color: Colors.white,
                          height: 14,
                          width: 14,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          const SizedBox(width: 8),
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
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
          if (message['text'] != null && (message['text'] as String).isNotEmpty)
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.75),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.orange300 : Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: isMe ? const Radius.circular(0) : const Radius.circular(20),
                  topLeft: isMe ? const Radius.circular(20) : const Radius.circular(0),
                  bottomRight: const Radius.circular(20),
                  bottomLeft: const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
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
