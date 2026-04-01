import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:project_borla/map_key.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../theme/app_color.dart';


class GMapController extends GetxController {
  static GMapController get instance => Get.find<GMapController>();

  // ── Map Controller ────────────────────────────────────────────
  final Completer<GoogleMapController> _mapCompleter = Completer();
  GoogleMapController? mapController;

  // ── Observable State ──────────────────────────────────────────
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Polyline> polyLines = <Polyline>{}.obs;
  final Rx<LatLng> driverPosition = const LatLng(23.255355, 90.984841).obs;
  final Rx<LatLng> destinationPosition = const LatLng(0, 0).obs;
  final Rx<ScreenCoordinate?> driverScreenCoordinate = Rx(null);
  final Rx<LatLng> currentLocation = const LatLng(0, 0).obs;

  // ── Camera State ──────────────────────────────────────────────
  double _zoom = 16.0;
  double _tilt = 0.0;
  double _currentBearing = 0.0;

  // ── Route State ───────────────────────────────────────────────
  List<LatLng> _fullRoutePoints = [];
  List<LatLng> _remainingRoutePoints = [];
  LatLng? _lastDriverPosition;
  LatLng _firstStepEnd = const LatLng(0, 0);

  // =============================================================
  // ── Lifecycle
  // =============================================================

  @override
  void onInit() {
    super.onInit();
    // Wait for map to be fully ready, then place marker and animate camera
    ever(currentLocation, (LatLng loc) async {
      if (loc.latitude != 0 || loc.longitude != 0) {
        await _mapCompleter.future;
        await _placeCurrentLocationMarker(loc);
        _animateCameraTo(loc);
      }
    });
  }

  @override
  void onClose() {
    mapController?.dispose();
    super.onClose();
  }

