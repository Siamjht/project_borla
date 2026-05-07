import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/screens/activity-screens/user_activity_screen.dart';
import 'package:project_borla/screens/home-screens/home_map_screen.dart';
import 'package:project_borla/screens/info-screens/user_notification_screen.dart';
import 'package:project_borla/screens/profile-screens/profile_screen_user.dart';

import '../../features/fragments/bottom_nav_bar.dart';

class UserNavBarController extends GetxController {
  static UserNavBarController get instance => Get.find<UserNavBarController>();
  var tabIndex = 0.obs;

  void changeTab(int index) {
    tabIndex.value = index;
  }
}

class UserNavBar extends StatelessWidget {
  UserNavBar({super.key});

  final UserNavBarController controller = Get.find<UserNavBarController>();

  final List<Widget> widgetOptions = [
    HomeMapScreen(),
    UserActivityScreen(),
    UserNotificationScreen(isFromProfile: false,),
    ProfileScreenUser(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        body: widgetOptions[controller.tabIndex.value],
        bottomNavigationBar: bttmNavBar(
          controller.tabIndex.value,
          controller.changeTab,
          context,
        ),
      ),
    );
  }
}

