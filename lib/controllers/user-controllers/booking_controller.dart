
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_borla/controllers/mapController/user_map_controller.dart';
import 'package:project_borla/role/components/customSnackbar/custom_snackbar.dart';
import 'package:project_borla/screens/activity-screens/user_activity_screen.dart';
import 'package:project_borla/screens/activity-screens/user_schedule_detail_screen.dart';
import 'package:project_borla/screens/booking-accepted-screen/booking_accepted_screen.dart';
import 'package:project_borla/screens/booking-requested-screen/booking_requested_screen.dart';
import 'package:project_borla/screens/home-screens/user_nav_bar.dart';
import 'package:project_borla/screens/payment-success-screens/payment_success_screeen.dart';
import 'package:project_borla/screens/rider-arrived-screens/rider_arrived_screen.dart';
import 'package:project_borla/utils/app_urls.dart';
import '../../helpers/other_helper.dart';
import '../../models/api_response_model.dart';
import '../../models/userModels/bookingModels/user_booking_model.dart';
import '../../models/userModels/saved_place_model.dart';
import '../../screens/activity-screens/activity-controller/user_activity_controller.dart';
import '../../screens/activity-screens/user_history_screen.dart';
import '../../screens/rider-arrived-screens/innerWidget/payment_dialogs.dart';
import '../../services/api_service.dart';

class BookingController extends GetxController {

  static BookingController get instance => Get.find<BookingController>();
  final RxBool isCreateBookingLoading = false.obs;
  final Rx<UserBookingModel?> createdBooking = Rx<UserBookingModel?>(null);

  final RxBool showSearchSheet = true.obs;
  TextEditingController bookingLocationTextCtrl = TextEditingController();

  /// fetch current location method
  Future<void> fetchCurrentLocation() async {
    final result = await OtherHelper.getCurrentLocationAddress();
    final address = result.address;
    final position = result.position;

    if (result.address.isNotEmpty) {
      bookingLocationTextCtrl.text = address;
      UserMapController.instance.currentLocation.value = LatLng(position.latitude, position.longitude);
      selectedPlaceLat = position.latitude;
      selectedPlaceLang = position.longitude;
      showSearchSheet.value = false;
    }
  }

  final RxBool isAddLoading = false.obs;
  final RxBool isGetLoading = false.obs;
  final RxBool isUpdateLoading = false.obs;
  final RxBool isPlaceSaving = false.obs;

  final RxList<SavedPlaceModel> savedPlaces = <SavedPlaceModel>[].obs;
  final Rx<SavedPlaceModel?> updatedPlace = Rx<SavedPlaceModel?>(null);

  final RxBool isMomo = false.obs ;
  final RxBool isCash = false.obs ;
  final RxInt selectedIndex = (-1).obs ;
  final RxBool isPaymentPicked = false.obs ;
  final RxString selectedPaymentMethod = ''.obs;

  // ── Saved Place Form State ────────────────────────────────
  final RxString selectedPlaceType = ''.obs;
  final RxString selectedPlaceId = ''.obs;

  final TextEditingController placeTitleController = TextEditingController();
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController placeAddressController = TextEditingController();
  double savedPlaceLat = 0.0;
  double savedPlaceLang = 0.0;

  double selectedPlaceLat = 0.0;
  double selectedPlaceLang = 0.0;

  // ── Waste Qty Form State ──────────────────────────────
  final RxString selectedBinSize = ''.obs;
  final RxInt selectedBinQuantity = (-1).obs;
  final TextEditingController wasteSizeController = TextEditingController();
  final RxList<String> wasteImagePaths = <String>[].obs;

  void addWasteImage(String path) {
    wasteImagePaths.add(path);
  }

  void removeWasteImage(int index) {
    wasteImagePaths.removeAt(index);
  }

  /// Populates the form with a specific saved place's data.
  void selectPlace(SavedPlaceModel place) {
    selectedPlaceType.value = place.placeType;
    selectedPlaceId.value = place.id;
    placeTitleController.text = place.placeTitle;
    placeNameController.text = place.placeName;
    placeAddressController.text = place.address;
    savedPlaceLat = place.latitude;
    savedPlaceLang = place.longitude;
  }

