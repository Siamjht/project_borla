
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/helpers/other_helper.dart';
import 'package:project_borla/role/commonScreens/chat/innerController/chat_controller.dart';
import 'package:project_borla/role/garbageCollector/activity/controller/activity_controller.dart';
import 'package:project_borla/role/garbageCollector/activity/schedule_detail_screen.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../../../../theme/custom_container_copy.dart';
import '../../../commonScreens/chat/chatting_screen.dart';
import '../../../components/image/shimmer_image_loader.dart';
import '../../../components/text/common_text.dart';
import '../../home/arrived_screen.dart';
import '../../home/innerWidget/waste_details_widget.dart';
import 'common_widgets.dart';

class ActivityCard extends StatelessWidget {
  final bool isDetailScreen;
  final bool isActivityScreen;
  final RiderBookingModel booking; // ✅ real data

  ActivityCard({
    super.key,
    this.isDetailScreen = false,
    this.isActivityScreen = false,
    required this.booking,
  });

  final ActivityController activityController = Get.find<ActivityController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.green100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userRow(),
          const SizedBox(height: 10),
          const Divider(color: AppColors.gray200, thickness: 1),
          WasteDetailsWidget(job: booking),
          const SizedBox(height: 10),
          locationSection(),

          const SizedBox(height: 10),
          const Divider(color: AppColors.gray200, thickness: 1),
          const SizedBox(height: 10),
          paymentRow(),
          if (isDetailScreen) ...[
            const SizedBox(height: 20),
            _viewDetailsButton(),
          ],
          if(booking.isScheduled && !isActivityScreen)...[
            const SizedBox(height: 16),
            _startScheduleButton()
          ]
        ],
      ),
    );
  }

  Widget userRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShimmerImageLoader(
          url: booking.user.profilePicture,
          width: 56,
          height: 56,
          borderRadius: 28,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                textAlign: TextAlign.start,
                text: booking.user.name,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 4),
              CommonText(
                text: 'user'.tr,
                fontSize: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        ActivityController.instance.selectedIndex.value == 0
            ? Row(
          children: [
            InkWell(
                onTap: () {
                  Get.to(() => ChattingScreen(bookingId: booking.id, participantName: booking.user.name, participantPhone: booking.user.phoneNumber,));
                },
                child: circleAction(
                    Assets.icons.messageIcon.image(height: 20, width: 20))),
            const SizedBox(width: 12),
            InkWell(
                onTap: () {
                  ChatController.instance.makePhoneCall(booking.user.phoneNumber);
                  // Get.to(() => OngoingCallScreen());
                },
                child: circleAction(
                    Assets.icons.callIcon.image(height: 20, width: 20))),
          ],
        )
            : ActivityController.instance.selectedIndex.value == 1
            ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonText(
              text: booking.scheduledDate,
              color: AppColors.green500,
              fontSize: 12,
            ),
            CommonText(
              text: OtherHelper.getTimeFromIso(booking.scheduledFor),
              color: AppColors.gray300,
              fontSize: 12,
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
            text: booking.status,
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget locationSection() {
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
                text: booking.pickupAddress,
                fontSize: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget paymentRow() {
    return Row(
      children: [
        CustomContainer(
          padding: const EdgeInsets.all(10),
          borderRadius: 100,
          color: AppColors.gray100,
          child: Center(
            child: Assets.icons.creditCardIcon
                .image(height: 20, width: 20),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: 'payment'.tr,
              fontSize: 12,
              color: AppColors.gray300,
            ),

            CommonText(
              text: booking.paymentMethod == 'cash' ? 'cash'.tr : 'momo_pay'.tr,
              fontSize: 16,
            ),
          ],
        ),
        const Spacer(),
        CommonText(
          text: 'GH₵ ${booking.price.toStringAsFixed(0)}',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _viewDetailsButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Store selected booking before navigating
          activityController.selectedBooking.value = booking;

          // Route based on booking status for active tab (index == 0)
          if (activityController.selectedIndex.value == 0) {
            log("Driver Booking status: ${booking.status}");
            log("Driver Booking status: ${booking.isPaid}");
            activityController.routeBasedOnBookingStatus(booking: booking);
          } else if (activityController.selectedIndex.value == 1) {
            if(booking.isScheduled && booking.scheduledDate.isNotEmpty){
              Get.to(() => ScheduleDetailScreen());
            }else{
              activityController.routeBasedOnBookingStatus(booking: booking);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: CommonText(
          text: 'view_details'.tr,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _startScheduleButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (booking.isScheduled && booking.scheduledFor.isNotEmpty) {
            try {
              final scheduledDateTime =
                  DateTime.parse(booking.scheduledFor).toLocal();
              final now = DateTime.now();

              if (now.isBefore(scheduledDateTime)) {
                Get.snackbar(
                  "Warning",
                  "you can't start before schedule time",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primaryColor,
                  colorText: Colors.white,
                );
                return;
              }
            } catch (e) {
              debugPrint("Error parsing scheduled date: $e");
            }
          }
          Get.to(() => ArrivedScreen(bookingModel: booking));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: CommonText(
          text: "start_ride".tr,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}



