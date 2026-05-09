import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final Completer<GoogleMapController> _mapController = Completer();

  LatLng _currentLatLng = const LatLng(23.8103, 90.4125); // fallback
  String _currentAddress = "Searching your location...";
  String _mapStyle = "";
  CameraPosition? _lastCameraPosition;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMapStyle();
      _getCurrentLocation();
    });
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/map_style.json');
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _currentLatLng = LatLng(position.latitude, position.longitude);
    _updateAddress(_currentLatLng);

    final controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentLatLng, zoom: 16),
      ),
    );
  }

  Future<void> _updateAddress(LatLng latLng) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    if (placemarks.isNotEmpty) {
      Placemark p = placemarks.first;
      setState(() {
        _currentAddress =
        "${p.street}, ${p.locality}, ${p.administrativeArea}";
      });
    }
  }

  void _onCameraIdle(CameraPosition position) {
    _currentLatLng = position.target;
    _updateAddress(position.target);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// GOOGLE MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLatLng,
              zoom: 14,
            ),
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,

            onMapCreated: (controller) {
              controller.setMapStyle(_mapStyle);
              _mapController.complete(controller);
            },

            /// TRACK CAMERA WHILE MOVING
            onCameraMove: (position) {
              _lastCameraPosition = position;
            },

            /// FIRED WHEN USER STOPS DRAGGING
            onCameraIdle: () {
              if (_lastCameraPosition != null) {
                _currentLatLng = _lastCameraPosition!.target;
                _updateAddress(_currentLatLng);
              }
            },
          ),


          /// CENTER PIN (CUSTOM MARKER)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Image.asset(
                "assets/images/location_pin.png",
                height: 48,
              ),
            ),
          ),

          /// GPS BUTTON (Bottom Right)
          Positioned(
            bottom: 180,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: _getCurrentLocation,
              child: const Icon(Icons.gps_fixed, color: Colors.black),
            ),
          ),

          /// BOTTOM SHEET
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _bottomSheet(),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Text(
            "Confirm address...",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.amber),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _currentAddress,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () {
                debugPrint("Confirmed: $_currentLatLng");
              },
              child: const Text(
                "Confirm Location",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
