
// ---------------- ACTION BUTTONS ----------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../features/fragments/dotted_line_copy.dart';
import '../../../../role/components/text/common_text.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/common_button_copy.dart';
import '../../../../theme/custom_container_copy.dart';
import '../../../../theme/user_outgoing_call_screen.dart';
import '../../../../utils/custom-gen-assets/assets.gen.dart';
import '../../../activity-screens/activity-controller/activity_controller_copy.dart';
import '../../../chat-screen/chat_screen_copy.dart';

import '../user-controller/user_home_controller.dart';
import 'driver_info_screen_copy.dart';

Widget actionButtons(BuildContext context,) {
  return Row(
    children: [
      Expanded(
        child: CommonButton(
          // onTap: controller.declineJob, // ✅ controller handles logic
          buttonRadius: 12,
          titleText: "Decline",
          titleColor: AppColors.green500,
          borderColor: AppColors.green500,
        ),
      ),
      SizedBox(width: 20,),
      Expanded(
        child: CommonButton(
          onTap: (){
            UserHomeController.instance.isBottomSheet.value = true;
            Get.to(()=> CustomerInfoScreen());
          },
          // onTap: controller.acceptJob,
          buttonRadius: 12,
          titleText: "Accept",
        ),
      ),
    ],
  );
}

// ---------------- USER ROW ----------------
Widget userRow(UserHomeController controller, {role}) {
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
                Icon(Icons.star, color: Colors.amber, size: 20,),
                SizedBox(width: 2,),
                Text('5.0', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey
                ),),
                SizedBox(width: 6,),
                Text('(1.2k rides)', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey
                ),)
              ],
            )
            // CommonText(
            //   text: 'User',
            //   fontSize: 14,
            //   color: Colors.grey,
            // ),
          ],
        ),
      ),

      UserActivityController.instance.selectedIndex.value == 0?
      Row(
        children: [
          InkWell(
              onTap: () {
                Get.to(()=> UserChattingScreen());
              },
              child: circleAction(Assets.icons.messageIcon.image(height: 20, width: 20, color: AppColors.orange300))),
          const SizedBox(width: 12),
          InkWell(
              onTap: () {
                Get.to(()=> UserOutgoingCallScreen());
              },
              child: circleAction(Assets.icons.callIcon.image(height: 20, width: 20, color: AppColors.orange300))),
        ],
      ) : UserActivityController.instance.selectedIndex.value == 1?
      Column(
        children: [
          CommonText(text: "Dec 23" , color: AppColors.orange300,),
          CommonText(text: "10:00 PM", color: AppColors.orange300, fontSize: 14,),
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



      // controller.isBottomSheet.value?
      // Row(
      //   children: [
      //     InkWell(
      //         onTap: () {
      //           Get.to(()=> UserChattingScreen());
      //         },
      //         child: circleAction(Assets.icons.messageIcon.image(height: 20, width: 20, color: AppColors.orange300))),
      //     const SizedBox(width: 12),
      //     InkWell(
      //         onTap: () {
      //           Get.to(()=> OutgoingCallScreen());
      //         },
      //         child: circleAction(Assets.icons.callIcon.image(height: 20, width: 20,  color: AppColors.orange300))),
      //   ],
      // )
      //     : role == "rider" ? countdownRing(controller) : SizedBox.shrink(),
    ],
  );
}

Widget circleAction(Image icon) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.orange300),
    ),
    child: Center(child: icon),
  );
}

// ---------------- SAFE ANIMATION (NO Obx) ----------------
Widget countdownRing(UserHomeController controller) {
  return SizedBox(
    width: 80,
    height: 80,
    child: AnimatedBuilder(
      animation: controller.animation,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: controller.animation.value,
              strokeWidth: 6,
              backgroundColor: AppColors.gray200,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF4CAF50)),
            ),
            CommonText(
              text: '${controller.remainingSeconds}s',
              fontSize: 14,
              color: AppColors.green500,
            )
          ],
        );
      },
    ),
  );
}

// ---------------- LOCATION ----------------
Widget locationSection() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(Icons.radio_button_checked,
              color: Colors.amber, size: 18),
          SizedBox(height: 6),
          VerticalDottedLine(),
          SizedBox(height: 6),
          Icon(Icons.location_on,
              color: Colors.amber, size: 20),
        ],
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              textAlign: TextAlign.start,
              text: '85 Ave, Street Side Road, Accra, Ghana',
              fontSize: 14,
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(child: HorizontalDottedLine()),
                distanceChip(),
              ],
            ),
            SizedBox(height: 8),
            CommonText(
              textAlign: TextAlign.start,
              text: '1901 Thornridge Road, Accra, Ghana',
              fontSize: 14,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget distanceChip() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20),
          blurRadius: 8,
          spreadRadius: 2,
        ),
      ],
    ),
    child: const CommonText(
      text: '22.6 KM',
      fontWeight: FontWeight.w600,
      color: Colors.amber,
    ),
  );
}
// ---------------- PAYMENT ----------------
Widget paymentRow() {
  return Row(
    children: [
      CustomContainer(
          padding: EdgeInsets.all(10),
          borderRadius: 100,
          color: AppColors.gray100,
          child: Center(child: Assets.icons.creditCardIcon.image(height: 20, width: 20))),
      SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "Payment",
            fontSize: 12,
            color: AppColors.gray300,
          ),
          CommonText(
            text: 'MTN MoMo Pay',
            fontSize: 16,
          ),
        ],
      ),
      Spacer(),
      CommonText(
        text: 'GH₵ 50',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.amber,
      ),
    ],
  );
}
