
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/garbageCollector/activity/innerWidget/job_activity_card.dart';

import '../../components/image/common_image.dart';
import '../../components/text/common_text.dart';
import 'controller/activity_controller.dart';


class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ActivityController>();

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
            CommonText(text: 'no_scheduled_rides'.tr, fontSize: 18),
          ],
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: ctrl.scheduledBookings.length,
        itemBuilder: (context, index) {
          final booking = ctrl.scheduledBookings[index];
          return ActivityCard(
            key: ValueKey(booking.id),
            booking: booking,
            isDetailScreen: true,
            isActivityScreen: true,
          );
        },
      );
    });
  }
}
