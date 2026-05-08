
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_borla/models/riderModels/bookingModels/rider_booking_model.dart';
import '../../../controllers/mapController/driver_map_controller.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../map/driver_common_map.dart';
import 'innerWidget/arrived_bottom_sheet.dart';

class ArrivedScreen extends StatelessWidget {
  final RiderBookingModel bookingModel;
  ArrivedScreen({super.key, required this.bookingModel});


  @override
  Widget build(BuildContext context) {
    final DriverMapController mapCtrl = Get.find<DriverMapController>();

    // start route to pickup when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapCtrl.startToPickupPhase(
        LatLng(bookingModel.pickupLatitude, bookingModel.pickupLongitude),
        id: bookingModel.id,
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

          /// BottomSheet
          Align(
            alignment: Alignment.bottomCenter,
            child: ArrivedBottomSheet(booking: bookingModel,),
          ),

        ],
      ),
    );
  }
}
