
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../../../../theme/app_color.dart';
import '../../../commonScreens/chat/chatting_screen.dart';
import '../../../components/button/common_button.dart';
import '../../../components/dotted_line.dart';
import '../../../components/image/shimmer_image_loader.dart';
import '../../../components/text/common_text.dart';
import '../../activity/controller/activity_controller.dart';
import '../../call/outgoing_call_screen.dart';
import '../controller/driver_home_controller.dart';
import '../navigate_destination_screen.dart';
import 'common_widgets.dart';

class CustomerInfoBottomSheet extends StatelessWidget {
  RiderBookingModel booking;
  CustomerInfoBottomSheet({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final DriverHomeController controller = Get.find();

    controller.isBottomSheet.value = true;

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.45,
      maxChildSize: 0.65,
      builder: (_, scrollController) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Drag Handle
                Center(
                  child: Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.black50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// Title
                const Center(
                  child: CommonText(
                    text: 'Customer Information',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),
                const Divider(color: AppColors.black50, thickness: 1),

                userRow(controller, booking),

                const Divider(color: AppColors.black50, thickness: 1),
                const SizedBox(height: 6),

                bottomSheetLocationSection(booking),

                const Divider(color: AppColors.black50, thickness: 1),
                const SizedBox(height: 10),

                summarySection(booking),

                const SizedBox(height: 20),

                // Cancel Ride Button
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.deepOrange,
                //     borderRadius: BorderRadius.circular(16),
                //   ),
                //   padding: const EdgeInsets.all(2),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       minimumSize: const Size(100, 50),
                //       backgroundColor: Colors.white,
                //       shadowColor: Colors.transparent,
                //       elevation: 0,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(14),
                //       ),
                //     ),
                //     onPressed: () {
                //       Get.to(() => CancelRideScreen(booking: booking));
                //     },
                //     child: const Padding(
                //       padding: EdgeInsets.fromLTRB(120, 14, 120, 14),
                //       child: Text(
                //         'Cancel Ride',
                //         style: TextStyle(
                //           color: Colors.deepOrange,
                //           fontWeight: FontWeight.w600,
                //           fontSize: 18,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                bottomSheetActionButtons(context, booking),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── User Row ──────────────────────────────────────────────────
Widget userRow(DriverHomeController controller, RiderBookingModel? booking) {
  return Row(
    children: [
      ShimmerImageLoader(url: booking!.user.profilePicture, width: 60, height: 60, borderRadius: 50,),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: booking.user.name,
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
            onTap: () => Get.to(() => ChattingScreen(bookingId: booking.id, participantName: booking.user.name, participantPhone: booking.user.phoneNumber,)),
            child: circleAction(
                Assets.icons.messageIcon.image(height: 20, width: 20)),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () => Get.to(() => OutgoingCallScreen()),
            child: circleAction(
                Assets.icons.callIcon.image(height: 20, width: 20)),
          ),
        ],
      )
          : const SizedBox.shrink()),
    ],
  );
}

// ── Location Section ──────────────────────────────────────────
Widget bottomSheetLocationSection(RiderBookingModel? booking) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(Icons.radio_button_checked,
          color: AppColors.primaryColor, size: 18),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CommonText(
                  text: 'Pickup Point',
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                CommonText(
                  text: _formatTime(booking?.requestedAt), // ✅ real time
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(height: 4),
            CommonText(
              textAlign: TextAlign.start,
              text: booking?.pickupAddress ?? '—',
              fontSize: 14,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
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
    return '$hour.$minute $period';
  } catch (_) {
    return '—';
  }
}

// ── Summary Section ───────────────────────────────────────────
Widget summarySection(RiderBookingModel? booking) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(text: 'Total Price', fontSize: 13, color: Colors.grey),
            const SizedBox(height: 4),
            CommonText(
              text: booking?.price != null
                  ? 'GH₵ ${booking!.price.toStringAsFixed(0)}'
                  : 'TBD', // ✅ real data
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ],
        ),
        Container(height: 40, width: 1, color: Colors.grey),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CommonText(text: 'Total Distance', fontSize: 13, color: Colors.grey),
            const SizedBox(height: 4),
            CommonText(
              text: booking?.estimatedDistance != null
                  ? '${booking!.estimatedDistance.toStringAsFixed(1)} KM'
                  : '—', // ✅ real data
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ],
        ),
        Container(height: 40, width: 1, color: Colors.grey),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const CommonText(text: 'Avg. Time', fontSize: 13, color: Colors.grey),
            const SizedBox(height: 4),
            CommonText(
              text: booking?.estimatedTime ?? '—', // ✅ real data
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ],
        ),
      ],
    ),
  );
}

// ── Action Buttons — unchanged ─────────────────────────────────
Widget bottomSheetActionButtons(BuildContext context, RiderBookingModel booking) {
  return Row(
    children: [
      // Expanded(
      //   child: CommonButton(
      //     buttonRadius: 12,
      //     titleText: 'Cancel Ride',
      //     titleColor: AppColors.green500,
      //     borderColor: AppColors.green500,
      //     firstGradient: AppColors.transparent,
      //     secondGradient: AppColors.transparent,
      //   ),
      // ),
      // const SizedBox(width: 20),
      Expanded(
        child: CommonButton(
          onTap: () {
            Get.to(() => NavigateDestinationScreen(booking: booking));
            log("BookingId: ${booking.id}");
          },
          buttonRadius: 12,
          titleText: 'Next',
        ),
      ),
    ],
  );
}