
import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_borla/controllers/mapController/driver_map_controller.dart';
import 'package:project_borla/helpers/prefs_helper.dart';
import 'package:project_borla/models/riderModels/bookingModels/rider_booking_model.dart';
import 'package:project_borla/services/socket_service.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../../helpers/other_helper.dart';
import '../../../../models/riderModels/bookingModels/available_bookings_model.dart';
import '../../../../models/riderModels/wasteStationModel/waste_station_model.dart';
import '../../../../services/api_service.dart';
import '../../../../utils/app_urls.dart';
import '../../../components/customSnackbar/custom_snackbar.dart';
import '../customer_info_screen.dart';

class DriverHomeController extends GetxController with GetTickerProviderStateMixin {

  static DriverHomeController get instance => Get.find<DriverHomeController>();

  // ── State ─────────────────────────────────────────────────
  RxBool isOnline = false.obs;
  final RxBool isScheduleRequest = true.obs;
  final RxBool isUnderReview = true.obs;
  final isExpanded = false.obs;
  final RxBool isBottomSheet = true.obs;

  // ── Timer Animation ────────────────────────────────────────
  late AnimationController _animationController;
  late Animation<double> animation;
  final RxInt durationInSeconds = 30.obs;
  final RxInt remainingSeconds = 30.obs;

  final cardSwiperController = CardSwiperController();

