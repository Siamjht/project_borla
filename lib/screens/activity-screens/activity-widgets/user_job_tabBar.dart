
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/theme/app_color.dart';

import '../activity-controller/user_activity_controller.dart';


class UserJobsTabBar extends StatelessWidget {
  UserJobsTabBar({super.key});

  final UserActivityController controller = Get.put(UserActivityController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          _buildTab(0, Icons.refresh_rounded, 'Ongoing'),
          const SizedBox(width: 12),
          _buildTab(1, Icons.calendar_today_outlined, 'Schedule'),
          const SizedBox(width: 12),
          _buildTab(2, Icons.history_rounded, 'History'),
        ],
      ),
    );
  }

  Widget _buildTab(int index, IconData icon, String label) {
    return Expanded(
      child: Obx(() {
        final bool isSelected =
            controller.selectedIndex.value == index;

        return GestureDetector(
          onTap: () => controller.changeTab(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.amber
                  : AppColors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.amber,
                width: isSelected ? 0 : 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isSelected
                      ? Colors.white
                      : Colors.amber,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
