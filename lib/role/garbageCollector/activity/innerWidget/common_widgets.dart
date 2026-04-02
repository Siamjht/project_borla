
// ---------------- USER ROW ----------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/garbageCollector/activity/controller/activity_controller.dart';
import 'package:project_borla/role/garbageCollector/call/ongoing_call_screen.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../../../../theme/app_color.dart';
import '../../../commonScreens/chat/chatting_screen.dart';
import '../../../components/dotted_line.dart';
import '../../../components/image/shimmer_image_loader.dart';
import '../../../components/text/common_text.dart';

Widget userRow(RiderBookingModel booking) {
  final activityCtrl = Get.find<ActivityController>();

  return Row(
    children: [
      ShimmerImageLoader(
        url: booking.user.profilePicture,
        width: 56,
        height: 56,
        isCircle: true,
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: booking.user.name, // ✅ real data
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 4),
            const CommonText(
              text: 'User',
              fontSize: 14,
              color: Colors.grey,
            ),
          ],
        ),
      ),

      // ✅ real tab index check
      Obx(() => activityCtrl.selectedIndex.value == 0
          ? Row(
        children: [
          InkWell(
            onTap: () => Get.to(() => ChattingScreen()),
            child: circleAction(
                Assets.icons.messageIcon.image(height: 20, width: 20)),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () => Get.to(() => OngoingCallScreen()),
            child: circleAction(
                Assets.icons.callIcon.image(height: 20, width: 20)),
          ),
        ],
      )
          : activityCtrl.selectedIndex.value == 1
          ? Column(
        children: [
          CommonText(
            text: booking.scheduledDate ?? '—', // ✅ real data
            color: AppColors.green500,
          ),
          CommonText(
            text: _formatTime(booking.scheduledFor), // ✅ real data
            color: AppColors.gray300,
            fontSize: 14,
          ),
        ],
      )
          : Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.green500,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.green100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: CommonText(
          text: booking.status.capitalize ?? 'Completed', // ✅ real data
          color: AppColors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      )),
    ],
  );
}

String _formatTime(String? isoDate) {
  if (isoDate == null || isoDate.isEmpty) return '—';
  try {
    final dt = DateTime.parse(isoDate).toLocal();
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  } catch (_) {
    return '—';
  }
}

Widget circleAction(Image icon) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.primaryColor),
    ),
    child: Center(child: icon),
  );
}

// ── Location ──────────────────────────────────────────────────
Widget locationSection(RiderBookingModel booking) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(Icons.radio_button_checked,
              color: AppColors.primaryColor, size: 18),
        ],
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              textAlign: TextAlign.start,
              text: booking.pickupAddress, // ✅ real data
              fontSize: 15,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget distanceChip(RiderBookingModel booking) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20),
          blurRadius: 8,
          spreadRadius: 2,
        ),
      ],
    ),
    child: CommonText(
      text: booking.estimatedDistance != null
          ? '${booking.estimatedDistance!.toStringAsFixed(1)} KM'
          : '—', // ✅ real data
      fontWeight: FontWeight.w600,
      color: AppColors.primaryColor,
    ),
  );
}

// ── Payment ───────────────────────────────────────────────────
Widget paymentRow(RiderBookingModel booking) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.gray200,
        ),
        child: const Icon(
          Icons.payment_outlined,
          color: AppColors.primaryColor,
        ),
      ),
      const SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            text: 'Payment',
            fontSize: 12,
            color: AppColors.gray300,
          ),
          CommonText(
            text: booking.paymentMethod == 'cash'
                ? 'Cash'
                : 'MTN MoMo Pay', // ✅ real data
            fontSize: 16,
          ),
        ],
      ),
      const Spacer(),
      CommonText(
        text: booking.price != null
            ? 'GH₵ ${booking.price!.toStringAsFixed(0)}'
            : 'TBD', // ✅ real data
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    ],
  );
}