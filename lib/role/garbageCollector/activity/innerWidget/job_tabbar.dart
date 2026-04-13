import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/theme/app_color.dart';

import '../controller/activity_controller.dart';

class JobsTabBar extends StatelessWidget {
  JobsTabBar({super.key});

  final ActivityController controller = Get.find<ActivityController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 8,
        children: [
          _buildTab(0, Icons.refresh_rounded, 'ongoing'.tr),
          _buildTab(1, Icons.calendar_today_outlined, 'schedule'.tr),
          _buildTab(2, Icons.history_rounded, 'history'.tr),
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
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: index == 1? 2:0),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.primaryColor,
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
                      : AppColors.primaryColor,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : AppColors.textColor,
                    ),
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
