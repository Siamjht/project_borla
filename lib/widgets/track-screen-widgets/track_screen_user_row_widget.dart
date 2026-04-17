
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../role/components/text/common_text.dart';
import '../../role/garbageCollector/call/outgoing_call_screen.dart';
import '../../screens/activity-screens/activity-controller/user_activity_controller.dart';
import '../../screens/chat-screen/user_chat_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/user_outgoing_call_screen.dart';

Widget userRowMod() {
  return Row(
    children: [
      const CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage('https://shorturl.at/WSMrn'),
      ),
      const SizedBox(width: 16),
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: 'Jenny Wilson',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 4),

            Row(
              children: [
                Icon(Icons.star, color: Colors.amber,),
                SizedBox(width: 2,),
                Text('5.0', style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54
                ),),
                SizedBox(width: 6,),
                Text('(1.2k rides)', style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54
                ),)
              ],
            )


          ],
        ),
      ),
      UserActivityController.instance.selectedIndex.value == 0?
      Row(
        children: [
          InkWell(
              onTap: () {
                // Get.to(()=> UserChattingScreen());
              },
              child: circleActionMod(
                  Image.asset('assets/images/user_msg.png',height: 20, width: 20,)
              )),
          const SizedBox(width: 12),
          //circleAction(Assets.icons.callIcon.image(height: 20, width: 20)),
          InkWell(
            onTap: () {
              Get.to(()=> UserOutgoingCallScreen());
            },
            child: circleActionMod(
              //Assets.icons.callIcon.image(height: 20, width: 20)
                Image.asset('assets/images/user_call.png',height: 20, width: 20,)

            ),
          ),

        ],
      ) : UserActivityController.instance.selectedIndex.value == 1?
      Column(
        children: [
          CommonText(text: "Dec 23" , color: AppColors.green500,),
          CommonText(text: "10:00 PM", color: AppColors.gray300, fontSize: 14,),
        ],
      ) :
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.green500,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.green100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: CommonText(text: "Completed", color: AppColors.white, fontSize: 12, fontWeight: FontWeight.w600,),
      )
    ],
  );
}

Widget circleActionMod(Image icon) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.amber),
    ),
    child: Center(child: icon),
  );
}