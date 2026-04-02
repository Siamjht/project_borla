
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/riderModels/bookingModels/accept_booking_model.dart';
import '../../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../../../../services/api_service.dart';
import '../../../../utils/app_urls.dart';
import '../../../components/customSnackbar/custom_snackbar.dart';
import '../../home/controller/driver_home_controller.dart';
import '../../home/innerWidget/arrive_at_pickup_dialog.dart';

class ActivityController extends GetxController {
  static ActivityController get instance => Get.find<ActivityController>();

  final RxInt selectedIndex = 0.obs;

  // ── Loading States ─────────────────────────────────────
  final RxBool isOngoingLoading = false.obs;
  final RxBool isScheduleLoading = false.obs;
  final RxBool isHistoryLoading = false.obs;

  // ── Data ───────────────────────────────────────────────
  final RxList<RiderBookingModel> ongoingBookings = <RiderBookingModel>[].obs;
  final RxList<RiderBookingModel> scheduledBookings = <RiderBookingModel>[].obs;
  final RxList<RiderBookingModel> historyBookings = <RiderBookingModel>[].obs;

  // ── Selected booking for detail screen ─────────────────
  final Rx<RiderBookingModel?> selectedBooking = Rx<RiderBookingModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchOngoing();
    fetchScheduled();
    fetchHistory();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // ── Fetch Ongoing (accepted) ───────────────────────────
  Future<void> fetchOngoing() async {
    isOngoingLoading.value = true;
    try {
      final response = await ApiService.get(
        AppUrls.getAcceptedBooking(status: 'accepted'),
      );
      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        ongoingBookings.value =
            data.map((e) => RiderBookingModel.fromJson(e)).toList();
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isOngoingLoading.value = false;
    }
  }

  // ── Fetch Scheduled ────────────────────────────────────
  Future<void> fetchScheduled() async {
    isScheduleLoading.value = true;
    try {
      final response = await ApiService.get(
        AppUrls.getAcceptedBooking(status: 'scheduled'),
      );
      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        scheduledBookings.value =
            data.map((e) => RiderBookingModel.fromJson(e)).toList();
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isScheduleLoading.value = false;
    }
  }

  // ── Fetch History (completed/cancelled) ────────────────
  Future<void> fetchHistory() async {
    isHistoryLoading.value = true;
    try {
      final response = await ApiService.get(
        AppUrls.getAcceptedBooking(status: 'completed'),
      );
      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        historyBookings.value =
            data.map((e) => RiderBookingModel.fromJson(e)).toList();
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isHistoryLoading.value = false;
    }
  }

  // ── Arrive at Pickup ───────────────────────────────────
  final RxBool isArriveLoading = false.obs;

  Future<void> arriveAtPickup(BuildContext context) async {
    // ✅ get id from either source
    final bookingId = _getActiveBookingId();
    if (bookingId.isEmpty) {
      CustomSnackbar.error('No active booking found');
      return;
    }

    isArriveLoading.value = true;
    try {
      final response = await ApiService.patch(
        AppUrls.arriveAtPickup(id: bookingId),
      );

      if (response.statusCode == 200) {
        final updated = RiderBookingModel.fromJson(response.body['data']);

        // ✅ update in both controllers
        _updateBookingInBothControllers(updated);

        CustomSnackbar.success(response.message);

        if (updated.status == 'arrived_pickup') {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) => const ArriveAtPickupDialog(),
            );
          }
        }
      } else {
        CustomSnackbar.error(response.message);
      }
    }catch(e){
      log("Error : $e");
    }finally {
      isArriveLoading.value = false;
    }
  }

  String _getActiveBookingId() {
    // ✅ check ActivityController first
    if (Get.isRegistered<ActivityController>()) {
      final id = Get.find<ActivityController>().selectedBooking.value?.id ?? '';
      if (id.isNotEmpty) return id;
    }

    // ✅ fallback to DriverHomeController
    if (Get.isRegistered<DriverHomeController>()) {
      return Get.find<DriverHomeController>().acceptedBooking.value?.id ?? '';
    }

    return '';
  }

  void _updateBookingInBothControllers(RiderBookingModel updated) {
    // ✅ update ActivityController selectedBooking
    if (Get.isRegistered<ActivityController>()) {
      final activityCtrl = Get.find<ActivityController>();
      activityCtrl.selectedBooking.value = updated;

      // also update in ongoing list
      final index = activityCtrl.ongoingBookings
          .indexWhere((b) => b.id == updated.id);
      if (index != -1) {
        activityCtrl.ongoingBookings[index] = updated;
        activityCtrl.ongoingBookings.refresh();
      }
    }

    // ✅ update DriverHomeController acceptedBooking
    if (Get.isRegistered<DriverHomeController>()) {
      final homeCtrl = Get.find<DriverHomeController>();
      if (homeCtrl.acceptedBooking.value?.id == updated.id) {
        homeCtrl.acceptedBooking.value = AcceptedBookingModel.fromJson(
          _riderBookingToJson(updated),
        );
      }
    }
  }

// ✅ convert RiderBookingModel back to json for AcceptedBookingModel
  Map<String, dynamic> _riderBookingToJson(RiderBookingModel booking) {
    return {
      'id': booking.id,
      'userId': booking.userId,
      'riderId': booking.riderId,
      'status': booking.status,
      'wasteCategory': booking.wasteCategory,
      'wasteImages': booking.wasteImages,
      'binSize': booking.binSize,
      'binQuantity': booking.binQuantity,
      'wasteSize': booking.wasteSize,
      'pickupLocation': {
        'type': 'Point',
        'coordinates': [booking.pickupLongitude, booking.pickupLatitude],
      },
      'pickupAddress': booking.pickupAddress,
      'dropoffAddress': booking.dropoffAddress,
      'vehicleType': booking.vehicleType,
      'estimatedDistance': booking.estimatedDistance,
      'estimatedTime': booking.estimatedTime,
      'paymentMethod': booking.paymentMethod,
      'price': booking.price,
      'isPaid': booking.isPaid,
      'isScheduled': booking.isScheduled,
      'scheduledFor': booking.scheduledFor,
      'scheduledDate': booking.scheduledDate,
      'requestedAt': booking.requestedAt,
      'acceptedAt': booking.acceptedAt,
      'completedAt': booking.completedAt,
      'cancelledAt': booking.cancelledAt,
      'arrivedAtPickup': booking.arrivedAtPickup,
      'createdAt': booking.createdAt,
      'updatedAt': booking.updatedAt,
      'user': {
        'id': booking.user.id,
        'name': booking.user.name,
        'email': booking.user.email,
        'phoneNumber': booking.user.phoneNumber,
        'profilePicture': booking.user.profilePicture,
      },
    };
  }

}