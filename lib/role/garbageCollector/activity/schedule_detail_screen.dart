
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';
import 'package:project_borla/role/components/image/common_image.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/role/garbageCollector/activity/innerWidget/job_activity_card.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../components/custom_container.dart';
import '../../components/gradient_scafold.dart';
import 'controller/activity_controller.dart';

class ScheduleDetailScreen extends StatelessWidget {
  const ScheduleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ActivityController>();
    final booking = ctrl.selectedBooking.value;

    if (booking == null) return const SizedBox.shrink();

    return GradientScaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CommonBackButton(),
        ),
        title: CommonText(
          text: 'Ride Details',
          color: AppColors.textDark,
          fontSize: 18,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            children: [

              // ── Schedule Banner ─────────────────────────
              CustomContainer(
                width: Get.width,
                height: 100,
                borderRadius: 8,
                borderColor: AppColors.green100,
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CommonText(
                            text: 'Ride scheduled!',
                            color: AppColors.green500,
                            fontSize: 20,
                          ),
                          CommonText(
                            // ✅ real scheduled date and time
                            text: _formatScheduledDate(booking.scheduledFor),
                            color: AppColors.gray300,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: CommonImage(
                        imageSrc: 'assets/images/patternLeft.png',
                        imageType: ImageType.png,
                        size: 70,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CommonImage(
                        imageSrc: 'assets/images/patternRight.png',
                        imageType: ImageType.png,
                        size: 80,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ✅ pass booking to ActivityCard
              ActivityCard(
                booking: booking,
                isDetailScreen: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatScheduledDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return 'Not scheduled';
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      final dayName = days[dt.weekday - 1];
      final month = months[dt.month - 1];
      final hour = dt.hour.toString().padLeft(2, '0');
      final minute = dt.minute.toString().padLeft(2, '0');
      return '$dayName, $month ${dt.day} - $hour:$minute';
    } catch (_) {
      return isoDate;
    }
  }
}
