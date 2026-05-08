
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/role/garbageCollector/home/arrived_screen.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../controllers/mapController/driver_map_controller.dart';
import '../../../gen/custom_assets/assets.gen.dart';
import '../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../map/driver_common_map.dart';


class NavigateDestinationScreen extends StatelessWidget {
  final RiderBookingModel booking;
  NavigateDestinationScreen({super.key, required this.booking});


  @override
  Widget build(BuildContext context) {
    final DriverMapController mapCtrl = Get.find<DriverMapController>();

    // start route to pickup when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapCtrl.startToPickupPhase(
        LatLng(booking.pickupLatitude, booking.pickupLongitude),
        id: booking.id,
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          /// Google Map
          Positioned.fill(child: DriverCommonMap()),

          Positioned(
            top: 60,
            left: 20,
            child: CommonBackButton(
              onPressed: () {
                mapCtrl.endTrip();
                Get.back();
              },
            ),
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
                      text: booking.pickupAddress, // ✅ real data
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
              onTap: (){
                Get.to(() => ArrivedScreen(bookingModel: booking));
                log("BookingId: ${booking.id}");
              },
              titleText: 'Navigate to Destination',
              buttonRadius: 12,
            ),
          ),
        ],
      ),
    );
  }
}
