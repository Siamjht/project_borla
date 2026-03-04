
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_borla/screens/activity-screens/schedule_screen_copy.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/gradient_scaffold_copy.dart';
import 'activity-controller/activity_controller_copy.dart';
import 'activity-widgets/job_tabbar_copy.dart';
import 'history_screen_copy.dart';

import 'ongoing_screen_copy.dart';


class UserActivityScreen extends StatelessWidget {
  UserActivityScreen({super.key});

  final UserActivityController activityController = Get.put(UserActivityController());

  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(
      child: SafeArea(
        child: Column(
          children: [
            CommonText(
              text: "Activity",
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