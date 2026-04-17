
// base_map_controller.dart
import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class BaseMapController extends GetxController {
  // ── Map Controller ────────────────────────────────────────────
  Completer<GoogleMapController> _mapCompleter = Completer();
  Completer<GoogleMapController> get mapCompleter => _mapCompleter;
  GoogleMapController? mapController;

  /// Set this before navigating to a screen with a new GoogleMap.
  /// The map will animate to this location once onMapCreated fires.
  LatLng? pendingCameraTarget;

  // ── Observable State ──────────────────────────────────────────
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Polyline> polyLines = <Polyline>{}.obs;
  final Rx<LatLng> currentLocation = const LatLng(0, 0).obs;
  final Rx<ScreenCoordinate?> screenCoordinate = Rx(null);

  // ── Camera State ──────────────────────────────────────────────
  double zoom = 16.0;
  double tilt = 0.0;
  double currentBearing = 0.0;

  // =============================================================
  // ── Lifecycle
  // =============================================================

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
    if (!mapCompleter.isCompleted) mapCompleter.complete(controller);
    _updateScreenCoordinate();
    if (pendingCameraTarget != null) {
      final target = pendingCameraTarget!;
      pendingCameraTarget = null;
      WidgetsBinding.instance.addPostFrameCallback((_) => animateCameraTo(target));
    }
  }

  /// Call when navigating back from a screen that had its own GoogleMap
  /// (e.g. ConfirmLocationScreen). Resets the stale controller so the
  /// underlying screen's map can re-register via onMapCreated.
  void resetForNewMap() {
    mapController = null;
    _mapCompleter = Completer();
  }

  void onCameraMove(CameraPosition position) {
    zoom = position.zoom;
    tilt = position.tilt;
    currentBearing = position.bearing;
    _updateScreenCoordinate();
  }

  // =============================================================
  // ── Public API
  // =============================================================

  CameraPosition get initialCameraPosition => CameraPosition(
    target: currentLocation.value,
    zoom: zoom,
  );

  Future<void> animateCameraTo(LatLng target) async {
    try {
      if (mapController == null) return;
      await mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: target,
            zoom: zoom,
            tilt: tilt,
            bearing: currentBearing,
          ),
        ),
      );
    } catch (e) {
      log('Camera animation skipped — map disposed: $e');
      mapController = null; // ✅ clear disposed controller
    }
  }

  Future<void> placeMarker({
    required String id,
    required LatLng position,
    required String iconPath,
    double rotation = 0,
    int iconWidthPx = 120,
    Color? color,
  }) async {
    final icon = await _bitmapFromAsset(iconPath, iconWidthPx, color: color);
    final marker = Marker(
      markerId: MarkerId(id),
      position: position,
      icon: icon,
      rotation: rotation,
      anchor: const Offset(0.5, 0.5),
    );
    log("🗺️ icon loaded: $icon"); // ✅ add this
    log("🗺️ placing marker at: $position");
    log("🗺️ markers before: ${markers.length}");

    markers.removeWhere((m) => m.markerId.value == id);
    markers.add(marker);
    markers.refresh();

    log("🗺️ markers after: ${markers.length}");
  }

  void removeMarker(String id) {
    markers.removeWhere((m) => m.markerId.value == id);
  }

  void clearRoute() {
    polyLines.clear();
  }

  // =============================================================
  // ── Helpers / Utilities
  // =============================================================

  Future<void> _updateScreenCoordinate() async {
    if (mapController == null) return;
    screenCoordinate.value =
    await mapController!.getScreenCoordinate(currentLocation.value);
  }

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

    if (color != null) {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final paint = Paint()
        ..colorFilter = ColorFilter.mode(color, BlendMode.srcIn);
      canvas.drawImage(frame.image, Offset.zero, paint);
      final picture = recorder.endRecording();
      final tinted =
      await picture.toImage(frame.image.width, frame.image.height);
      final bytes = await tinted.toByteData(format: ui.ImageByteFormat.png);
      return BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
    }

    final bytes =
    await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
  }

  double calculateBearing(LatLng start, LatLng end) {
    final startLat = _degreesToRadians(start.latitude);
    final startLng = _degreesToRadians(start.longitude);
    final endLat = _degreesToRadians(end.latitude);
    final endLng = _degreesToRadians(end.longitude);

    final dLng = endLng - startLng;
    final y = math.sin(dLng) * math.cos(endLat);
    final x = math.cos(startLat) * math.sin(endLat) -
        math.sin(startLat) *
            math.cos(endLat) *
            math.cos(dLng);
    return (math.atan2(y, x) * 180 / math.pi) % 360;
  }

  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  double distanceBetween(LatLng a, LatLng b) {
    final double dx = a.latitude - b.latitude;
    final double dy = a.longitude - b.longitude;
    return math.sqrt(dx * dx + dy * dy).toDouble();
  }

  List<LatLng> decodePolyline(String encoded) {
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