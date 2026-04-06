
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimePickerController extends GetxController {

  static DateTimePickerController get instance => Get.find<DateTimePickerController>();
  final selectedTab = 0.obs;

  final hourIndex = 0.obs;
  final minuteIndex = 0.obs;
  final periodIndex = 0.obs;

  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;
  late FixedExtentScrollController periodController;
  final Rx<DateTime?> selectedCustomDate = Rx<DateTime?>(null);

  RxBool isSetScheduled = false.obs;

  @override
  void onInit() {
    super.onInit();
    _setCurrentTime();
    _initScrollControllers();
  }

  void _setCurrentTime() {
    final now = TimeOfDay.now();
    int hour = now.hour;
    int minute = now.minute;

    if (hour >= 12) {
      periodIndex.value = 1;
      hour = hour == 12 ? 12 : hour - 12;
    } else {
      periodIndex.value = 0;
      hour = hour == 0 ? 12 : hour;
    }

    hourIndex.value = hour - 1; // 0–11
    minuteIndex.value = minute;
  }

  void _initScrollControllers() {
    hourController =
        FixedExtentScrollController(initialItem: hourIndex.value);
    minuteController =
        FixedExtentScrollController(initialItem: minuteIndex.value);
    periodController =
        FixedExtentScrollController(initialItem: periodIndex.value);
  }

  TimeOfDay get selectedTime {
    int hour = hourIndex.value + 1;

    if (periodIndex.value == 1 && hour != 12) hour += 12;
    if (periodIndex.value == 0 && hour == 12) hour = 0;

    return TimeOfDay(hour: hour, minute: minuteIndex.value);
  }


  // ── Get scheduled data for API ─────────────────────────
  String get scheduledForISO {
    final now = DateTime.now();
    late DateTime baseDate;

    // ✅ get base date based on selected tab
    if (selectedTab.value == 0) {
      // Today
      baseDate = DateTime(now.year, now.month, now.day);
    } else if (selectedTab.value == 1) {
      // Tomorrow
      final tomorrow = now.add(const Duration(days: 1));
      baseDate = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
    } else {
      // Custom date from calendar
      baseDate = selectedCustomDate.value ?? now;
    }

    // ✅ get hour in 24h format
    final hour12 = hourIndex.value + 1;
    final isPM = periodIndex.value == 1;
    final hour24 = isPM
        ? (hour12 == 12 ? 12 : hour12 + 12)
        : (hour12 == 12 ? 0 : hour12);
    final minute = minuteIndex.value;

    final scheduledDateTime = DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      hour24,
      minute,
    );

    // ✅ format: 2026-03-20T14:30:00.000Z
    return scheduledDateTime.toUtc().toIso8601String().replaceAll(
      RegExp(r'\.\d+Z$'),
      '.000Z',
    );
  }

  String get scheduledDateFormatted {
    late DateTime baseDate;
    final now = DateTime.now();

    if (selectedTab.value == 0) {
      baseDate = now;
    } else if (selectedTab.value == 1) {
      baseDate = now.add(const Duration(days: 1));
    } else {
      baseDate = selectedCustomDate.value ?? now;
    }

    // ✅ format: "March 20, 2026"
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[baseDate.month - 1]} ${baseDate.day}, ${baseDate.year}';
  }

  @override
  void onClose() {
    hourController.dispose();
    minuteController.dispose();
    periodController.dispose();
    super.onClose();
  }
}