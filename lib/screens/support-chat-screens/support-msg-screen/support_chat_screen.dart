import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_borla/screens/support-chat-screens/support-msg-screen/support_chat_controller.dart';
import 'package:project_borla/theme/gradient_scaffold_copy.dart';


import '../../../role/components/commonBackButton/common_back_button.dart';
import '../../../role/components/text/common_text.dart';
import '../../../theme/app_color.dart';
import '../../../theme/user_outgoing_call_screen.dart';

class SupportChatScreen extends StatefulWidget {
  SupportChatScreen({super.key});


  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {

  final UserSupportChatController controller = Get.put(UserSupportChatController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserGradientScaffold(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
            child: Column(
              children: [
                /// Header
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      CommonBackButton(),
                      SizedBox(width: 60,),
                      CommonText(
                        text: 'Customer Support',
                        fontSize: 19 ,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),

                SizedBox(height: 20,),

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

                Divider(
                  height: 20,
                  color: Color.fromRGBO(232, 232, 232, 1),
                ),

                /// Input Bar
                ChatInputBar(controller: controller),
              ],
            ),
          ),
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
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonText(
                  textAlign: isMe ? TextAlign.left : TextAlign.left,
                  text: message['text'],
                  color: isMe ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
                CommonText(
                  text: message['time'],
                  fontSize: 12,
                  color: isMe? Colors.white :Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

