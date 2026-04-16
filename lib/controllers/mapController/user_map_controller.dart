// user_map_controller.dart
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:project_borla/map_key.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../theme/app_color.dart';
import 'base_map_controller.dart';

/// Tracks three phases:
/// 1. idle        — show user location + nearby drivers
/// 2. driverComing — show user + driver routing to user (pickup)
/// 3. onTrip      — show driver + destination routing
enum UserTripPhase { idle, driverComing, onTrip }

class UserMapController extends BaseMapController {
  static UserMapController get instance => Get.find<UserMapController>();

  // ── State ─────────────────────────────────────────────────────
  final Rx<UserTripPhase> tripPhase = UserTripPhase.idle.obs;

  /// Incremented when ConfirmLocationScreen pops so HomeMapScreen's
  /// GoogleMap rebuilds with a fresh key and re-fires onMapCreated.
  final RxInt homeMapKey = 0.obs;

  void onConfirmLocationPopped() {
    resetForNewMap();
    homeMapKey.value++;
  }
  final Rx<LatLng> destinationPosition = const LatLng(0, 0).obs;
  final RxMap<String, LatLng> nearbyDrivers = <String, LatLng>{}.obs;

  // ── Route State ───────────────────────────────────────────────
  List<LatLng> _remainingRoutePoints = [];
  LatLng? _lastDriverPosition;
  LatLng _firstStepEnd = const LatLng(0, 0);

  // =============================================================
  // ── Lifecycle
  // =============================================================

  @override
  void onInit() {
    super.onInit();
    ever(currentLocation, (LatLng loc) async {
      if (loc.latitude != 0 || loc.longitude != 0) {
        await mapCompleter.future;
        await placeUserMarker(loc);
        await animateCameraTo(loc);
      }
    });
  }

  // =============================================================
  // ── Public API
  // =============================================================

  /// Phase 1 — update nearby driver pins (before request accepted)
  void updateNearbyDrivers(Map<String, LatLng> drivers) {
    // Remove drivers no longer nearby
    final removed = nearbyDrivers.keys
        .where((id) => !drivers.containsKey(id))
        .toList();
    for (final id in removed) {
      removeMarker('nearby_$id');
      nearbyDrivers.remove(id);
    }

    // Add or update
    for (final entry in drivers.entries) {
      nearbyDrivers[entry.key] = entry.value;
      placeMarker(
        id: 'nearby_${entry.key}',
        position: entry.value,
        iconPath: Assets.icons.vanIcon.path,
        iconWidthPx: 80,
        color: AppColors.orange300,
      );
    }
  }

  /// Phase 2 — request accepted, driver heading to user (pickup)
  Future<void> startDriverComingPhase({
    required LatLng driverPosition,
    required LatLng userPosition,
  }) async {
    debugPrint('[UserMapController] Starting driver coming phase');
    debugPrint('[UserMapController] Driver: ${driverPosition.latitude}, ${driverPosition.longitude}');
    debugPrint('[UserMapController] User: ${userPosition.latitude}, ${userPosition.longitude}');
    
    tripPhase.value = UserTripPhase.driverComing;

    // Clear nearby driver pins
    for (final id in nearbyDrivers.keys) {
      removeMarker('nearby_$id');
    }
    nearbyDrivers.clear();

    destinationPosition.value = userPosition;
    
    // Place driver marker with smaller size
    placeDriverMarker(driverPosition);
    debugPrint('[UserMapController] Driver marker placed');
    
    // Fetch and draw route
    await _fetchAndDrawRoute(origin: driverPosition);
    debugPrint('[UserMapController] Route drawing completed');
  }

  /// Phase 3 — driver arrived, trip started, route to destination
  Future<void> startOnTripPhase({
    required LatLng driverPosition,
    required LatLng destination,
  }) async {
    tripPhase.value = UserTripPhase.onTrip;
    _remainingRoutePoints = [];

    destinationPosition.value = destination;

    // Place destination marker
    await placeMarker(
      id: 'destination',
      position: destination,
      iconPath: Assets.icons.locationCircleUser.path,
      iconWidthPx: 80,
      color: AppColors.green500,
    );

    await _fetchAndDrawRoute(origin: driverPosition);
  }

  /// Called on every driver socket update (phases 2 & 3)
  Future<void> onDriverLocationUpdated(LatLng newPosition) async {
    if (tripPhase.value == UserTripPhase.idle) return;

    if (_lastDriverPosition != null) {
      await _animateDriverMarker(_lastDriverPosition!, newPosition);
    }

    _lastDriverPosition = newPosition;
    await _fetchAndDrawRoute(origin: newPosition);
    await animateCameraTo(newPosition);
  }

