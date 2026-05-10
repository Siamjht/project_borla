
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/gradient_scafold.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/role/garbageCollector/activity/controller/activity_controller.dart';
import 'package:project_borla/role/garbageCollector/activity/history_screen.dart';
import 'package:project_borla/role/garbageCollector/activity/ongoing_screen.dart';
import 'package:project_borla/theme/app_color.dart';
import 'innerWidget/job_tabbar.dart';
import 'schedule_screen.dart';

class ActivityScreen extends StatefulWidget {
  ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final ActivityController activityController =
  Get.find<ActivityController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ✅ fetch first tab on init
      activityController.fetchOngoing();

      // ✅ refetch when tab changes
      ever(activityController.selectedIndex, (int index) {
        switch (index) {
          case 0:
            activityController.fetchOngoing();
            break;
          case 1:
            activityController.fetchScheduled();
            break;
          case 2:
            activityController.fetchHistory();
            break;
        }
      });
    });
  }

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
            const SizedBox(height: 20),
            JobsTabBar(),

            Expanded(
              child: Obx(() => AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                // ✅ no fetch calls here
                child: _buildTabContent(
                  activityController.selectedIndex.value,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ only return widgets — no fetch calls
  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return OngoingScreen(key: const ValueKey(0));
      case 1:
        return const ScheduleScreen(key: ValueKey(1));
      case 2:
        return const HistoryScreen(key: ValueKey(2));
      default:
        return const SizedBox();
    }
  }
}

