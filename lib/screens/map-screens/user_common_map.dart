import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_borla/role/garbageCollector/map/controller/gmap_controller.dart';


class UserCommonMap extends StatelessWidget {
  UserCommonMap({super.key});

  final GMapController controller = Get.find<GMapController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GoogleMap(
        initialCameraPosition: controller.initialCameraPosition,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        markers: controller.markers,
        polylines: controller.polyLines,
        onMapCreated: controller.onMapCreated,
        onCameraMove: controller.onCameraMove,
      ),
    );
  }
}