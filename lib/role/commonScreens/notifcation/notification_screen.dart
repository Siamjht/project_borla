import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';
import 'package:project_borla/role/components/gradient_scafold.dart';
import '../../../controllers/notificationController/notification_controller.dart';
import '../../../models/commonModels/notificationModel/notification_model.dart';
import '../../../theme/app_color.dart';
import '../../components/button/common_button.dart';
import '../../components/text/common_text.dart';
import 'widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return GradientScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonBackButton(),
                  CommonText(text: 'notifications'.tr, fontSize: 20,),
                  SizedBox(width: 30,)
                ],
              ),

              // ── Mark all as read ──────────────────────────────────────
              Obx(() {
                final hasUnread = controller.unreadCount > 0;
                return Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed:() {
                      controller.markAllAsRead();
                      hasUnread ? controller.markAllAsRead : null;
                    },
                    child: CommonText(
                      text: 'Mark all as read',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: hasUnread ? AppColors.green500 : AppColors.gray500,
                    ),
                  ),
                );
              }),

              // ── List ──────────────────────────────────────────────────
              Expanded(
                child: Obx(() {
                  // Loading state
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Error state
                  if (controller.hasError.value) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 48, color: AppColors.gray150),
                          12.verticalSpace,
                          const CommonText(
                            text: 'Failed to load notifications',
                            fontSize: 14,
                            color: AppColors.gray150,
                          ),
                          12.verticalSpace,
                          CommonButton(
                            onTap: () => controller.fetchNotifications(),
                            titleText: 'Retry',
                            buttonHeight: 42,
                          ),
                        ],
                      ),
                    );
                  }

                  // Empty state
                  if (controller.notifications.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.notifications_off_outlined,
                              size: 48, color: AppColors.gray150),
                          12.verticalSpace,
                          const CommonText(
                            text: 'No notifications yet',
                            fontSize: 14,
                            color: AppColors.gray200,
                          ),
                        ],
                      ),
                    );
                  }

                  // Group notifications by date
                  final grouped = _groupByDate(controller.notifications);

                  return RefreshIndicator(
                    onRefresh: () =>
                        controller.fetchNotifications(isRefresh: true),
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: grouped.length + 1, // +1 for pagination loader
                      itemBuilder: (context, index) {
                        // Pagination loader at bottom
                        if (index == grouped.length) {
                          return Obx(() =>
                          controller.isPaginationLoading.value
                              ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            child: const Center(
                                child:
                                CircularProgressIndicator()),
                          )
                              : const SizedBox.shrink());
                        }

                        final section = grouped[index];
                        final sectionLabel = section['label'] as String;
                        final items = section['items']
                        as List<NotificationModel>;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index != 0)
                              Divider(color: AppColors.gray150),
                            SectionHeader(title: sectionLabel),
                            12.verticalSpace,
                            ...items.map((notification) =>
                                NotificationItem(
                                  title: notification.message,
                                  time: _formatTime(notification.createdAt),
                                  isRead: notification.read,
                                  onTap: () => _handleNotificationTap(
                                    context,
                                    controller,
                                    notification,
                                  ),
                                )),
                          ],
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Group notifications into Today / Yesterday / older dates ─────────────
  List<Map<String, dynamic>> _groupByDate(
      List<NotificationModel> notifications) {
    final Map<String, List<NotificationModel>> grouped = {};

    for (final n in notifications) {
      final label = _dateLabel(n.createdAt);
      grouped.putIfAbsent(label, () => []).add(n);
    }

    return grouped.entries
        .map((e) => {'label': e.key, 'items': e.value})
        .toList();
  }

  String _dateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(date.year, date.month, date.day);

    if (d == today) return 'TODAY';
    if (d == today.subtract(const Duration(days: 1))) return 'YESTERDAY';
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  // ── Handle tap based on model_type ───────────────────────────────────────
  Future<void> _handleNotificationTap(
      BuildContext context,
      NotificationController controller,
      NotificationModel notification,
      ) async {
    // Mark as read
    if (!notification.read) {
      controller.markAsRead(notification.id);
    }

    // Route based on type
    switch (notification.modelType) {
      case NotificationModelType.joinRequest:
        controller.markAsRead(notification.id);
        break;
      default:
        break;
    }
  }
}


/// Section header widget
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 12.h),
      child: CommonText(
        text: title,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }
}


