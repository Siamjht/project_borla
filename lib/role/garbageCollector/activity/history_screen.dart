
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/garbageCollector/activity/innerWidget/job_activity_card.dart';

import '../../components/text/common_text.dart';
import 'controller/activity_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ActivityController>();

    return Obx(() {
      if (ctrl.isHistoryLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (ctrl.historyBookings.isEmpty) {
        return Center(
          child: CommonText(text: 'no_completed_bookings'.tr, fontSize: 16),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: ctrl.historyBookings.length,
        itemBuilder: (context, index) {
          final booking = ctrl.historyBookings[index];
          return ActivityCard(
            key: ValueKey(booking.id),
            booking: booking,
            isDetailScreen: false,
            isActivityScreen: true,
          );
        },
      );
    });
  }
}