  // =============================================================
  // ── Map Callbacks
  // =============================================================

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (!_mapCompleter.isCompleted) _mapCompleter.complete(controller);
    _updateDriverScreenCoordinate();
  }

  void onCameraMove(CameraPosition position) {
    _zoom = position.zoom;
    _tilt = position.tilt;
    _currentBearing = position.bearing;
    _updateDriverScreenCoordinate();
  }

  // =============================================================
  // ── Public API
  // =============================================================

  CameraPosition get initialCameraPosition => CameraPosition(
    target: currentLocation.value,
    zoom: _zoom,
  );

  /// Set destination once before tracking starts.
  void setDestination(LatLng destination) {
    destinationPosition.value = destination;
    _placeMarker(
      id: 'destination',
      position: destination,
      iconPath: Assets.icons.location.path,
      iconWidthPx: 80,
      color: AppColors.green500,
    );
  }

  /// Call this whenever a new driver GPS location is received.
  Future<void> onDriverLocationUpdated(LatLng newPosition) async {
    if (_lastDriverPosition != null) {
      await _animateDriverMarker(_lastDriverPosition!, newPosition);
    }

    _lastDriverPosition = newPosition;
    driverPosition.value = newPosition;

    await _fetchAndDrawRoute(origin: newPosition);
    await _animateCameraTo(newPosition);
  }

  // =============================================================
  // ── Route
  // =============================================================

  Future<void> _fetchAndDrawRoute({required LatLng origin}) async {
    final destination = destinationPosition.value;

    final uri = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
          '?origin=${origin.latitude},${origin.longitude}'
          '&destination=${destination.latitude},${destination.longitude}'
          '&key=${MapApiKey.mapKey.trim()}',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      log('[GMapController] Directions API error: ${response.body}');
      return;
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final routes = data['routes'] as List?;

    if (routes == null || routes.isEmpty) {
      log('[GMapController] No routes found.');
      return;
    }

    final overviewPolyline =
    routes[0]['overview_polyline']['points'] as String;
    _fullRoutePoints = _decodePolyline(overviewPolyline);

    final firstStepEnd =
    routes[0]['legs'][0]['steps'][0]['end_location'] as Map;
    _firstStepEnd = LatLng(
      (firstStepEnd['lat'] as num).toDouble(),
      (firstStepEnd['lng'] as num).toDouble(),
    );

    // Only reset remaining points on first load.
    if (_remainingRoutePoints.isEmpty) {
      _remainingRoutePoints = List.from(_fullRoutePoints);
    }

    _redrawPolyline();
    _placeDriverMarker(origin);
  }

  // =============================================================
  // ── Markers
  // =============================================================

  Future<void> _placeCurrentLocationMarker(LatLng position) async {
    await _placeMarker(
      id: 'current_location',
      position: position,
      iconPath: Assets.icons.locationCirclePointer.path,
      iconWidthPx: 50,
    );
  }

  void _placeDriverMarker(LatLng position) {
    _placeMarker(
      id: 'driver',
      position: position,
      iconPath: Assets.icons.vanIcon.path,
      rotation: _calculateBearing(position, _firstStepEnd),
      color: AppColors.orange300
    );
  }

  Future<void> _placeMarker({
    required String id,
    required LatLng position,
    required String iconPath,
    double rotation = 0,
    int iconWidthPx = 120,
    Color? color, // ← add this
  }) async {
    final icon = await _bitmapFromAsset(iconPath, iconWidthPx, color: color);
    final marker = Marker(
      markerId: MarkerId(id),
      position: position,
      icon: icon,
      rotation: rotation,
      anchor: const Offset(0.5, 0.5),
    );
    markers
      ..removeWhere((m) => m.markerId.value == id)
      ..add(marker);
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

      _placeDriverMarker(interpolated);
      _trimPolylineTo(interpolated);

      await Future.delayed(Duration(milliseconds: stepMs));
    }
  }

  Future<void> _animateCameraTo(LatLng target) async {
    await mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: _zoom,
          tilt: _tilt,
          bearing: _currentBearing,
        ),
      ),
    );
  }

  // =============================================================
  // ── Polyline
  // =============================================================

  void _trimPolylineTo(LatLng currentPosition) {
    const double proximityThreshold = 0.0001;
    while (_remainingRoutePoints.isNotEmpty &&
        _distanceBetween(_remainingRoutePoints.first, currentPosition) <  // ← < was missing
            proximityThreshold) {
      _remainingRoutePoints.removeAt(0);
    }
    _redrawPolyline();
  }

  void _redrawPolyline() {
    polyLines
      ..clear()
      ..add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: List.from(_remainingRoutePoints),
          color: Colors.black,
          width: 5,
        ),
      );
  }

  // =============================================================
  // ── Screen Coordinate
  // =============================================================

  Future<void> _updateDriverScreenCoordinate() async {
    if (mapController == null) return;
    driverScreenCoordinate.value =
    await mapController!.getScreenCoordinate(driverPosition.value);
  }

  // =============================================================
  // ── Helpers / Utilities
  // =============================================================

  Future<BitmapDescriptor> _bitmapFromAsset(
      String assetPath,
      int targetWidthPx, {
        Color? color,
      }) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: targetWidthPx,
    );
    final frame = await codec.getNextFrame();

    // Apply tint color if provided
    if (color != null) {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final paint = Paint()..colorFilter = ColorFilter.mode(color, BlendMode.srcIn);
      canvas.drawImage(frame.image, Offset.zero, paint);
      final picture = recorder.endRecording();
      final tinted = await picture.toImage(frame.image.width, frame.image.height);
      final bytes = await tinted.toByteData(format: ui.ImageByteFormat.png);
      return BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
    }

    final bytes = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
  }

  double _calculateBearing(LatLng start, LatLng end) {
    final dLng = end.longitude - start.longitude;
    final y = math.sin(dLng) * math.cos(end.latitude);
    final x = math.cos(start.latitude) * math.sin(end.latitude) -
        math.sin(start.latitude) *
            math.cos(end.latitude) *
            math.cos(dLng);
    return (math.atan2(y, x) * 180 / math.pi) % 360;
  }

  double _distanceBetween(LatLng a, LatLng b) {
    final dx = a.latitude - b.latitude;
    final dy = a.longitude - b.longitude;
    return math.sqrt(dx * dx + dy * dy);
  }

  List<LatLng> _decodePolyline(String encoded) {
    final points = <LatLng>[];
    int index = 0;
    int lat = 0, lng = 0;

    while (index < encoded.length) {
      int shift = 0, result = 0, b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (result & 1) != 0 ? ~(result >> 1) : result >> 1;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result & 1) != 0 ? ~(result >> 1) : result >> 1;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }
    return points;
  }
}