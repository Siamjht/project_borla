
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_borla/theme/common_button_copy.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../theme/app_color.dart';

class UserSupportChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  final messages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    messages.addAll([
      {
        'text': 'Hello John, we received a\nreport that a scheduled pickup\nwas missed. Can you please\nconfirm what happened?',
        'time': '09:41',
        'isMe': false,
      },
      {
        'text': 'Hello, yes. I reached the\nlocation but the customer was\nunavailable. I waited for 10\nminutes and tried calling.',
        'time': '09:41',
        'isMe': true,
      },
      {
        'text': 'Thank you for the update.\nPlease ensure to mark such\ncases correctly in the app next\ntime.',
        'time': '09:41',
        'isMe': false,
      },
      {
        'text':
        'Sorry about that. There was\nheavy traffic in my zone.\nI am heading to the location\nnow.',
        'time': '09:41',
        'isMe': true,
      },
      {
        'text': 'Understood. Please keep the\ncustomer informed through the\napp.',
        'time': '09:41',
        'isMe': false,
      },
    ]);
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    messages.add({
      'text': messageController.text.trim(),
      'time': 'Now',
      'isMe': true,
    });

    messageController.clear();
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      messages.add({
        'images': [image.path],
        'time': 'Now',
        'isMe': true,
      });
    }
  }


  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');

    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Dialer error: $e');
    }
  }

}

class ChatInputBar extends StatelessWidget {
  final UserSupportChatController controller;

  const ChatInputBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          // IconButton(
          //   icon: const Icon(Icons.add_circle_outline, color: Colors.grey),
          //   onPressed: () => controller.pickImage(ImageSource.gallery),
          // ),
          SizedBox(width: 16,),
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: Color.fromRGBO(174, 174, 174, 1),
                  fontSize: 15
                ),
                hintText: 'Type your message...',
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,  // 👈 height control
                  horizontal: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(230, 230, 230, 1),
                    width: 1.2,
                  ),
                ),

                // 👇 Focused (keyboard open / tapped)
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(
                    color: Color.fromRGBO(230, 230, 230, 1),
                    width: 1.5,
                  ),
                ),
                //fillColor: Colors.grey[100],
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10),
                //   borderSide: BorderSide(
                //     color: Colors.blue, // default border color
                //     width: 1.2,
                //   ),
                // ),
              ),
              onSubmitted: (_) => controller.sendMessage(),
            ),
          ),
          // IconButton(
          //   icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
          //   onPressed: () => controller.pickImage(ImageSource.camera),
          // ),
          // IconButton(
          //   icon: const Icon(Icons.send, color: AppColors.orange300),
          //   onPressed: controller.sendMessage,
          // ),
          SizedBox(width: 12,),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.orange300,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
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
                const SizedBox(width: 10),
              ],
            ),
          ),
          SizedBox(width: 16,),

        ],
      ),
    );
  }
}