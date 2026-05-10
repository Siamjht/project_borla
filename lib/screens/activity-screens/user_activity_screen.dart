
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
  final UserActivityController userActivityCtrl =
  Get.find<UserActivityController>();

  @override
  void initState() {
    super.initState();

    // ✅ fetch first tab on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userActivityCtrl.fetchPending();

      // ✅ refetch when tab changes
      ever(userActivityCtrl.selectedIndex, (int index) {
        switch (index) {
          case 0:
            userActivityCtrl.fetchPending();
            break;
          case 1:
            userActivityCtrl.fetchOngoing();
            break;
          case 2:
            userActivityCtrl.fetchScheduled();
            break;
          case 3:
            userActivityCtrl.fetchHistory();
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(
      child: SafeArea(
        child: Column(
          children: [
            20.verticalSpace,
            CommonText(
              text: 'Activity',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
            const SizedBox(height: 20),
            UserJobsTabBar(),

            Expanded(
              child: Obx(() => AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: _buildTabContent(
                  userActivityCtrl.selectedIndex.value,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ no fetch calls here — only return widgets
  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return UserPendingScreen(key: const ValueKey(0));
      case 1:
        return UserOngoingScreen(key: const ValueKey(1));
      case 2:
        return const UserScheduleScreen(key: ValueKey(2));
      case 3:
        return const UserHistoryScreen(key: ValueKey(3));
      default:
        return const SizedBox();
    }
  }
}