
import 'package:get/get.dart';
import 'package:project_borla/models/riderModels/bookingModels/rider_booking_model.dart';
import 'package:project_borla/services/api_service.dart';
import 'package:project_borla/utils/app_urls.dart';
import '../../../role/components/customSnackbar/custom_snackbar.dart';

class UserActivityController extends GetxController {

  static UserActivityController get instance => Get.find<UserActivityController>();
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


  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // ── Fetch Ongoing (accepted/arrived_pickup/in_progress) ───────────────────────────
  Future<void> fetchOngoing() async {
    isOngoingLoading.value = true;
    try {
      final response = await ApiService.get(
        AppUrls.getMyBookings(status: 'ongoing'),
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
        AppUrls.getMyBookings(status: 'scheduled'),
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
        AppUrls.getMyBookings(status: 'completed'),
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
}