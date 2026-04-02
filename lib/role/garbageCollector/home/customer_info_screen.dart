
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
  const CustomerInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DriverMapController mapCtrl = Get.find<DriverMapController>();
    final DriverHomeController homeCtrl = Get.find<DriverHomeController>();

    // ✅ get booking from either source
    final booking = _getBooking();

    // ✅ start route to pickup when screen opens
    if (booking != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapCtrl.startToPickupPhase(
          LatLng(booking.pickupLatitude, booking.pickupLongitude),
        );
      });
    }

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
            child: CustomerInfoBottomSheet(booking: booking,),
          ),
        ],
      ),
    );
  }

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
}
