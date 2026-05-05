

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'activity-controller/user_activity_controller.dart';
import 'activity-widgets/user_job_activity_card.dart';


class UserPendingScreen extends StatelessWidget {
  const UserPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<UserActivityController>();

    return Obx(() {
      if (ctrl.isPendingLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (ctrl.pendingBookings.isEmpty) {
        return Center(
          child: CommonText(text: 'No pending bookings', fontSize: 16),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: ctrl.pendingBookings.length,
        itemBuilder: (context, index) {
          final booking = ctrl.pendingBookings[index];
          return UserActivityCard(
            key: ValueKey(booking.id),
            booking: booking,
            isDetailScreen: false,
            isPending: true,
          );
        },
      );
    });
  }
}