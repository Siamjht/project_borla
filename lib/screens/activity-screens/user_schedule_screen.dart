
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/image/common_image.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'activity-controller/user_activity_controller.dart';
import 'activity-widgets/user_job_activity_card.dart';


class UserScheduleScreen extends StatelessWidget {
  const UserScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<UserActivityController>();

    return Obx(() {
      if (ctrl.isScheduleLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (ctrl.scheduledBookings.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonImage(
              height: 250,
              width: 250,
              imageSrc: 'assets/images/scheduleImg.png',
              imageType: ImageType.png,
            ),
            const CommonText(text: 'No scheduled rides yet', fontSize: 18),
          ],
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: ctrl.scheduledBookings.length,
        itemBuilder: (context, index) {
          final booking = ctrl.scheduledBookings[index];
          return UserActivityCard(
            key: ValueKey(booking.id),
            booking: booking,
            isDetailScreen: true,
          );
        },
      );
    });
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     CommonImage(
    //       height: 250,
    //       width: 250,
    //       imageSrc: "assets/images/scheduleImg.png",
    //       imageType: ImageType.png,
    //     ),
    //     CommonText(text: "No scheduled rides yet", fontSize: 18,)
    //   ],
    // );
  }
}