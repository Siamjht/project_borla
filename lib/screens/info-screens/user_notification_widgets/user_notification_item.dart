import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_borla/models/commonModels/notificationModel/notification_model.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../role/components/text/common_text.dart';

/// User-specific notification item with orange/amber theme
class UserNotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const UserNotificationItem({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: notification.isRead ? Colors.transparent : AppColors.orange20,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon based on notification type
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColors.orange50,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.orange150, width: 1.5),
                ),
                child: Center(
                  child: _getNotificationIcon(),
                ),
              ),

              SizedBox(width: 16.w),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      textAlign: TextAlign.left,
                      text: notification.title,
                      fontSize: 14,
                      fontWeight: notification.isRead ? FontWeight.w400 : FontWeight.w600,
                      color: notification.isRead ? AppColors.gray500 : AppColors.black500,
                      lineHeight: 1.4,
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      textAlign: TextAlign.left,
                      text: notification.message,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray400,
                      lineHeight: 1.4,
                      maxLines: 2,
                    ),
                    SizedBox(height: 6.h),
                    CommonText(
                      text: _formatTime(notification.createdAt),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray300,
                    ),
                  ],
                ),
              ),

              // Unread dot indicator
              if (!notification.isRead)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 6),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.orange200,
                          AppColors.orange500,
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getNotificationIcon() {
    IconData iconData;
    Color iconColor;

    switch (notification.type) {
      case NotificationType.bookingCompleted:
        iconData = Icons.check_circle_outline;
        iconColor = AppColors.orange300;
        break;
      case NotificationType.bookingHeadingToStation:
        iconData = Icons.local_shipping;
        iconColor = AppColors.orange300;
        break;
      case NotificationType.bookingPaymentCollected:
      case NotificationType.bookingPaymentInitiated:
        iconData = Icons.account_balance_wallet_outlined;
        iconColor = AppColors.orange500;
        break;
      case NotificationType.riderArrivedPickup:
        iconData = Icons.location_on;
        iconColor = AppColors.orange300;
        break;
      case NotificationType.bookingAccepted:
        iconData = Icons.thumb_up_alt_outlined;
        iconColor = AppColors.orange300;
        break;
      case NotificationType.bookingCancelled:
        iconData = Icons.cancel_outlined;
        iconColor = AppColors.red200;
        break;
      default:
        iconData = Icons.notifications_outlined;
        iconColor = AppColors.orange300;
    }

    return Icon(
      iconData,
      size: 22,
      color: iconColor,
    );
  }

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    // If less than 1 minute ago
    if (diff.inSeconds < 60) {
      return 'Just now';
    }

    // If less than 1 hour ago
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    }

    // If less than 24 hours ago
    if (diff.inHours < 24) {
      final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
      final minute = date.minute.toString().padLeft(2, '0');
      final period = date.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    }

    // If less than 7 days ago
    if (diff.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[date.weekday - 1];
    }

    // Older than 7 days
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day/$month/$year';
  }
}
