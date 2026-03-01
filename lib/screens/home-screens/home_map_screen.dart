import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/screens/home-screens/user-home-screens/user-controller/user_home_controller.dart';
import 'package:project_borla/screens/home-screens/user_nav_bar.dart';
import 'package:project_borla/utils/app_texts.dart';
import '../../../theme/app_color.dart';
import '../../bottom-sheets/current_location_sheet.dart';
import '../../bottom-sheets/search_location_sheet.dart';
import '../../gen/custom_assets/assets.gen.dart';
import '../../theme/custom_container_copy.dart';
import '../map-screens/common_map_copy.dart';
import '../search-place-screens/location_search_screen_two.dart';

class HomeMapScreen extends StatefulWidget {
  HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  final UserHomeController controller =
  Get.put(UserHomeController());
  UserNavBarController userNavBarController = Get.put(UserNavBarController());

  final ValueNotifier<double> sheetExtent = ValueNotifier(0.2);

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          /// MAP
          Positioned.fill(
            child: UserCommonMap(),
          ),

          /// TOP CONTENT
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          userNavBarController.tabIndex.value = 3;
                          Get.to(() => UserNavBar());
                        },
                        child: CircleAvatar(
                          radius: 32,
                          backgroundImage:
                          NetworkImage(AppTexts.userProfilePic),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Get.to(() => LocationSearchScreenTwo()),
                        child: CustomContainer(
                          color: AppColors.white,
                          borderRadius: 100,
                          padding: const EdgeInsets.all(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black50,
                              blurRadius: 10,
                              spreadRadius: 5,
                              offset: const Offset(10, 7),
                            )
                          ],
                          child: Assets.icons.searchIcon
                              .image(height: 20, width: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ValueListenableBuilder<double>(
            valueListenable: sheetExtent,
            builder: (_, extent, __) {
              final sheetTop = screenHeight * (1 - extent);
              const fabGap = 130.0; // keep this logical again

              return Positioned(
                right: 16,
                top: sheetTop - 80 - fabGap,
                child: FloatingActionButton(
                  backgroundColor: Colors.amber,
                  //hoverColor: Colors.red,
                  onPressed: () {},
                  child: Image.asset('assets/images/target_2.png', scale: 3.5),
                ),
              );
            },
          ),

          Obx(()=>DraggableScrollableSheet(
            // initialChildSize: 0.25,
            // minChildSize: 0.25,
            // maxChildSize: 0.7,
            ///
            initialChildSize: controller.showSearchSheet.value ? 0.22 : 0.28,
            minChildSize:      controller.showSearchSheet.value ? 0.18 : 0.25,
            ///
            // initialChildSize: 0.28,
            // minChildSize: 0.25,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  sheetExtent.value = notification.extent;
                  return false;
                },
                child: SizedBox.expand(
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: controller.showSearchSheet.value
                          ? SearchLocationSheet(
                        key: const ValueKey('search'),
                      )
                          : CurrentLocationSheet(
                        key: const ValueKey('current'),
                      ),
                    ),

                ),
              );
            },
          ),
          ),



        ],
      ),
    );
  }
}

// class _AnimatedFAB extends StatelessWidget {
//   const _AnimatedFAB();
//
//   @override
//   Widget build(BuildContext context) {
//     final bottomInset = MediaQuery.of(context).viewInsets.bottom;
//
//     return AnimatedPadding(
//       duration: const Duration(milliseconds: 250),
//       curve: Curves.easeOut,
//       padding: EdgeInsets.only(
//         bottom: bottomInset + 16,
//       ),
//       child: FloatingActionButton(
//         onPressed: () {
//           // showModalBottomSheet(
//           //   context: context,
//           //   isScrollControlled: true,
//           //   builder: (_) => const SearchLocationSheet(),
//           // );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }


