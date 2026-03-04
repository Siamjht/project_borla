
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/common_back_button_copy.dart';
import '../../theme/gradient_scaffold_copy.dart';
import '../../theme/user_outgoing_call_screen.dart';
import 'chat_screen_controller.dart';


class UserChattingScreen extends StatelessWidget {
  UserChattingScreen({super.key, });

  final ChatController controller = Get.put(ChatController());

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
                    text: "McKenna Thomas",
                    fontSize: 18,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                  InkWell(
                      onTap: () {
                         Get.to(()=> UserOutgoingCallScreen());
                      },
                      child: _circleAction(Icons.phone)),
                ],
              ),
            ),

            /// Messages
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    final bool isMe = msg['isMe'];

                    return Align(
                      alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: _MessageBubble(message: msg),
                    );
                  },
                ),
              ),
            ),

            /// Input Bar
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
        border: Border.all(color: AppColors.orange300),
      ),
      child: Icon(icon, color: AppColors.orange300, size: 20),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isMe = message['isMe'];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          message['images'] != null
              ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: message['images'].length,
            itemBuilder: (_, i) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                message['images'][i],
                fit: BoxFit.cover,
              ),
            ),
          )
              :
          Container(
            constraints:
            BoxConstraints(maxWidth: Get.width * 0.75),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isMe ? AppColors.orange300 : Colors.white,
              borderRadius: BorderRadius.only(
                topRight: isMe ? Radius.circular(0) : Radius.circular(20), topLeft: isMe ? Radius.circular(20) : Radius.circular(0),
                bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20),
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
            text: message['time'],
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
          IconButton(
            icon: const Icon(Icons.send, color: AppColors.orange300),
            onPressed: controller.sendMessage,
          ),
        ],
      ),
    );
  }
}