  /// Call when a place type icon is tapped in SavedPlacesScreen.
  /// Populates the form with existing data if a saved place of that type exists.
  void selectPlaceType(String type) {
    selectedPlaceType.value = type;
    placeTitleController.text = type;

    final matches = savedPlaces.where((p) => p.placeType == type).toList();
    if (matches.isNotEmpty) {
      final place = matches.first;
      selectedPlaceId.value = place.id;
      placeNameController.text = place.placeName;
      placeAddressController.text = place.address;
      savedPlaceLat = place.latitude;
      savedPlaceLang = place.longitude;
    } else {
      selectedPlaceId.value = '';
      placeNameController.clear();
      placeAddressController.clear();
      savedPlaceLat = 0.0;
      savedPlaceLang = 0.0;
    }
  }

  /// Clears the saved place form (use when entering AddPlaceScreen).
  void clearPlaceForm() {
    selectedPlaceType.value = '';
    selectedPlaceId.value = '';
    placeTitleController.clear();
    placeNameController.clear();
    placeAddressController.clear();
    savedPlaceLat = 0.0;
    savedPlaceLang = 0.0;
  }

  /// Save or update based on whether a place ID is already selected.
  Future<void> saveOrUpdatePlace() async {
    final type = selectedPlaceType.value;
    final title = placeTitleController.text.trim();
    final name = placeNameController.text.trim();
    final address = placeAddressController.text.trim();

    if (type.isEmpty || title.isEmpty || name.isEmpty || address.isEmpty) {
      CustomSnackbar.error('Please fill in all fields');
      return;
    }

    if (selectedPlaceId.value.isNotEmpty) {
      await updatePlace(
        id: selectedPlaceId.value,
        placeType: type,
        placeTitle: title,
        placeName: name,
        address: address,
        latitude: savedPlaceLat,
        longitude: savedPlaceLang,
      );
    } else {
      await addPlace(
        placeType: type,
        placeTitle: title,
        placeName: name,
        address: address,
        latitude: savedPlaceLat,
        longitude: savedPlaceLang,
      );
    }
  }

