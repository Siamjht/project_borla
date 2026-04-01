


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controllers/mapController/driver_map_controller.dart';

class DriverCommonMap extends StatelessWidget {
  DriverCommonMap({super.key});

  final _driverMapController = Get.find<DriverMapController>();

  @override
  Widget build(BuildContext context) {
    // initialCameraPosition must be outside Obx — accessing currentLocation.value
    // inside Obx would register a location dependency, causing a rebuild with 0
    // markers every time the location changes (before the bitmap finishes loading).
    final initialPosition = _driverMapController.initialCameraPosition;

    return Obx(() {
      final markers = _driverMapController.markers.toSet();
      final polyLines = _driverMapController.polyLines.toSet();

      log("🗺️ Obx rebuild — markers count: ${markers.length}");

      return GoogleMap(
        initialCameraPosition: initialPosition,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        markers: markers,       // ✅ use local variable
        polylines: polyLines,   // ✅ use local variable
        onMapCreated: _driverMapController.onMapCreated,
        onCameraMove: _driverMapController.onCameraMove,
      );
    });
  }
}