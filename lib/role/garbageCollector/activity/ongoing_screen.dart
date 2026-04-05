
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/text/common_text.dart';
import 'controller/activity_controller.dart';
import 'innerWidget/job_activity_card.dart';

class OngoingScreen extends StatelessWidget {
  const OngoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ActivityController>();

    return Obx(() {
      if (ctrl.isOngoingLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (ctrl.ongoingBookings.isEmpty) {
        return Center(
          child: CommonText(text: 'no_ongoing_bookings'.tr, fontSize: 16),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: ctrl.ongoingBookings.length,
        itemBuilder: (context, index) {
          final booking = ctrl.ongoingBookings[index];
          return ActivityCard(
            key: ValueKey(booking.id),
            booking: booking,
            isDetailScreen: true,
          );
        },
      );
    });
  }
}