
// driver_map_controller.dart
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_borla/map_key.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../role/garbageCollector/home/controller/driver_home_controller.dart';
import 'base_map_controller.dart';

/// Driver phases:
/// 1. idle       — driver browsing, just show their location
/// 2. toPickup   — request accepted, routing to user pickup point
/// 3. onTrip     — picked up user, routing to destination
enum DriverTripPhase { idle, toPickup, onTrip }

class DriverMapController extends BaseMapController {
  static DriverMapController get instance => Get.find<DriverMapController>();

  // ── State ─────────────────────────────────────────────────────
  final Rx<DriverTripPhase> tripPhase = DriverTripPhase.idle.obs;
  final Rx<LatLng> targetPosition = const LatLng(0, 0).obs;

  // ── Route State ───────────────────────────────────────────────
  List<LatLng> _remainingRoutePoints = [];
  LatLng _firstStepEnd = const LatLng(0, 0);

  // =============================================================

  @override
  void onInit() {
    super.onInit();
    ever(currentLocation, (LatLng loc) async {
      if (loc.latitude != 0 || loc.longitude != 0) {
        await mapCompleter.future;
        await animateCameraTo(loc);       // move camera first so marker is visible immediately
        await _placeDriverSelfMarker(loc);

        // Keep route updated as driver moves
        if (tripPhase.value != DriverTripPhase.idle) {
          await _fetchAndDrawRoute(origin: loc);
        }

        // if (Get.isRegistered<DriverHomeController>()) {
        //   Get.find<DriverHomeController>().updateDriverPosition(loc);
        // }
      }
    });
  }

  // =============================================================
  // ── Public API
  // =============================================================

  /// Phase 2 — accepted request, go to pickup point
  Future<void> startToPickupPhase(LatLng pickupPoint) async {
    tripPhase.value = DriverTripPhase.toPickup;
    _remainingRoutePoints = [];
    targetPosition.value = pickupPoint;

    // Place pickup marker
    await placeMarker(
      id: 'pickup',
      position: pickupPoint,
      iconPath: Assets.icons.locationCirclePointer.path,
      iconWidthPx: 60,
      color: AppColors.green500,
    );

    await _fetchAndDrawRoute(origin: currentLocation.value);
  }

  /// Phase 3 — picked up user, go to destination
  Future<void> startOnTripPhase(LatLng destination) async {
    tripPhase.value = DriverTripPhase.onTrip;
    _remainingRoutePoints = [];
    targetPosition.value = destination;

    removeMarker('pickup');

    // Place destination marker
    await placeMarker(
      id: 'destination',
      position: destination,
      iconPath: Assets.icons.location.path,
      iconWidthPx: 80,
      color: AppColors.green500,
    );

    await _fetchAndDrawRoute(origin: currentLocation.value);
  }

  /// Call when trip ends
  void endTrip() {
    tripPhase.value = DriverTripPhase.idle;
    _remainingRoutePoints = [];
    removeMarker('destination');
    removeMarker('pickup');
    clearRoute();
  }

  // =============================================================
  // ── Route
  // =============================================================

  Future<void> _fetchAndDrawRoute({required LatLng origin}) async {
    final destination = targetPosition.value;
    if (destination.latitude == 0 && destination.longitude == 0) return;

    final uri = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
          '?origin=${origin.latitude},${origin.longitude}'
          '&destination=${destination.latitude},${destination.longitude}'
          '&key=${MapApiKey.mapKey.trim()}',
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      log('[DriverMapController] Directions API error: ${response.body}');
      return;
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final routes = data['routes'] as List?;
    if (routes == null || routes.isEmpty) {
      log('[DriverMapController] No routes found.');
      return;
    }

    final overviewPolyline =
    routes[0]['overview_polyline']['points'] as String;
    final fullRoutePoints = decodePolyline(overviewPolyline);

    final firstStepEnd =
    routes[0]['legs'][0]['steps'][0]['end_location'] as Map;
    _firstStepEnd = LatLng(
      (firstStepEnd['lat'] as num).toDouble(),
      (firstStepEnd['lng'] as num).toDouble(),
    );

    if (_remainingRoutePoints.isEmpty) {
      _remainingRoutePoints = List.from(fullRoutePoints);
    }

    _redrawPolyline();
    _placeDriverSelfMarker(origin);
  }

  // =============================================================
  // ── Markers
  // =============================================================

  Future<void> _placeDriverSelfMarker(LatLng position) async {
    log("Driver position: $position");
    await placeMarker(
      id: 'driver_self',
      position: position,
      iconPath: "assets/icons/driverIconWithDottedCircle.png",
      rotation: calculateBearing(position, _firstStepEnd),
      color: AppColors.green500,
      iconWidthPx: 80,
    );
  }

  // =============================================================
  // ── Polyline
  // =============================================================

  void _trimPolylineTo(LatLng currentPosition) {
    const double proximityThreshold = 0.0001;
    while (_remainingRoutePoints.isNotEmpty &&
        distanceBetween(_remainingRoutePoints.first, currentPosition)<
    proximityThreshold) {
      _remainingRoutePoints.removeAt(0);
    }
    _redrawPolyline();
  }

  void _redrawPolyline() {
    polyLines.clear();
    polyLines.add(Polyline(
      polylineId: const PolylineId('route'),
      points: List.from(_remainingRoutePoints),
      color: Colors.black,
      width: 5,
    ));
  }
}