// ---------------- ACTION BUTTONS ----------------
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/commonScreens/chat/innerController/chat_controller.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/role/components/image/shimmer_image_loader.dart';
import 'package:project_borla/role/garbageCollector/call/incoming_call_screen.dart';
import 'package:project_borla/role/garbageCollector/call/outgoing_call_screen.dart';
import 'package:project_borla/role/garbageCollector/home/customer_info_screen.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../models/riderModels/bookingModels/available_bookings_model.dart';
import '../../../../theme/app_color.dart';
import '../../../commonScreens/chat/chatting_screen.dart';
import '../../../components/button/common_button.dart';
import '../../../components/dotted_line.dart';
import '../../../components/text/common_text.dart';
import '../controller/driver_home_controller.dart';

// ── Action Buttons ────────────────────────────────────────────

Widget actionButtons(BuildContext context, AvailableBookingModel job) {
  final ctrl = Get.find<DriverHomeController>();

  return Obx(() => Row(
    children: [
      Expanded(
        child: CommonButton(
          onTap: ctrl.isDeclineLoading.value
              ? null
              : () => ctrl.declineJob(job),
          buttonRadius: 12,
          titleText: ctrl.isDeclineLoading.value ? '...' : 'Decline',
          titleColor: AppColors.green500,
          borderColor: AppColors.green500,
          secondGradient: AppColors.transparent,
          firstGradient: AppColors.transparent,
        ),
      ),
      const SizedBox(width: 20),
      Expanded(
        child: CommonButton(
          onTap: ctrl.isAcceptLoading.value
              ? null
              : () => ctrl.acceptJob(job),
          buttonRadius: 12,
          titleText: ctrl.isAcceptLoading.value ? '...' : 'Accept',
        ),
      ),
    ],
  ));
}

// ---------------- USER ROW ----------------
// ── User Row ──────────────────────────────────────────────────
Widget userRow(DriverHomeController controller, AvailableBookingModel job) {
  return Row(
    children: [

      ShimmerImageLoader(url: job.user.profilePicture, width: 60, height: 60, borderRadius: 50,),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              textAlign: TextAlign.start,
              text: job.user.name,
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
      Obx(() => controller.isBottomSheet.value
          ? Row(
        children: [
          InkWell(
            onTap: () => Get.to(() => ChattingScreen(bookingId: job.id, participantPhone: job.user.phoneNumber, participantName: job.user.name,)),
            child: circleAction(
                Assets.icons.messageIcon.image(height: 20, width: 20)),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: ()=> ChatController.instance.makePhoneCall(job.user.phoneNumber),
            // onTap: () => Get.to(() => OutgoingCallScreen()),
            child: circleAction(
                Assets.icons.callIcon.image(height: 20, width: 20)),
          ),
        ],
      )
          : countdownRing(controller)),
    ],
  );
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

// ---------------- SAFE ANIMATION (NO Obx) ----------------
Widget countdownRing(DriverHomeController controller) {
  return SizedBox(
    width: 80,
    height: 80,
    child: AnimatedBuilder(
      animation: controller.animation,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: controller.animation.value,
              strokeWidth: 6,
              backgroundColor: AppColors.gray200,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF4CAF50)),
            ),
            CommonText(
              text: '${controller.remainingSeconds}s',
              fontSize: 14,
              color: AppColors.green500,
            )
          ],
        );
      },
    ),
  );
}

// ---------------- LOCATION ----------------
Widget locationSection(AvailableBookingModel job) {
  final ctrl = Get.find<DriverHomeController>();
  final distanceKm = ctrl.calculateDistanceToJob(job);

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(Icons.radio_button_checked, color: AppColors.primaryColor, size: 18),
          const SizedBox(height: 6),
          // VerticalDottedLine(),
          // const SizedBox(height: 6),
          // Icon(Icons.location_on, color: AppColors.primaryColor, size: 20),
        ],
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              textAlign: TextAlign.start,
              text: job.pickupAddress,
              fontSize: 14,
            ),
            const SizedBox(height: 8),
            // Row(
            //   children: [
            //     Expanded(child: HorizontalDottedLine()),
            //     distanceChip(distanceKm), // ✅ real distance
            //   ],
            // ),
            // const SizedBox(height: 8),
            // CommonText(
            //   textAlign: TextAlign.start,
            //   text: job.dropoffAddress ?? 'Dropoff not specified',
            //   fontSize: 14,
            // ),
          ],
        ),
      ),
    ],
  );
}

Widget distanceChip(double distanceKm) {
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
      text: '${distanceKm.toStringAsFixed(1)} KM',
      fontWeight: FontWeight.w600,
      color: AppColors.green500,
    ),
  );
}


// ── Payment Row ───────────────────────────────────────────────
Widget paymentRow(AvailableBookingModel job) {
  return Row(
    children: [
      CustomContainer(
        padding: const EdgeInsets.all(10),
        borderRadius: 100,
        color: AppColors.gray100,
        child: Center(
            child: Assets.icons.creditCardIcon.image(height: 20, width: 20)),
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
            text: job.paymentMethod == 'cash' ? 'Cash' : 'MTN MoMo Pay',
            fontSize: 16,
          ),
        ],
      ),
      const Spacer(),
      CommonText(
        text: job.price != null ? 'GH₵ ${job.price!.toStringAsFixed(0)}' : 'TBD',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    ],
  );
}