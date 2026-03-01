import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_borla/theme/gradient_scaffold_copy.dart';

import '../../role/components/commonBackButton/common_back_button.dart';
import '../../theme/common_back_button_copy.dart';
import '../../theme/common_text_two.dart';

class NotificationsScreenCopy extends StatelessWidget {
  bool isFromProfile;
  NotificationsScreenCopy({super.key, this.isFromProfile = false});

  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(
        child: SafeArea(
      child: Column(
        children: [
          SizedBox(height: 36,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
          // Mark all as read link
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Mark all as read
                },
                child: const CommonText(
                  text: 'Mark all as read',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
               Align(
                   alignment: Alignment.topLeft,
                   child: SectionHeader(title: 'TODAY')
               ),
                SizedBox(height: 14,),
                NotificationItem(
                  title:
                  'Your account has been verified. You can now go online and accept Borla pick ups.',
                  time: '11:00 AM',
                ),
                NotificationItem(
                  title:
                  'You have a new pickup request 1.2 km away. Review and accept to start.',
                  time: '11:00 AM',
                ),
                NotificationItem(
                  title:
                  'You\'ve successfully accepted the pickup. Navigate to the customer location.',
                  time: '11:00 AM',
                ),
                NotificationItem(
                  title:
                  'Job completed successfully. Earnings have been added to your wallet.',
                  time: '11:00 AM',
                ),
                SizedBox(height: 6.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Divider(
                    height: 1,
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                ),
                SizedBox(height: 6.h),
                Align(
                    alignment: Alignment.topLeft,
                    child: SectionHeader(title: 'Yesterday'),
                ),
                SizedBox(height: 14,),

                NotificationItem(
                  title:
                  'Your account has been verified. You can now go online and accept jobs.',
                  time: '11:00 AM',
                ),
                NotificationItem(
                  title:
                  'You have a new pickup request 1.2 km away. Review and accept to start.',
                  time: '11:00 AM',
                ),
                NotificationItem(
                  title:
                  'You\'ve successfully accepted the pickup. Navigate to the customer location.',
                  time: '11:00 AM',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Divider(
                    height: 1,
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    ));
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

/// Single notification item
class NotificationItem extends StatelessWidget {
  final String title;
  final String time;
  const NotificationItem({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bell Icon
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.amber )
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Colors.amber,
              size: 24,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  textAlign: TextAlign.left,
                  text: title,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  lineHeight: 1.4,
                ),
                SizedBox(height: 8.h),
                CommonText(
                  text: time,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600]!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}