  // Trigger swipe programmatically (e.g., from Accept/Decline buttons)
  void swipeRight() => cardSwiperController.swipe(CardSwiperDirection.right);
  void swipeLeft()  => cardSwiperController.swipe(CardSwiperDirection.left);

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: durationInSeconds.value),
    );
    animation = AlwaysStoppedAnimation(1.0);
    isOnline.value = PrefsHelper.onlineStatus;
  }

  @override
  void onClose() {
    cardSwiperController.dispose();
    _animationController.dispose();
    super.onClose();
  }

  final Rx<LatLng> driverPosition = const LatLng(5.6037, -0.1870).obs; // default Accra
  final RxInt currentJobIndex = 0.obs;

  /// Current location fetching
  RxBool locationFetching = false.obs;
  Future<void> fetchCurrentLocation() async {
    locationFetching.value = true;
    final result = await OtherHelper.getCurrentLocationAddress();
    final address = result.address;
    final position = result.position;

    if (result.address.isNotEmpty) {
      driverPosition.value = position;
      DriverMapController.instance.currentLocation.value = position;
      updateDriverPosition(position, address);
    }
    locationFetching.value = false;
  }

  Future<void> updateDriverPosition(LatLng newPosition, address) async {
    try {
      final response = await ApiService.patch(
        AppUrls.updateMyLocation,
        body: {
          'latitude': newPosition.latitude,
          'longitude': newPosition.longitude,
          'locationName': address,
        },
      );

      if (response.statusCode == 200) {
        driverPosition.value = newPosition;
      } else {
        CustomSnackbar.error(response.message);
      }
    } catch (e) {
      log('Error updating driver position: $e');
    }
  }

  // ── Toggle Online Status ───────────────────────────────
  final RxBool isToggleLoading = false.obs;

  Future<void> toggleOnline(bool value) async {
    isToggleLoading.value = true;
    try {
      final response = await ApiService.patch(AppUrls.toggleMyStatus);

      if (response.statusCode == 200) {
        isOnline.value = value;
        PrefsHelper.setBool('onlineStatus', value);
        if (value) {
          SocketServices.listenForNewBooking();
          // _setupTimer();
          // getAvailableBookings();
        }else{
          SocketServices.socket.off(SocketEvents.bookingNewOn);
        }
        CustomSnackbar.success(response.message);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isToggleLoading.value = false;
    }
  }

  // ── Job Actions ────────────────────────────────────────────

  final RxBool isAcceptLoading = false.obs;
  final RxBool isDeclineLoading = false.obs;
  final Rx<RiderBookingModel> acceptedBooking = Rx<RiderBookingModel>(RiderBookingModel());

  final RxBool showJobCards = true.obs;
// ── Accept Booking ─────────────────────────────────────
  Future<void> acceptJob(AvailableBookingModel job) async {
    isAcceptLoading.value = true;
    try {
      final response = await ApiService.patch(
        AppUrls.acceptBooking(id: job.id),
      );

      if (response.statusCode == 200) {
        acceptedBooking.value =
            RiderBookingModel.fromJson(response.body['data']);

        showJobCards.value = false;
        jobRequests.remove(job);
        currentJobIndex.value = 0;
        if (jobRequests.isNotEmpty) {
          showJobCards.value = true;
        }

        isBottomSheet.value = true;
        CustomSnackbar.success(response.message);
        Get.to(() => CustomerInfoScreen(booking: acceptedBooking.value,));
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isAcceptLoading.value = false;
    }
  }

// ── Decline Booking ────────────────────────────────────
  Future<void> declineJob(AvailableBookingModel job) async {
    isDeclineLoading.value = true;
    try {
      final response = await ApiService.patch(
        AppUrls.declineBooking(id: job.id),
      );

      if (response.statusCode == 200) {

        showJobCards.value = false;
        currentJobIndex.value = 0;
        jobRequests.remove(job);

        // ✅ show again if still have jobs
        if (jobRequests.isNotEmpty) {
          showJobCards.value = true;
        }
        CustomSnackbar.success(response.message);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isDeclineLoading.value = false;
    }
  }
  void toggle() => isExpanded.toggle();

  double calculateDistanceToJob(AvailableBookingModel job) {
    final driverLat = driverPosition.value.latitude;
    final driverLng = driverPosition.value.longitude;

    final distanceInMeters = Geolocator.distanceBetween(
      driverLat,
      driverLng,
      job.pickupLatitude,
      job.pickupLongitude,
    );

    return distanceInMeters / 1000; // convert to KM
  }

  /// ============>>> Requested Bookings <<<================
  final RxBool isBookingsLoading = false.obs;
  final RxList<AvailableBookingModel> jobRequests = <AvailableBookingModel>[].obs;

  Future<void> getAvailableBookings() async {
    jobRequests.clear();
    isBookingsLoading.value = true;
    try {
      final response = await ApiService.get(AppUrls.availableBookings());

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        jobRequests.value = data.map((e) => AvailableBookingModel.fromJson(e)).toList();
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isBookingsLoading.value = false;
    }
  }



  // ── Stations ───────────────────────────────────────────
  final RxBool isStationsLoading = false.obs;
  final RxList<StationModel> stations = <StationModel>[].obs;

  Future<void> getStations() async {
    isStationsLoading.value = true;
    try {
      final response = await ApiService.get(AppUrls.stations);

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        stations.value =
            data.map((e) => StationModel.fromJson(e)).toList();

        // ✅ show stations on map after fetching
        if (stations.isNotEmpty) {
          final stationList = stations.map((s) => WasteStationModel(
            id: s.id,
            name: s.name,
            latitude: s.latitude,
            longitude: s.longitude,
            distanceKm: calculateDistanceToStation(s),
          )).toList();

          Get.find<DriverMapController>().showNearbyStations(stationList);
        }
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isStationsLoading.value = false;
    }
  }

  double calculateDistanceToStation(StationModel station) {
    final distanceInMeters = Geolocator.distanceBetween(
      driverPosition.value.latitude,
      driverPosition.value.longitude,
      station.latitude,
      station.longitude,
    );
    return distanceInMeters / 1000;
  }

  // ── Timer ──────────────────────────────────────────────────
  void _setupTimer() {
    _animationController.stop();
    _animationController.reset();
    _animationController.duration = Duration(seconds: durationInSeconds.value);

    animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    )..addListener(() {
      remainingSeconds.value =
          (animation.value * durationInSeconds.value).ceil();
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.snackbar(
          'Time Up!',
          'Countdown finished',
          backgroundColor: AppColors.green500,
          colorText: AppColors.white,
        );
      }
    });

    _animationController.forward();
  }

  void restart({int? newDuration}) {
    if (newDuration != null) {
      durationInSeconds.value = newDuration;
      remainingSeconds.value = newDuration;
    }
    _animationController.stop();
    _animationController.reset();
    _animationController.duration = Duration(seconds: durationInSeconds.value);
    _animationController.forward();
  }

}

