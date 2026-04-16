
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';
import 'package:project_borla/role/garbageCollector/home/innerWidget/customer_info_bottom_sheet.dart';
import 'package:project_borla/role/garbageCollector/map/driver_common_map.dart';

import '../../../controllers/mapController/driver_map_controller.dart';
import '../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../activity/controller/activity_controller.dart';
import 'controller/driver_home_controller.dart';

class CustomerInfoScreen extends StatelessWidget {
  RiderBookingModel booking;
  CustomerInfoScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final DriverMapController mapCtrl = Get.find<DriverMapController>();
    final DriverHomeController homeCtrl = Get.find<DriverHomeController>();

    // start route to pickup when screen opens
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapCtrl.startToPickupPhase(
          LatLng(booking.pickupLatitude, booking.pickupLongitude),
        );
      });

    return Scaffold(
      body: Stack(
        children: [
          /// Google Map — now shows route to pickup
          Positioned.fill(child: DriverCommonMap()),

          Positioned(
            top: 60,
            left: 20,
            child: CommonBackButton(onPressed: () {
              mapCtrl.endTrip();
              Get.back();
            },),
          ),

          /// BottomSheet
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomerInfoBottomSheet(booking: booking),
          ),
        ],
      ),
    );
  }
}
