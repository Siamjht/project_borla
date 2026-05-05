
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/screens/activity-screens/user_pending_screen.dart';

import 'package:project_borla/screens/activity-screens/user_schedule_screen.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/gradient_scaffold_copy.dart';
import 'activity-controller/user_activity_controller.dart';
import 'activity-widgets/user_job_tabBar.dart';
import 'user_history_screen.dart';

import 'user_ongoing_screen.dart';


class UserActivityScreen extends StatefulWidget {
  UserActivityScreen({super.key});

  @override
  State<UserActivityScreen> createState() => _UserActivityScreenState();
}

class _UserActivityScreenState extends State<UserActivityScreen> {
  final UserActivityController userActivityCtrl = Get.find<UserActivityController>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // userActivityCtrl.fetchPending();
    },);
  }
  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(
      child: SafeArea(
        child: Column(
          children: [
            20.verticalSpace,
            CommonText(
              text: "Activity",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
            SizedBox(height: 20,),
            UserJobsTabBar(),

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
                    userActivityCtrl.selectedIndex.value,
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
        userActivityCtrl.fetchPending();
        return UserPendingScreen(key: ValueKey(0),);
      case 1:
        userActivityCtrl.fetchOngoing();
        return UserOngoingScreen(key: ValueKey(0),);
      case 2:
        userActivityCtrl.fetchScheduled();
        return const UserScheduleScreen(key: ValueKey(1));
      case 3:
        userActivityCtrl.fetchHistory();
        return const UserHistoryScreen(key: ValueKey(2));
      default:
        return const SizedBox();
    }
  }
}