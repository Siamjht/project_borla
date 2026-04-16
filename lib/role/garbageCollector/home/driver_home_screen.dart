
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:project_borla/gen/custom_assets/assets.gen.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/role/garbageCollector/home/innerWidget/job_request_card.dart';

import '../../../controllers/profileController/profile_controller.dart';
import '../../../theme/app_color.dart';
import '../../components/text/common_text.dart';
import '../map/driver_common_map.dart';
import 'controller/driver_home_controller.dart';
import 'innerWidget/application_review_dialog.dart';

class DriverHomeScreen extends StatefulWidget {
  DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  final ProfileController _profileCtl = Get.find<ProfileController>();
  final _driverHomeCtrl = Get.put(DriverHomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _profileCtl.getProfile();
      if(_profileCtl.profile.value.documents.isNotEmpty){
        if(_profileCtl.profile.value.documents.first.status == 'pending'){
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (_) => const ApplicationReviewDialog(),
          );
        }
      }
      _driverHomeCtrl.fetchCurrentLocation();
      _driverHomeCtrl.getAvailableBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    _driverHomeCtrl. showJobCards.value = true;
    return Scaffold(
      body: Stack(
        children: [
          /// Google Map
          Positioned.fill(child: DriverCommonMap()),

          /// Pulsing Marker Overlay
          // Obx(() {
          //   final screenPos = _driverHomeCtrl.screenPosition.value;
          //   if (screenPos == null) return const SizedBox();
          //
          //   return Positioned(
          //     left: screenPos.x.toDouble() - 40,
          //     top: screenPos.y.toDouble() - 40,
          //     child: const PulsingCircleWithIcon(),
          //   );
          // }),

          /// Top Status Card
          Positioned(
            top: 70,
            left: 20,
            right: 20,
            child: Obx(
                  () => CustomContainer(
                    borderRadius: 38,
                    color: AppColors.white,
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        CustomContainer(
                          height: 50,
                          width: 50,
                          borderRadius: 100,
                            color: _driverHomeCtrl.isOnline.value? AppColors.blue: AppColors.gray200,
                            child: Center(child: _driverHomeCtrl.isOnline.value? Assets.icons.daySunIcon.image(height: 30, width: 50) : Assets.icons.nightMoonIcon.image(height: 30, width: 50)),
                        ),

                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: _driverHomeCtrl.isOnline.value
                                  ? 'online'.tr
                                  : 'offline'.tr,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                            CommonText(
                              text: 'go_online_jobs'.tr,
                              fontSize: 12,
                              color: AppColors.gray300,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Spacer(),
                        Obx(() => _driverHomeCtrl.isToggleLoading.value
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.green500,
                          ),
                        )
                            : Switch(
                          value: _driverHomeCtrl.isOnline.value,
                          activeTrackColor: AppColors.green500,
                          activeThumbColor: AppColors.white,
                          inactiveThumbColor: AppColors.white,
                          inactiveTrackColor: AppColors.gray200,
                          onChanged: _driverHomeCtrl.isToggleLoading.value
                              ? null  // ✅ disable while loading
                              : _driverHomeCtrl.toggleOnline,
                        )),
                      ],
                    ),
                  ),
            ),
          ),

