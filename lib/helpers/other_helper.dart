
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_color.dart';


class OtherHelper {
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp passRegExp = RegExp(r'(?=.*[a-z])(?=.*[0-9])');

  static String? validator(value) {
    if (value.isEmpty) {
      return "field_required".tr;
    } else {
      return null;
    }
  }

  static String? emailValidator(
      value,
      ) {
    if (value!.isEmpty) {
      return "field_required".tr;
    } else if (!emailRegexp.hasMatch(value)) {
      return "valid_email_required".tr;
    } else {
      return null;
    }
  }

  static String? passwordValidator(value) {
    if (value.isEmpty) {
      return "field_required".tr;
    } else if (value.length < 8) {
      return "password_min_length".tr;
    } else if (!passRegExp.hasMatch(value)) {
      return "password_min_length".tr;
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator(value, passwordController) {
    if (value.isEmpty) {
      return "field_required".tr;
    } else if (value != passwordController.text) {
      return "password_match_error".tr;
    } else {
      return null;
    }
  }

  static Future<String> openDatePicker(
    TextEditingController controller, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime now = DateTime.now();
    final DateTime first = firstDate ?? DateTime(1900);
    final DateTime last = lastDate ?? now.subtract(const Duration(days: 1));

    DateTime initial = initialDate ?? now.subtract(const Duration(days: 365 * 18));

    if (initial.isAfter(last)) {
      initial = last;
    }

    if (initial.isBefore(first)) {
      initial = first;
    }

    final DateTime? picked = await showDatePicker(
      builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.green500,
            ),
          ),
          child: child!),
      context: Get.context!,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
    );
    if (picked != null) {
      controller.text = "${picked.year}-${picked.month}-${picked.day}";
      return picked.toIso8601String();
    }

    return "";
  }

  static Future<String?> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (getImages == null) return null;

    if (kDebugMode) {
      print(getImages.path);
    }

    return getImages.path;
  }

  static Future<String?> openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (getImages == null) return null;

    if (kDebugMode) {
      print(getImages.path);
    }

    return getImages.path;
  }


  static Future<String?> getVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickVideo(source: ImageSource.gallery);
    if (getImages == null) return null;

    if (kDebugMode) {
      print(getImages.path);
    }

    return getImages.path;
  }

  //Pick Image from Camera


  static Future<String> openTimePicker(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      controller.text =
      "${picked.hour} : ${picked.minute < 10 ? "0${picked.minute}" : picked.minute}";
      return "${picked.hour}:${picked.minute < 10 ? "0${picked.minute}" : picked.minute}";
    }
    return '';
  }

  // get time
  static String getTimeAgo(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr).toLocal();
    Duration diff = DateTime.now().difference(dateTime);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}min';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h';
    } else {
      return '${diff.inDays}day${diff.inDays > 1 ? 's' : ''}';
    }
  }

  /// Currency Formation
  static String formatCurrency(double value) {
    return '\$${value.round().toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  static String formatDate({required String isoDate}){
    DateTime dateTime = DateTime.parse(isoDate);
    String formatted = DateFormat('yyyy-MM-dd').format(dateTime);
    return formatted;
  }

  /// Address from coordinates
  static Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];

        // ── Only include non-empty parts ──
        final List<String> parts = [
          place.street ?? '',
          place.subLocality ?? '',
          place.locality ?? '',
          place.subAdministrativeArea ?? '',
          place.administrativeArea ?? '',
          place.country ?? '',
        ].where((part) => part.trim().isNotEmpty).toList();

        return parts.join(', ');
      } else {
        return 'No address found';
      }
    } catch (e) {
      log('Error: $e');
      return 'Error: $e';
    }
  }

  /// Coordinates from address
  static Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      final List<Location> locations = await locationFromAddress(address);

      if (locations.isEmpty) return null;

      return LatLng(
        locations.first.latitude,
        locations.first.longitude,
      );
    } catch (e) {
      log('Error in getCoordinatesFromAddress: $e');
      return null;
    }
  }

  ///Get current location
  static Future<({String address, LatLng position})> getCurrentLocationAddress() async {
    try {
      // ── Check permission ──
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return (address: '', position: const LatLng(0, 0));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return (address: '', position: const LatLng(0, 0));
      }

      // ── Get position ──
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // ── Get address ──
      final address = await getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final latLng = LatLng(position.latitude, position.longitude);
      // GMapController.instance.currentLocation.value = latLng;
      return (address: address, position: latLng);

    } catch (e) {
      log('Error in getCurrentLocationAddress: $e');
      return (address: '', position: const LatLng(0, 0));
    }
  }

  static String getTimeFromIso(String? isoDate) {
    try {
      if (isoDate == null || isoDate.isEmpty) {
        return '--:--';
      }

      DateTime dateTime = DateTime.parse(isoDate).toLocal();
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return '--:--';
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $uri';
    }
  }

}
