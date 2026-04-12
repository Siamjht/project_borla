
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_borla/models/commonModels/notificationModel/notification_model.dart';
import '../../../../theme/app_color.dart';
import '../../../components/text/common_text.dart';

/// Single notification item
class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const NotificationItem({
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon based on notification type
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gray150)
                ),
                child: Center(
                  child: _getNotificationIcon(),
                ),
              ),

              SizedBox(width: 12.w),

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
                      color: AppColors.gray500,
                      lineHeight: 1.4,
                      maxLines: 2,
                    ),
                    SizedBox(height: 6.h),
                    CommonText(
                      text: _formatTime(notification.createdAt),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500]!,
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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.gray500,
                          AppColors.green500,
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
        iconColor = AppColors.green500;
        break;
      case NotificationType.bookingHeadingToStation:
        iconData = Icons.local_shipping;
        iconColor = AppColors.blue;
        break;
      case NotificationType.bookingPaymentCollected:
      case NotificationType.bookingPaymentInitiated:
        iconData = Icons.payment;
        iconColor = AppColors.orange300;
        break;
      case NotificationType.riderArrivedPickup:
        iconData = Icons.location_on;
        iconColor = AppColors.green500;
        break;
      case NotificationType.bookingAccepted:
        iconData = Icons.thumb_up;
        iconColor = AppColors.green500;
        break;
      case NotificationType.bookingCancelled:
        iconData = Icons.cancel_outlined;
        iconColor = AppColors.red500;
        break;
      default:
        iconData = Icons.notifications_outlined;
        iconColor = AppColors.green50;
    }

    return Icon(
      iconData,
      size: 20,
      color: iconColor,
    );
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
