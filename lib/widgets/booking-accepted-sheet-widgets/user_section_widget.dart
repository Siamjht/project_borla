import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/image/shimmer_image_loader.dart';
import 'package:project_borla/utils/app_urls.dart';
import '../../models/userModels/bookingModels/user_booking_model.dart';
import '../../role/components/text/common_text.dart';
import '../../role/garbageCollector/activity/controller/activity_controller.dart';
import '../../screens/chat-screen/chat_screen_copy.dart';
import '../../theme/app_color.dart';
import '../../theme/user_outgoing_call_screen.dart';

Widget userSectionWidget({RiderModel? rider}) {
  log("Rider Ratings");
  log("${rider?.averageRating}");
  log("${rider?.totalRatings}");
  return Row(
    children: [
      InkWell(
        onTap: () {
          if (rider != null) {
            // Get.to(() => DriverInformationScreen());
          }
        },
        child: rider?.profilePicture.isNotEmpty == true
            ? ShimmerImageLoader(url: rider!.profilePicture, width: 60, height: 60, borderRadius: 50,)
            : const Icon(Icons.person, size: 30, color: Colors.grey),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: rider?.name ?? 'Driver',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 2),
                Text(
                  rider != null && rider.averageRating > 0
                      ? rider.averageRating.toStringAsFixed(1)
                      : 'N/A',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  rider != null && rider.totalRatings > 0
                      ? '(${rider.totalRatings} rides)'
                      : '(No ratings)',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ActivityController.instance.selectedIndex.value == 0
          ? Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => UserChattingScreen());
                  },
                  child: circleActionMod(
                    Image.asset(
                      'assets/images/user_msg.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    Get.to(() => UserOutgoingCallScreen());
                  },
                  child: circleActionMod(
                    Image.asset(
                      'assets/images/user_call.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ],
            )
          : ActivityController.instance.selectedIndex.value == 1
              ? Column(
                  children: [
                    CommonText(
                      text: "Dec 23",
                      color: AppColors.green500,
                    ),
                    CommonText(
                      text: "10:00 PM",
                      color: AppColors.gray300,
                      fontSize: 14,
                    ),
                  ],
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.green500,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.green100),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const CommonText(
                    text: "Completed",
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
    ],
  );
}

Widget userRowModClick() {
  return userSectionWidget(rider: null);
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