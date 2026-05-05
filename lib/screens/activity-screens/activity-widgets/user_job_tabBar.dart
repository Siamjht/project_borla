
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/theme/app_color.dart';

import '../activity-controller/user_activity_controller.dart';

class UserJobsTabBar extends StatefulWidget {
  const UserJobsTabBar({super.key});

  @override
  State<UserJobsTabBar> createState() => _UserJobsTabBarState();
}

class _UserJobsTabBarState extends State<UserJobsTabBar> {
  final UserActivityController controller = Get.put(UserActivityController());
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          InkWell(
            onTap: _scrollLeft,
            child: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.amber,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTab(0, Icons.pending_outlined, 'pending'),
                  const SizedBox(width: 12),
                  _buildTab(1, Icons.refresh_rounded, 'Ongoing'),
                  const SizedBox(width: 12),
                  _buildTab(2, Icons.calendar_today_outlined, 'Schedule'),
                  const SizedBox(width: 12),
                  _buildTab(3, Icons.history_rounded, 'History'),
                ],
              ),
            ),
          ),
          4.horizontalSpace,
          InkWell(
            onTap: _scrollRight,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 24,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, IconData icon, String label) {
    return Obx(() {
      final bool isSelected = controller.selectedIndex.value == index;

      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.amber : AppColors.white,
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
                color: isSelected ? Colors.white : Colors.amber,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textColor,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
