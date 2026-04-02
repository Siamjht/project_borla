
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/role/garbageCollector/home/arrived_screen.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../gen/custom_assets/assets.gen.dart';
import '../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../activity/controller/activity_controller.dart';
import '../map/driver_common_map.dart';
import 'controller/driver_home_controller.dart';
import 'innerWidget/arrived_bottom_sheet.dart';

class NavigateDestinationScreen extends StatelessWidget {
  const NavigateDestinationScreen({super.key});

  RiderBookingModel? _getBooking() {
    final activityCtrl = Get.isRegistered<ActivityController>()
        ? Get.find<ActivityController>()
        : null;
    if (activityCtrl?.selectedBooking.value != null) {
      return activityCtrl!.selectedBooking.value;
    }

    final homeCtrl = Get.isRegistered<DriverHomeController>()
        ? Get.find<DriverHomeController>()
        : null;
    if (homeCtrl?.acceptedBooking.value != null) {
      final accepted = homeCtrl!.acceptedBooking.value!;
      return RiderBookingModel(
        id: accepted.id,
        pickupLatitude: accepted.pickupLatitude,
        pickupLongitude: accepted.pickupLongitude,
        pickupAddress: accepted.pickupAddress,
        dropoffAddress: accepted.dropoffAddress,
        price: accepted.price,
        estimatedDistance: accepted.estimatedDistance,
        estimatedTime: accepted.estimatedTime,
        paymentMethod: accepted.paymentMethod,
        user: accepted.user,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final booking = _getBooking();

    return Scaffold(
      body: Stack(
        children: [
          /// Google Map
          Positioned.fill(child: DriverCommonMap()),

          Positioned(
            top: 60,
            left: 20,
            child: CommonBackButton(),
          ),

          // ── Pickup Address Card ─────────────────────────
          Positioned(
            bottom: 120,
            left: 30,
            right: 30,
            child: CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              borderRadius: 8,
              child: Row(
                children: [
                  CustomContainer(
                    padding: const EdgeInsets.all(8),
                    borderRadius: 100,
                    color: AppColors.green50,
                    child: Center(
                      child: Assets.icons.locationPointer
                          .image(height: 20, width: 20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CommonText(
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w400,
                      text: booking?.pickupAddress ?? '—', // ✅ real data
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Navigate Button ─────────────────────────────
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: CommonButton(
              onTap: () => Get.to(() => ArrivedScreen()),
              titleText: 'Navigate to Destination',
              buttonRadius: 12,
            ),
          ),
        ],
      ),
    );
  }
}
