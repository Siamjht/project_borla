import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/profileController/profile_controller.dart';
import 'package:project_borla/controllers/user-controllers/booking_controller.dart';
import 'package:project_borla/role/components/image/shimmer_image_loader.dart';
import 'package:project_borla/screens/home-screens/user_nav_bar.dart';
import '../../../theme/app_color.dart';
import '../../bottom-sheets/current_location_sheet.dart';
import '../../bottom-sheets/search_location_sheet.dart';
import '../../gen/custom_assets/assets.gen.dart';
import '../../theme/custom_container_copy.dart';
import '../map-screens/user_common_map.dart';
import '../search-place-screens/location_search_screen_two.dart';

class HomeMapScreen extends StatefulWidget {
  HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {

  final UserNavBarController userNavBarController = Get.find<UserNavBarController>();
  final ProfileController _profileCtl = Get.find<ProfileController>();
  final _bookingCtrl = Get.put(BookingController());

  final ValueNotifier<double> sheetExtent = ValueNotifier(0.2);


  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _bookingCtrl.fetchCurrentLocation();
      _profileCtl.getProfile();
    },);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: [
          /// MAP
          Positioned.fill(
            child: UserCommonMap(),
          ),

          /// TOP CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      userNavBarController.tabIndex.value = 3;
                      Get.to(() => UserNavBar());
                    },
                    child: Obx(() => ShimmerImageLoader(borderRadius: 50,url: _profileCtl.profile.value.profilePicture, width: 60, height: 60),),
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
          ),

          // ValueListenableBuilder<double>(
          //   valueListenable: sheetExtent,
          //   builder: (_, extent, __) {
          //     final sheetTop = screenHeight * (1 - extent);
          //     const fabGap = 130.0; // keep this logical again
          //
          //     return Positioned(
          //       right: 16,
          //       top: sheetTop - 56 - fabGap,
          //       child: FloatingActionButton(
          //         backgroundColor: Colors.amber,
          //         //hoverColor: Colors.red,
          //         onPressed: () {},
          //         child: Image.asset('assets/images/target_2.png', scale: 3.5),
          //       ),
          //     );
          //   },
          // ),

          DraggableScrollableSheet(
            initialChildSize: 0.35,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  sheetExtent.value = notification.extent;
                  return false;
                },
                child: SizedBox.expand(
                  child: Obx(
                        () => AnimatedSwitcher(
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
                      child: _bookingCtrl.showSearchSheet.value
                          ? SearchLocationSheet(
                        key: const ValueKey('search'),
                      )
                          : CurrentLocationSheet(
                        key: const ValueKey('current'),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}



