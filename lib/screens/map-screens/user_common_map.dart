import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_borla/controllers/mapController/user_map_controller.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';
import 'package:project_borla/role/garbageCollector/map/controller/gmap_controller.dart';


class UserCommonMap extends StatefulWidget {
  final UserBookingModel? booking;

  const UserCommonMap({super.key, this.booking});

  @override
  State<UserCommonMap> createState() => _UserCommonMapState();
}

class _UserCommonMapState extends State<UserCommonMap> {
  final UserMapController controller = Get.find<UserMapController>();

  @override
  void initState() {
    super.initState();
    // Defer initialization until after the first build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeMapWithBooking();
    });
  }

  Future<void> _initializeMapWithBooking() async {
    final booking = widget.booking;
    if (booking == null) {
      debugPrint('[UserCommonMap] No booking data provided');
      return;
    }

    try {
      // Extract pickup location coordinates [longitude, latitude]
      final pickupLat = booking.pickupLocation.coordinates[1];
      final pickupLng = booking.pickupLocation.coordinates[0];
      final pickupPosition = LatLng(pickupLat, pickupLng);
      
      debugPrint('[UserCommonMap] Pickup position: ${pickupPosition.latitude}, ${pickupPosition.longitude}');
      
      // Check if rider (driver) is assigned and has location
      if (booking.rider.location.coordinates.isNotEmpty) {
        final driverLat = booking.rider.location.coordinates[1];
        final driverLng = booking.rider.location.coordinates[0];
        final driverPosition = LatLng(driverLat, driverLng);
        
        debugPrint('[UserCommonMap] Driver position: ${driverPosition.latitude}, ${driverPosition.longitude}');
        debugPrint('[UserCommonMap] Starting driver coming phase...');

        // Place user marker at pickup location first
        await controller.placeUserMarker(pickupPosition);
        
        // Start the driver coming phase (this will draw route and place driver marker)
        await controller.startDriverComingPhase(
          driverPosition: driverPosition,
          userPosition: pickupPosition,
        );
        
        debugPrint('[UserCommonMap] Route fetched and markers placed');
        
        // Animate camera to fit both driver and pickup locations
        await _animateCameraToBounds(driverPosition, pickupPosition);
        
      } else {
        // Just show pickup location marker
        debugPrint('[UserCommonMap] No driver assigned, showing pickup only');
        await controller.placeUserMarker(pickupPosition);
        await controller.animateCameraTo(pickupPosition);
      }
    } catch (e, stackTrace) {
      debugPrint('[UserCommonMap] Error initializing map: $e');
      debugPrint('[UserCommonMap] Stack trace: $stackTrace');
    }
  }
  
  /// Animate camera to show both driver and pickup locations
  Future<void> _animateCameraToBounds(LatLng driverPos, LatLng pickupPos) async {
    // Calculate bounds that include both positions with padding
    final bounds = LatLngBounds(
      southwest: LatLng(
        driverPos.latitude < pickupPos.latitude ? driverPos.latitude : pickupPos.latitude,
        driverPos.longitude < pickupPos.longitude ? driverPos.longitude : pickupPos.longitude,
      ),
      northeast: LatLng(
        driverPos.latitude > pickupPos.latitude ? driverPos.latitude : pickupPos.latitude,
        driverPos.longitude > pickupPos.longitude ? driverPos.longitude : pickupPos.longitude,
      ),
    );
    
    // Wait a bit for markers to be placed
    await Future.delayed(const Duration(milliseconds: 300));
    
    await controller.mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 100), // 100px padding
    );
    
    debugPrint('[UserCommonMap] Camera animated to fit both locations');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // access value inside Obx to register dependency
      final markers = Set<Marker>.from(controller.markers);
      final polyLines = Set<Polyline>.from(controller.polyLines);
      
      debugPrint('[UserCommonMap] Rebuilding - Markers: ${markers.length}, Polylines: ${polyLines.length}');

      return GoogleMap(
        initialCameraPosition: controller.initialCameraPosition,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        markers: markers,
        polylines: polyLines,
        onMapCreated: controller.onMapCreated,
        onCameraMove: controller.onCameraMove,
      );
    });
  }
}