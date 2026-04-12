
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'activity-controller/user_activity_controller.dart';
import 'activity-widgets/user_job_activity_card.dart';


class UserOngoingScreen extends StatelessWidget {
  const UserOngoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<UserActivityController>();

    return Obx(() {
      if (ctrl.isOngoingLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (ctrl.ongoingBookings.isEmpty) {
        return Center(
          child: CommonText(text: 'No ongoing bookings', fontSize: 16),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: ctrl.ongoingBookings.length,
        itemBuilder: (context, index) {
          final booking = ctrl.ongoingBookings[index];
          return UserActivityCard(
            key: ValueKey(booking.id),
            booking: booking,
            isDetailScreen: true,
          );
        },
      );
    });
  }
}