          // Positioned(
          //   top: 250,
          //   left: 30,
          //   right: 30,
          //   child: Obx(() {
          //     if (_driverHomeCtrl.jobRequests.isEmpty) return const SizedBox.shrink();
          //
          //     return Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //
          //         // ── Job counter indicator ─────────────────────────
          //         if (_driverHomeCtrl.jobRequests.length > 1)
          //           Padding(
          //             padding: const EdgeInsets.only(bottom: 8),
          //             child: Obx(() => Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: List.generate(
          //                 _driverHomeCtrl.jobRequests.length,
          //                     (index) => AnimatedContainer(
          //                   duration: const Duration(milliseconds: 300),
          //                   margin: const EdgeInsets.symmetric(horizontal: 4),
          //                   width: _driverHomeCtrl.currentJobIndex.value == index ? 16 : 8,
          //                   height: 8,
          //                   decoration: BoxDecoration(
          //                     color: _driverHomeCtrl.currentJobIndex.value == index
          //                         ? AppColors.green500
          //                         : AppColors.gray200,
          //                     borderRadius: BorderRadius.circular(4),
          //                   ),
          //                 ),
          //               ),
          //             )),
          //           ),
          //
          //         // ── Swipeable job cards ───────────────────────────
          //         SizedBox(
          //           height: MediaQuery.of(context).size.height * 0.52,
          //           child: CarouselSlider.builder(
          //             itemCount: _driverHomeCtrl.jobRequests.length,
          //             options: CarouselOptions(
          //               height: MediaQuery.of(context).size.height * 0.52,
          //               viewportFraction: 1,
          //               enlargeCenterPage: true,
          //               enlargeFactor: 0.2,
          //               enableInfiniteScroll: false,
          //               scrollPhysics: const BouncingScrollPhysics(),
          //               onPageChanged: (index, reason) {
          //                 _driverHomeCtrl.currentJobIndex.value = index;
          //               },
          //             ),
          //             itemBuilder: (context, index, realIndex) {
          //               final job = _driverHomeCtrl.jobRequests[index];
          //               return JobRequestCard(job: job);
          //             },
          //           ),
          //         ),
          //
          //       ],
          //     );
          //   }),
          // ),

          Positioned(
            top: 250,
            left: 30,
            right: 30,
            child: Obx(() {
              if (!_driverHomeCtrl.showJobCards.value ||
                  _driverHomeCtrl.jobRequests.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // ── Swipe able job cards ───────────────────────────
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.52,
                    child: CardSwiper(
                      key: ValueKey(_driverHomeCtrl.jobRequests.length),
                      controller: _driverHomeCtrl.cardSwiperController,
                      cardsCount: _driverHomeCtrl.jobRequests.length,
                      numberOfCardsDisplayed: _driverHomeCtrl.jobRequests.length.clamp(1, 5),
                      allowedSwipeDirection: const AllowedSwipeDirection.only(
                        left: true,
                        right: true,
                      ),
                      isLoop: true,
                      padding: EdgeInsets.zero,
                      scale: 0.95,
                      backCardOffset: const Offset(0, -20),
                      onSwipe: (previousIndex, currentIndex, direction) {
                        _driverHomeCtrl.currentJobIndex.value = currentIndex ?? previousIndex;

                        if (direction == CardSwiperDirection.right) {
                          // Accept job
                          // _driverHomeCtrl.onJobAccepted(_driverHomeCtrl.jobRequests[previousIndex]);
                        } else if (direction == CardSwiperDirection.left) {
                          // Decline job
                          // _driverHomeCtrl.onJobDeclined(_driverHomeCtrl.jobRequests[previousIndex]);
                        }
                        return true;
                      },
                      onEnd: () {
                        _driverHomeCtrl.currentJobIndex.value = 0;
                      },
                      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                        if (index >= _driverHomeCtrl.jobRequests.length) {
                          return const SizedBox.shrink();
                        }
                        final job = _driverHomeCtrl.jobRequests[index];
                        return JobRequestCard(job: job);
                      },
                    ),
                  ),

                  // ── Job counter indicator ─────────────────────────
                  if (_driverHomeCtrl.jobRequests.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _driverHomeCtrl.jobRequests.length,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _driverHomeCtrl.currentJobIndex.value == index ? 16 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _driverHomeCtrl.currentJobIndex.value == index
                                  ? AppColors.green500
                                  : AppColors.gray300,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      )),
                    ),

                ],
              );
            }),
          ),

          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Obx(() => _driverHomeCtrl.locationFetching.value
              ? Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.50),
              ),
              child: Center(child: CircularProgressIndicator())
          )
              : SizedBox.shrink()
          ),)
        ],
      ),
    );
  }
}


