
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../../components/text/common_text.dart';

/// Single notification item
class NotificationItem extends StatelessWidget {
  final String title;
  final String time;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationItem({
    super.key,
    required this.title,
    required this.time,
    this.isRead = false,
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
              // Bell Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gray150)
                ),
                child: Center(
                  child: Assets.icons.notification.image(
                    height: 20,
                    width: 20,
                    color: AppColors.green50,
                  ),
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
                      text: title,
                      fontSize: 12,
                      fontWeight: isRead ? FontWeight.w400 : FontWeight.w600,
                      color: isRead ? AppColors.gray500 : AppColors.black500,
                      lineHeight: 1.4,
                    ),
                    SizedBox(height: 6.h),
                    CommonText(
                      text: time,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500]!,
                    ),
                  ],
                ),
              ),

              // Unread dot indicator
              if (!isRead)
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
}
