
// driver_map_controller.dart
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_borla/map_key.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../models/riderModels/wasteStationModel/waste_station_model.dart';
import 'base_map_controller.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;


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

    // ✅ pickup marker with correct icon
    await placeMarker(
      id: 'pickup',
      position: pickupPoint,
      iconPath: 'assets/icons/pickUpLocation.png',
      iconWidthPx: 60,
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

    _showNearbyStations();
  }

  void _showNearbyStations() {
    // TODO: replace with real API data
    final stations = [
      WasteStationModel(
        id: '1',
        name: 'West Waste Station',
        latitude: 5.6050,
        longitude: -0.1890,
        distanceKm: 2.4,
      ),
      WasteStationModel(
        id: '2',
        name: 'East Waste Station',
        latitude: 5.6070,
        longitude: -0.1820,
        distanceKm: 2.5,
      ),
      WasteStationModel(
        id: '3',
        name: 'Central Waste Station',
        latitude: 5.6020,
        longitude: -0.1900,
        distanceKm: 2.3,
      ),
    ];

    Get.find<DriverMapController>().showNearbyStations(stations);
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
          '&mode=driving'        // ✅ driving mode
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

    // ✅ decode each step's polyline separately for accurate road-following
    final steps = routes[0]['legs'][0]['steps'] as List;
    final List<LatLng> fullRoutePoints = [];

    for (final step in steps) {
      final points = step['polyline']['points'] as String;
      fullRoutePoints.addAll(decodePolyline(points));
    }

    final firstStepEnd = routes[0]['legs'][0]['steps'][0]['end_location'] as Map;
    _firstStepEnd = LatLng(
      (firstStepEnd['lat'] as num).toDouble(),
      (firstStepEnd['lng'] as num).toDouble(),
    );

    if (_remainingRoutePoints.isEmpty) {
      _remainingRoutePoints = List.from(fullRoutePoints);
    }

    _redrawPolyline();
    await _placeDriverSelfMarker(origin);
  }

  // =============================================================
  // ── Markers
  // =============================================================

  Future<void> _placeDriverSelfMarker(LatLng position) async {
    log("Driver position: $position");

    // ✅ icon changes based on trip phase
    final iconPath = tripPhase.value == DriverTripPhase.idle
        ? 'assets/icons/driverIconWithDottedCircle.png'  // before accept
        : 'assets/icons/tryCycleIcon.png';               // after accept

    await placeMarker(
      id: 'driver_self',
      position: position,
      iconPath: iconPath,
      rotation: calculateBearing(position, _firstStepEnd),
      iconWidthPx: 60,
    );
  }

  Future<void> _drawRouteToStation(WasteStationModel station) async {
    final origin = currentLocation.value;
    final destination = station.latLng;

    final uri = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
          '?origin=${origin.latitude},${origin.longitude}'
          '&destination=${destination.latitude},${destination.longitude}'
          '&mode=driving'
          '&key=${MapApiKey.mapKey.trim()}',
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) return;

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final routes = data['routes'] as List?;
    if (routes == null || routes.isEmpty) return;

    // ✅ decode each step for road-following polyline
    final steps = routes[0]['legs'][0]['steps'] as List;
    final List<LatLng> points = [];
    for (final step in steps) {
      points.addAll(decodePolyline(step['polyline']['points'] as String));
    }

    polyLines.add(Polyline(
      polylineId: PolylineId('route_${station.id}'),
      points: points,
      color: AppColors.green500,
      width: 4,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
    ));
  }


  Future<void> startToStationPhase(LatLng stationPosition) async {
    // ✅ clear previous markers except driver
    markers.removeWhere((m) => m.markerId.value != 'driver_self');
    polyLines.clear();

    targetPosition.value = stationPosition;

    // ✅ place station marker
    await placeMarker(
      id: 'station',
      position: stationPosition,
      iconPath: 'assets/icons/pickUpLocation.png',
      iconWidthPx: 60,
      color: AppColors.green500,
    );

    // ✅ draw route driver → station
    await _fetchAndDrawRoute(origin: currentLocation.value);
  }

  Future<void> _placeStationMarker(WasteStationModel station) async {
    // ✅ just use asset icon directly — no widget rendering needed
    await placeMarker(
      id: 'station_${station.id}',
      position: station.latLng,
      iconPath: 'assets/icons/pickUpLocation.png',
      iconWidthPx: 60,
      color: AppColors.green500,
    );
  }

  Future<void> showNearbyStations(List<WasteStationModel> stations) async {
    await mapCompleter.future;

    // ✅ clear previous markers except driver
    markers.removeWhere((m) => m.markerId.value != 'driver_self');
    polyLines.clear();

    for (final station in stations) {
      await _placeStationMarker(station);
      await _drawRouteToStation(station);
    }
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
      color: AppColors.green500, // ✅ green
      width: 5,
      startCap: Cap.roundCap,   // ✅ rounded ends
      endCap: Cap.roundCap,
      jointType: JointType.round, // ✅ smooth corners
    ));
  }
}
