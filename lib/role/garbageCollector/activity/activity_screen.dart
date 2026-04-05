
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/gradient_scafold.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/role/garbageCollector/activity/controller/activity_controller.dart';
import 'package:project_borla/role/garbageCollector/activity/history_screen.dart';
import 'package:project_borla/role/garbageCollector/activity/ongoing_screen.dart';
import 'package:project_borla/theme/app_color.dart';

import 'innerWidget/job_activity_card.dart';
import 'innerWidget/job_tabbar.dart';
import 'schedule_screen.dart';

class ActivityScreen extends StatelessWidget {
  ActivityScreen({super.key});

  final ActivityController activityController =
  Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SafeArea(
        child: Column(
          children: [
            CommonText(
              text: 'activity'.tr,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
            SizedBox(height: 20,),
            JobsTabBar(),

            /// Animated content
            Expanded(
              child: Obx(
                    () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },

                  /// IMPORTANT: key changes when tab changes
                  child: _buildTabContent(
                    activityController.selectedIndex.value,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return OngoingScreen(key: ValueKey(0),);
      case 1:
        return const ScheduleScreen(key: ValueKey(1));
      case 2:
        return const HistoryScreen(key: ValueKey(2));
      default:
        return const SizedBox();
    }
  }
}

