

// ---------------- USER ROW ----------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_color.dart';
import '../../../features/fragments/dotted_line_copy.dart';
import '../../../gen/custom_assets/assets.gen.dart';
import '../../../role/components/text/common_text.dart';
import '../../chat-screen/chat_screen_copy.dart';
import '../activity-controller/activity_controller_copy.dart';

Widget userRow() {
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
            CommonText(
              text: 'User',
              fontSize: 14,
              color: Colors.grey,
            ),
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
              child: circleAction(Assets.icons.messageIcon.image(height: 20, width: 20))),
          const SizedBox(width: 12),
          circleAction(Assets.icons.callIcon.image(height: 20, width: 20)),
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

Widget circleAction(Image icon) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.primaryColor),
    ),
    child: Center(child: icon),
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
              color: AppColors.primaryColor, size: 18),
          SizedBox(height: 6),
          VerticalDottedLine(),
          SizedBox(height: 6),
          Icon(Icons.location_on, color: AppColors.primaryColor, size: 20),
        ],
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: '85 Ave, Street Side Road, Accra, Ghana',
              fontSize: 15,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: HorizontalDottedLine()),
                distanceChip(),
              ],
            ),
            const SizedBox(height: 12),
            const CommonText(
              text: '1901 Thornridge Road, Accra, Ghana',
              fontSize: 15,
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
      color: AppColors.primaryColor,
    ),
  );
}

// ---------------- PAYMENT ----------------
Widget paymentRow() {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.gray200,
        ),
        child: const Icon(
          Icons.payment_outlined,
          color: AppColors.primaryColor,
        ),
      ),
      const SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            text: "Payment",
            fontSize: 12,
            color: AppColors.gray300,
          ),
          const CommonText(
            text: 'MTN MoMo Pay',
            fontSize: 16,
          ),
        ],
      ),
      const Spacer(),
      const CommonText(
        text: 'GH₵ 50',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    ],
  );
}