  // ── Add Place ─────────────────────────────────────────────
  Future<void> addPlace({
    required String placeType,
    required String placeTitle,
    required String placeName,
    required String address,
    required double latitude,
    required double longitude,
  }) async {
    isAddLoading.value = true;
    isPlaceSaving.value = true;
    try {
      final response = await ApiService.post(
        AppUrls.newPlaces,
        body: {
          'placeType': placeType.toLowerCase(),
          'placeTitle': placeTitle,
          'placeName': placeName,
          'address': address,
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        savedPlaces.add(SavedPlaceModel.fromJson(response.body['data']));
        Get.back();
        CustomSnackbar.success(response.message);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isAddLoading.value = false;
      isPlaceSaving.value = false;
    }
  }

  // ── Get Places ────────────────────────────────────────────
  Future<void> getPlaces() async {
    isGetLoading.value = true;
    try {
      final response = await ApiService.get(AppUrls.newPlaces);

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        savedPlaces.value = data.map((e) => SavedPlaceModel.fromJson(e)).toList();
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isGetLoading.value = false;
    }
  }

  // ── Update Place ──────────────────────────────────────────
  Future<void> updatePlace({
    required String id,
    required String placeType,
    required String placeTitle,
    required String placeName,
    required String address,
    required double latitude,
    required double longitude,
  }) async {
    isUpdateLoading.value = true;
    isPlaceSaving.value = true;
    try {
      final response = await ApiService.put(
        AppUrls.updatePlace(id: id),
        body: {
          'placeType': placeType,
          'placeTitle': placeTitle,
          'placeName': placeName,
          'address': address,
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      if (response.statusCode == 200) {
        updatedPlace.value = SavedPlaceModel.fromJson(response.body['data']);

        // Update in list locally
        final index = savedPlaces.indexWhere((p) => p.id == id);
        if (index != -1) {
          savedPlaces[index] = updatedPlace.value!;
          savedPlaces.refresh();
        }

        Get.back();
        CustomSnackbar.success(response.message);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isUpdateLoading.value = false;
      isPlaceSaving.value = false;
    }
  }

  /// Create booking repo
  final RxString selectedWasteCategory = ''.obs;
  RxBool isScheduled = false.obs;
  String? scheduledFor;
  String? scheduledDate;
  Future<bool> createBooking() async {
    isCreateBookingLoading.value = true;
    try {
      final response = await BookingService.createBooking(
        wasteCategory: selectedWasteCategory.value,
        binSize: selectedBinSize.value,
        binQuantity: selectedBinQuantity.value,
        wasteSize: int.tryParse(wasteSizeController.text) ?? 0,
        pickupLatitude: selectedPlaceLat,
        pickupLongitude: selectedPlaceLang,
        pickupAddress: bookingLocationTextCtrl.text,
        vehicleType: 'Tri Cycle',
        paymentMethod: selectedPaymentMethod.value,
        isScheduled: isScheduled.value,
        scheduledFor: scheduledFor,
        scheduledDate: scheduledDate,
        imagePaths: wasteImagePaths,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        createdBooking.value = UserBookingModel.fromJson(response.body['data']);
        resetSchedule();
        CustomSnackbar.success(response.message);
        return true;
      } else {
        CustomSnackbar.error(response.message);
        return false;
      }
    } finally {
      isCreateBookingLoading.value = false;
    }
  }


  void resetSchedule() {
    isScheduled.value = false;
    scheduledFor = null;
    scheduledDate = null;
  }

  /// Get single booking by ID and route based on status
  Future<void> getSingleBooking({required String bookingId}) async {
    try {
      final response = await ApiService.get(AppUrls.getSingleBooking(id: bookingId));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final booking = UserBookingModel.fromJson(response.body['data']);

        log("${booking.isScheduled} && ${booking.status}" );

        if(booking.isScheduled && booking.status == BookingStatus.accepted){
          UserActivityController.instance.selectedBooking.value = booking;
          Get.to(()=> UserScheduleDetailScreen());
        }else{
          // Route based on booking status
          _routeBasedOnBookingStatus(booking);
        }
      } else {
        CustomSnackbar.error(response.message);
      }
    } catch (e) {
      debugPrint('Error fetching single booking: $e');
      CustomSnackbar.error('Failed to fetch booking details');
    }
  }

  /// Navigate to appropriate screen based on booking status
  void _routeBasedOnBookingStatus(UserBookingModel booking) {
    switch (booking.status) {
      case BookingStatus.pending:
        // Navigate to booking requested screen
        Get.to(()=> BookingRequestedScreen());
        break;
      case BookingStatus.accepted:
        Get.to(()=> BookingAcceptedScreen(booking: booking,));
        break;
      case BookingStatus.arrivedPickup:
        Get.to(()=> RiderArrivedScreen(booking: booking,));
        break;
      case BookingStatus.paymentCollected:
        Get.to(()=> RiderArrivedScreen(booking: booking,));
        Get.dialog(
          barrierDismissible: false,
          buildPaymentSuccessDialog(booking: booking),
        );
        break;
      case BookingStatus.inProgress:
      case BookingStatus.awaitingPayment:
        Get.to(()=> BookingAcceptedScreen(booking: booking));
        break;
      case BookingStatus.headingToStation:
      case BookingStatus.arrivedDropOff:
      case BookingStatus.completed:
      case BookingStatus.cancelled:
        UserActivityController.instance.selectedIndex.value = 2;
        UserActivityController.instance.fetchHistory();
        UserNavBarController.instance.tabIndex.value = 1;
        Get.to(()=> UserNavBar());
        break;
    }
  }

}

class BookingService {
  static Future<ApiResponseModel> createBooking({
    required String wasteCategory,
    required String binSize,
    required int binQuantity,
    required int wasteSize,
    required double pickupLatitude,
    required double pickupLongitude,
    required String pickupAddress,
    required String vehicleType,
    required String paymentMethod,
    required bool isScheduled,
    String? dropOffAddress,
    String? price,
    String? scheduledFor,
    String? scheduledDate,
    List<String>? imagePaths, // local file paths
  }) async {
    final Map<String, dynamic> body = {
      'wasteCategory': wasteCategory,
      'binSize': binSize,
      'binQuantity': binQuantity,
      'wasteSize': wasteSize,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'pickupAddress': pickupAddress,
      'vehicleType': vehicleType,
      'paymentMethod': paymentMethod,
      'isScheduled': isScheduled,
      if (dropOffAddress != null) 'dropoffAddress': dropOffAddress,
      if (price != null) 'price': price,
      if (scheduledFor != null) 'scheduledFor': scheduledFor,
      if (scheduledDate != null) 'scheduledDate': scheduledDate,
    };

    // No images → regular POST
    if (imagePaths == null || imagePaths.isEmpty) {
      return await ApiService.post(AppUrls.createBookings, body: body);
    }

    // With images → multipart POST
    final imageList = imagePaths
        .map((path) => {
      'imagePath': path,
      'imageName': 'wasteImages',
    })
        .toList();

    return await ApiService.multipartRequestWithMultipleImages(
      url: AppUrls.createBookings,
      body: body,
      imageList: imageList,
      method: HttpMethod.post,
    );
  }
}