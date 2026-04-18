import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/screens/info-screens/user_notification_widgets/user_notification_item.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../controllers/notificationController/notification_controller.dart';
import '../../models/commonModels/notificationModel/notification_model.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/common_back_button_copy.dart';
import '../../theme/gradient_scaffold_copy.dart';


class UserNotificationScreen extends StatelessWidget {
  final bool isFromProfile;
  const UserNotificationScreen({super.key, this.isFromProfile = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return UserGradientScaffold(
      child: SafeArea(
        child: Column(
          children: [
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isFromProfile? CommonBackButton() : SizedBox.shrink(),
                  Center(
                    child: CommonText(
                      text: 'Notifications',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: isFromProfile? 50 : 0,)
                ],
              ),
            ),
            
            // ── Mark all as read ──────────────────────────────────────
            Obx(() {
              final hasUnread = controller.unreadCount.value > 0;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: hasUnread ? () => controller.markAllAsRead() : null,
                    child: CommonText(
                      text: 'Mark all as read',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: hasUnread ? AppColors.orange300 : AppColors.gray400,
                    ),
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
                        ElevatedButton(
                          onPressed: () => controller.fetchNotifications(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orange300,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const CommonText(
                            text: 'Retry',
                            fontSize: 16,
                            color: Colors.white,
                          ),
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
                        Icon(
                          Icons.notifications_off_outlined,
                          size: 64,
                          color: AppColors.orange150,
                        ),
                        12.verticalSpace,
                        CommonText(
                          text: 'No notifications yet',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gray500,
                        ),
                        8.verticalSpace,
                        const CommonText(
                          text: 'We\'ll notify you when something arrives',
                          fontSize: 14,
                          color: AppColors.gray300,
                        ),
                      ],
                    ),
                  );
                }
        
                // Group notifications by date
                final grouped = _groupByDate(controller.notifications);
        
                return RefreshIndicator(
                  onRefresh: () => controller.fetchNotifications(isRefresh: true),
                  child: ListView.builder(
                    controller: controller.scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: grouped.length + 1,
                    itemBuilder: (context, index) {
                      // Pagination loader at bottom
                      if (index == grouped.length) {
                        return Obx(() => controller.isPaginationLoading.value
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: const Center(child: CircularProgressIndicator()),
                              )
                            : const SizedBox.shrink());
                      }
        
                      final section = grouped[index];
                      final sectionLabel = section['label'] as String;
                      final items = section['items'] as List<NotificationModel>;
        
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index != 0)
                            Divider(color: AppColors.gray150, height: 24.h),
                          SectionHeader(title: sectionLabel),
                          12.verticalSpace,
                          ...items.map((notification) => UserNotificationItem(
                                notification: notification,
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

  // ── Handle tap based on notification type ───────────────────────────────
  Future<void> _handleNotificationTap(
      BuildContext context,
      NotificationController controller,
      NotificationModel notification,
      ) async {
    // Mark as read
    if (!notification.isRead) {
      await controller.markAsRead(notification.id);
    }

    // Route based on type
    switch (notification.type) {
      case NotificationType.bookingCompleted:
      case NotificationType.bookingHeadingToStation:
      case NotificationType.bookingPaymentCollected:
      case NotificationType.bookingPaymentInitiated:
      case NotificationType.riderArrivedPickup:
      case NotificationType.bookingAccepted:
        // Navigate to booking detail if bookingId exists
        if (notification.bookingId != null) {
          // Get.to(() => UserBookingDetailScreen(bookingId: notification.bookingId!));
        }
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
