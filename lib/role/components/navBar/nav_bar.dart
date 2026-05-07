
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../gen/custom_assets/assets.gen.dart';
import 'controller/nav_bar_controller.dart';

class DriverNavbar extends StatelessWidget {
  DriverNavbar({super.key});

  final MainNavController controller = Get.find<MainNavController>();

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width / 4;

    return Scaffold(
      body: Obx(
            () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: controller.screens[controller.selectedIndex.value],
        ),
      ),

      bottomNavigationBar: Obx(
            () => Stack(
          children: [
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changeTab,
              items: [
                _navItem(Assets.icons.homeIcon.image(height: 22, width: 22), Assets.icons.homeSolidIcon.image(height: 22, width: 22), 0),
                _navItem(Assets.icons.activityIcon.image(height: 22, width: 22), Assets.icons.activitySolidIcon.image(height: 22, width: 22), 1),
                _navItem(Assets.icons.earningIcon.image(height: 24, width: 24), Assets.icons.earningSolidIcon.image(height: 24, width: 24), 2),
                _navItem(Assets.icons.profileIcon.image(height: 20, width: 20), Assets.icons.profileSolidIcon.image(height: 20, width: 20), 3),
              ],
            ),

            /// Top indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: 0,
              left: itemWidth * controller.selectedIndex.value,
              child: Container(
                width: itemWidth,
                height: 3,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem(
      Image outlineIcon,
      Image filledIcon,
      int index,
      ) {
    return BottomNavigationBarItem(
      icon: outlineIcon,
      activeIcon: filledIcon,
      label: controller.selectedIndex.value == index
          ? controller.labels[index]
          : '',
      tooltip: '',
    );
  }
}

