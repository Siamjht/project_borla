

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'activity-controller/user_activity_controller.dart';
import 'activity-widgets/user_job_activity_card.dart';

class UserHistoryScreen extends StatelessWidget {
  const UserHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<UserActivityController>();

    return Obx(() {
      if (ctrl.isHistoryLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (ctrl.historyBookings.isEmpty) {
        return Center(
          child: CommonText(text: 'No completed bookings', fontSize: 16),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: ctrl.historyBookings.length,
        itemBuilder: (context, index) {
          final booking = ctrl.historyBookings[index];
          return UserActivityCard(
            key: ValueKey(booking.id),
            booking: booking,
            isDetailScreen: false,
          );
        },
      );
    });
  }
}
