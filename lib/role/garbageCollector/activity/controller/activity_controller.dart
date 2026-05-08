
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/garbageCollector/activity/history_screen.dart';
import '../../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../../../../services/api_service.dart';
import '../../../../utils/app_urls.dart';
import '../../../components/customSnackbar/custom_snackbar.dart';
import '../../home/arrived_screen.dart';
import '../../home/controller/driver_home_controller.dart';
import '../../home/customer_info_screen.dart';
import '../../home/navigate_destination_screen.dart';
import '../../home/navigate_station_screen.dart';
import '../../home/payment_receive_screen.dart';
import '../schedule_detail_screen.dart';


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

  // @override
  // void onInit() {
  //   super.onInit();
  //   if(PrefsHelper.myRole == "rider"){
  //     fetchOngoing();
  //     fetchScheduled();
  //     fetchHistory();
  //   }
  // }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // ── Fetch Ongoing (accepted) ───────────────────────────
  Future<void> fetchOngoing() async {
    isOngoingLoading.value = true;
    try {
      final response = await ApiService.get(
        AppUrls.getAcceptedBookings(status: 'ongoing'),
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
        AppUrls.getAcceptedBookings(status: 'scheduled'),
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
        AppUrls.getAcceptedBookings(status: 'completed'),
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

  Future<void> arriveAtPickup(BuildContext context, {bookingId}) async {
    // final bookingId = _getActiveBookingId();
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
            // showDialog(
            //   context: context,
            //   barrierDismissible: true,
            //   builder: (_) => const ArriveAtPickupDialog(),
            // );
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

  // ── Heading to Station ──────────────────────────────────
  final RxBool isHeadingToStationLoading = false.obs;

  Future<void> headingToStation({required String bookingId, required String stationId}) async {
    if (bookingId.isEmpty) {
      CustomSnackbar.error('No booking ID provided');
      return;
    }

    isHeadingToStationLoading.value = true;
    try {
      final response = await ApiService.patch(
        AppUrls.headingStation(id: bookingId),
        body: {"stationId" : stationId}
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final updated = RiderBookingModel.fromJson(response.body['data']);

        // ✅ update in both controllers
        _updateBookingInBothControllers(updated);

        CustomSnackbar.success(response.message);
        // Navigate or handle next state if needed
      } else {
        CustomSnackbar.error(response.message);
      }
    } catch (e) {
      log("Error in headingToStation: $e");
      CustomSnackbar.error('Something went wrong');
    } finally {
      isHeadingToStationLoading.value = false;
    }
  }

  // ── Booking Completed ──────────────────────────────────
  final RxBool isBookingCompletedLoading = false.obs;

  Future<void> bookingCompleted({required String bookingId}) async {
    if (bookingId.isEmpty) {
      CustomSnackbar.error('No booking ID provided');
      return;
    }

    isBookingCompletedLoading.value = true;
    try {
      final response = await ApiService.patch(
        AppUrls.bookingCompleted(id: bookingId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final updated = RiderBookingModel.fromJson(response.body['data']);

        // ✅ update in both controllers
        _updateBookingInBothControllers(updated);

        CustomSnackbar.success(response.message);
      } else {
        CustomSnackbar.error(response.message);
      }
    } catch (e) {
      log("Error in bookingCompleted: $e");
      CustomSnackbar.error('Something went wrong');
    } finally {
      isBookingCompletedLoading.value = false;
    }
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
      if (homeCtrl.acceptedBooking.value.id == updated.id) {
        homeCtrl.acceptedBooking.value = RiderBookingModel.fromJson(
          _riderBookingToJson(updated),
        );
      }
    }
  }

 // convert RiderBookingModel back to json for AcceptedBookingModel
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

  /// Get single booking by ID and route based on status
  Future<void> getSingleBooking({required String bookingId,}) async {
    try {
      final response = await ApiService.get(AppUrls.getSingleBooking(id: bookingId));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final booking = RiderBookingModel.fromJson(response.body['data']);

        // ✅ update in both controllers
        _updateBookingInBothControllers(booking);

          if(booking.isPaidByCustomer && booking.status == "arrived_pickup"){
              Get.to(()=> PaymentReceiveScreen(bookingModel: booking));
          }else{
            routeBasedOnBookingStatus(booking: booking);
          }
      } else {
        CustomSnackbar.error(response.message ?? 'Failed to fetch booking');
      }
    } catch (e) {
      debugPrint('Error fetching single booking: $e');
      CustomSnackbar.error('Failed to fetch booking details');
    }
  }

  // ── Payment Collection ──────────────────────────────────
  final RxBool isPaymentCollectionLoading = false.obs;

  Future<void> paymentCollection({required String bookingId}) async {
    if (bookingId.isEmpty) {
      CustomSnackbar.error('No booking ID provided');
      return;
    }

    isPaymentCollectionLoading.value = true;
    try {
      final response = await ApiService.patch(
        AppUrls.paymentCollection(id: bookingId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final updated = RiderBookingModel.fromJson(response.body['data']);

        // update in both controllers
        _updateBookingInBothControllers(updated);

        CustomSnackbar.success(response.message);
        Get.back(); // Close the dialog
        Get.offAll(() => NavigateStationScreen(booking: updated,)); // Navigate to station screen
      } else {
        CustomSnackbar.error(response.message);
      }
    } catch (e) {
      log("Error in paymentCollection: $e");
      CustomSnackbar.error('Something went wrong');
    } finally {
      isPaymentCollectionLoading.value = false;
    }
  }

  void routeBasedOnBookingStatus({required RiderBookingModel booking}) {
    switch (booking.status) {
      case 'pending':
      // Show pending booking details
        Get.to(() => ScheduleDetailScreen());
        break;
      case 'accepted':
        Get.to(() => CustomerInfoScreen(booking: booking,));
        break;
      case 'arrived_pickup':
        if(booking.isPaidByCustomer){
          Get.to(()=> PaymentReceiveScreen(bookingModel: booking));
        }else{
          Get.to(() => ArrivedScreen(bookingModel: booking));
        }
        break;
      case 'payment_collected':
        Get.to(() => NavigateStationScreen(booking: booking));
        break;
      case 'heading_to_station':
        Get.to(() => NavigateStationScreen(booking: booking,));
        break;
      case 'in_progress':
      case 'awaiting_payment':
        if(booking.isPaidByCustomer){
          Get.to(()=> PaymentReceiveScreen(bookingModel: booking));
        }else{
          Get.to(() => ArrivedScreen(bookingModel: booking));
        }
        break;
      case 'arrived_dropoff':
      case 'completed':
        Get.to(() => NavigateStationScreen(booking: booking,));
        break;
      case 'cancelled':
        Get.to(()=> HistoryScreen());
        break;
      default:
      // Fallback to schedule detail screen
    }
  }

}