  /// Call when trip ends
  void endTrip() {
    tripPhase.value = UserTripPhase.idle;
    _remainingRoutePoints = [];
    _lastDriverPosition = null;
    removeMarker('driver');
    removeMarker('destination');
    clearRoute();
  }

  // =============================================================
  // ── Route
  // =============================================================

  Future<void> _fetchAndDrawRoute({required LatLng origin}) async {
    final destination = destinationPosition.value;

    debugPrint('[UserMapController] Fetching route from ${origin.latitude},${origin.longitude} to ${destination.latitude},${destination.longitude}');

    final uri = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
          '?origin=${origin.latitude},${origin.longitude}'
          '&destination=${destination.latitude},${destination.longitude}'
          '&key=${MapApiKey.mapKey.trim()}',
    );

    final response = await http.get(uri);
    debugPrint('[UserMapController] Directions API status: ${response.statusCode}');
    
    if (response.statusCode != 200) {
      debugPrint('[UserMapController] Directions API error: ${response.body}');
      return;
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final routes = data['routes'] as List?;
    if (routes == null || routes.isEmpty) {
      debugPrint('[UserMapController] No routes found.');
      return;
    }

    // Decode the full polyline from all steps for accurate road-following
    final legs = routes[0]['legs'] as List;
    final steps = legs[0]['steps'] as List;
    
    List<LatLng> fullRoutePoints = [];
    for (var step in steps) {
      final stepPolyline = step['polyline']['points'] as String;
      fullRoutePoints.addAll(decodePolyline(stepPolyline));
    }

    debugPrint('[UserMapController] Decoded ${fullRoutePoints.length} route points');

    // Get first step end location for driver rotation
    final firstStepEnd = steps[0]['end_location'] as Map;
    _firstStepEnd = LatLng(
      (firstStepEnd['lat'] as num).toDouble(),
      (firstStepEnd['lng'] as num).toDouble(),
    );

    _remainingRoutePoints = fullRoutePoints;

    _redrawPolyline();
    debugPrint('[UserMapController] Polyline redrawn with ${_remainingRoutePoints.length} points');
    
    // Update driver marker with correct rotation
    placeDriverMarker(origin);
  }

  // =============================================================
  // ── Markers
  // =============================================================

  Future<void> placeUserMarker(LatLng position) async {
    await placeMarker(
      id: 'user',
      position: position,
      iconPath: Assets.icons.locationCircleUser.path,
      iconWidthPx: 80,
    );
  }

  void placeDriverMarker(LatLng position) {
    placeMarker(
      id: 'driver',
      position: position,
      iconPath: Assets.icons.vanIcon.path,
      iconWidthPx: 50, // Smaller driver marker (was 80)
      rotation: calculateBearing(position, _firstStepEnd),
      color: AppColors.orange300,
    );
  }

  // =============================================================
  // ── Animation
  // =============================================================

  Future<void> _animateDriverMarker(LatLng from, LatLng to) async {
    const totalSteps = 60;
    const totalDuration = Duration(seconds: 2);
    final stepMs = totalDuration.inMilliseconds ~/ totalSteps;

    for (int i = 0; i <= totalSteps; i++) {
      final t = i / totalSteps;
      final interpolated = LatLng(
        from.latitude + (to.latitude - from.latitude) * t,
        from.longitude + (to.longitude - from.longitude) * t,
      );
      placeDriverMarker(interpolated);
      _trimPolylineTo(interpolated);
      await Future.delayed(Duration(milliseconds: stepMs));
    }
  }

  // =============================================================
  // ── Polyline
  // =============================================================

  void _trimPolylineTo(LatLng currentPosition) {
    const double proximityThreshold = 0.0001;
    while (_remainingRoutePoints.isNotEmpty &&
        distanceBetween(_remainingRoutePoints.first, currentPosition) <
    proximityThreshold) {
      _remainingRoutePoints.removeAt(0);
    }
    _redrawPolyline();
  }

  void _redrawPolyline() {
    polyLines
      ..clear()
      ..add(Polyline(
        polylineId: const PolylineId('route'),
        points: List.from(_remainingRoutePoints),
        color: Colors.blue,
        width: 6, // Thicker polyline for better visibility (was 5)
        patterns: [], // Solid line, no patterns
        jointType: JointType.round, // Smooth turns
      ));
  }
}