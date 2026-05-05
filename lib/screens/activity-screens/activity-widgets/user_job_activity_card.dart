
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/helpers/other_helper.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';
import 'package:project_borla/theme/app_color.dart';
import 'package:shimmer/shimmer.dart';
import '../../../role/commonScreens/chat/innerController/chat_controller.dart';
import '../../../role/components/image/shimmer_image_loader.dart';
import '../../../role/components/text/common_text.dart';
import '../../../theme/user_outgoing_call_screen.dart';
import '../../booking-accepted-screen/booking_accepted_screen.dart';
import '../../chat-screen/user_chat_screen.dart';
import '../../rider-arrived-screens/rider_arrived_screen.dart';
import '../activity-controller/user_activity_controller.dart';
import '../user_schedule_detail_screen.dart';


class UserActivityCard extends StatelessWidget {
  final bool isDetailScreen;
  final bool isScheduled;
  final bool isPending;
  final UserBookingModel booking;

  const UserActivityCard({
    super.key,
    this.isDetailScreen = false,
    this.isScheduled = false,
    this.isPending = false,
    required this.booking,
  });

  UserActivityController get activityController => Get.find<UserActivityController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.orange100),
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
          isPending? demoUserRowShimmer() : userRow(),
          const SizedBox(height: 10),
          const Divider(color: AppColors.gray200, thickness: 1),
          const SizedBox(height: 10),
          locationSection(),
          const SizedBox(height: 10),
          const Divider(color: AppColors.gray200, thickness: 1),
          const SizedBox(height: 10),
          paymentRow(),
          if (isDetailScreen && !isScheduled) ...[
            const SizedBox(height: 20),
            _viewDetailsButton(),
          ],
        ],
      ),
    );
  }

  Widget userRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShimmerImageLoader(
          url: booking.rider.profilePicture,
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
                text: booking.rider.name.isEmpty ? 'Rider' : booking.rider.name,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star_rounded, color: AppColors.orange300, size: 18,),
                  CommonText(
                    text: booking.rider.averageRating.toStringAsFixed(1),
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  CommonText(
                    text: " (${booking.rider.completedBookings} Rides)",
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
        activityController.selectedIndex.value == 1
            ? Row(
          children: [
            InkWell(
                onTap: () {
                  Get.to(() => UserChattingScreen(bookingId: booking.id,participantPhone: booking.rider.phoneNumber,participantName: booking.rider.name,));
                },
                child: circleAction(
                    Icons.chat_bubble_outline, AppColors.orange300)),
            const SizedBox(width: 12),
            InkWell(
                onTap: () {
                  ChatController.instance.makePhoneCall(booking.rider.phoneNumber);
                  // Get.to(() => UserOutgoingCallScreen());
                },
                child: circleAction(
                    Icons.phone_outlined, AppColors.orange300)),
          ],
        )
            : activityController.selectedIndex.value == 1
            ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CommonText(
              text: booking.scheduledDate,
              color: AppColors.orange300,
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
              horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.orange300,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.orange100),
          ),
          child: CommonText(
            text: booking.status.name.capitalizeFirst ?? '',
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }


  Widget demoUserRowShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar circle
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),

          // Name + rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 18,
                  width: double.infinity * 0.55, // ~55% width
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      height: 14,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          12.horizontalSpace,
          // Trailing — swap based on selectedIndex
          _shimmerTrailing(),
        ],
      ),
    );
  }

  Widget _shimmerTrailing() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget circleAction(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget locationSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.radio_button_checked,
                color: AppColors.orange300, size: 18),
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
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gray100,
          ),
          child: Icon(
            Icons.payment_outlined,
            color: AppColors.orange300,
            size: 20,
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
              text: booking.paymentMethod == 'cash' ? 'Cash' : 'MTN Momo Pay',
              fontSize: 16,
            ),
          ],
        ),
        const Spacer(),
        CommonText(
          text:'GH₵ ${booking.price.toStringAsFixed(2)}',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.orange300,
        ),
      ],
    );
  }

  Widget _viewDetailsButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          activityController.selectedBooking.value = booking;

          if (activityController.selectedIndex.value == 2) {
            Get.to(() => UserScheduleDetailScreen());
          } else if (activityController.selectedIndex.value == 1) {
            _routeBasedOnBookingStatus(booking);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange300,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const CommonText(
          text: 'View Details',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  void _routeBasedOnBookingStatus(UserBookingModel booking) {
    switch (booking.status) {
      case BookingStatus.pending:
        Get.toNamed('/booking-requested');
        break;
      case BookingStatus.accepted:
        Get.to(()=> BookingAcceptedScreen(booking: booking,));
        break;
      case BookingStatus.arrivedPickup:
        Get.to(()=> RiderArrivedScreen(booking: booking,));
        break;
      case BookingStatus.paymentCollected:
        Get.to(()=> RiderArrivedScreen(booking: booking,));
        break;
      case BookingStatus.headingToStation:
      case BookingStatus.inProgress:
      case BookingStatus.arrivedDropOff:
      case BookingStatus.awaitingPayment:
        Get.toNamed('/booking-accepted', arguments: {'booking': booking});
        break;
      case BookingStatus.completed:
      case BookingStatus.cancelled:
        Get.toNamed('/booking-history');
        break;
    }
  }
}
