import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/screens/support-chat-screens/support-msg-screen/support_chat_screen.dart';
import 'package:project_borla/theme/app_color.dart';
import 'package:project_borla/theme/gradient_scaffold_copy.dart';

class StartChatScreen extends StatelessWidget {
  const StartChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserGradientScaffold(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: 60,),
                Row(
                  children: [
                    CommonBackButton(),
                    SizedBox(width: 54,),
                    CommonText(
                      text: 'Customer Support',
                      fontSize: 19 ,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
                SizedBox(height: Get.height * 0.15,),
                SvgPicture.asset(
                  'assets/images/user_support.svg',
                  height: 180,
                ),
                SizedBox(height: 46,),
                CommonText(
                    text: 'How can we help you?',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color.fromRGBO(72, 72, 72, 1),
                ),
                SizedBox(height: 14,),
                CommonText(
                    text: 'Get instant 24/7 support from our assistant,\n  or connect with one of our expert agents.',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color.fromRGBO(137, 137, 137, 1),
                ),
                Spacer(),
                CommonButton(
                  titleText: 'Start a chat',
                  firstGradient: AppColors.orange300,
                  secondGradient: AppColors.orange300,
                  buttonRadius: 12,
                  buttonHeight: 48,
                  onTap: (){
                    Get.to(()=>SupportChatScreen());
                  },
                )
              ],
            ),
          )
      )


    );
  }
}
