
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/helpers/other_helper.dart';
import 'package:project_borla/models/riderModels/bookingModels/rider_booking_model.dart';
import 'package:project_borla/screens/track-screen/track_screen.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../role/components/image/shimmer_image_loader.dart';
import '../../../role/components/text/common_text.dart';
import '../../../theme/user_outgoing_call_screen.dart';
import '../../chat-screen/chat_screen_copy.dart';
import '../../rider-arrived-screens/rider_arrived_screen.dart';
import '../activity-controller/user_activity_controller.dart';
import '../user_schedule_detail_screen.dart';


class UserActivityCard extends StatelessWidget {
  final bool isDetailScreen;
  final RiderBookingModel booking;

  const UserActivityCard({
    super.key,
    this.isDetailScreen = false,
    required this.booking,
  });

  UserActivityController get activityController => Get.find<UserActivityController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
          userRow(),
          const SizedBox(height: 10),
          const Divider(color: AppColors.gray200, thickness: 1),
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
                text: booking.rider.name,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star_rounded, color: AppColors.orange300,),
                  CommonText(
                    text: booking.rider.totalRatings.toString(),
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  CommonText(
                    text: " (${booking.rider.completedBookings.toString()} Rides)",
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
        UserActivityController.instance.selectedIndex.value == 0
            ? Row(
          children: [
            InkWell(
                onTap: () {
                  Get.to(() => UserChattingScreen());
                },
                child: circleAction(
                    Icons.chat_bubble_outline, AppColors.orange300)),
            const SizedBox(width: 12),
            InkWell(
                onTap: () {
                  Get.to(() => UserOutgoingCallScreen());
                },
                child: circleAction(
                    Icons.phone_outlined, AppColors.orange300)),
          ],
        )
            : UserActivityController.instance.selectedIndex.value == 1
            ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonText(
              text: booking.scheduledDate ?? '',
              color: AppColors.orange300,
              fontSize: 12,
            ),
            CommonText(
              text: OtherHelper.getTimeFromIso(booking.scheduledFor ?? ""),
              color: AppColors.gray300,
              fontSize: 12,
            ),
          ],
        )
            : Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.orange300,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.orange100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(13),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: CommonText(
            text: booking.status.isEmpty ? 'Unknown' : booking.status[0].toUpperCase() + booking.status.substring(1),
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
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
            CommonText(
              text: 'Payment',
              fontSize: 12,
              color: AppColors.gray300,
            ),

            CommonText(
              text: booking.paymentMethod == 'cash' ? 'Cash' : 'MTN MoMo Pay',
              fontSize: 16,
            ),
          ],
        ),
        const Spacer(),
        CommonText(
          text: booking.price != null
              ? 'GH₵ ${booking.price!.toStringAsFixed(0)}'
              : 'TBD',
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

          if (activityController.selectedIndex.value == 1) {
            Get.to(() => UserScheduleDetailScreen());
          } else if (activityController.selectedIndex.value == 0) {
            if(booking.status == "arrived_pickup"){
              Get.to(()=> RiderArrivedScreen());
            }
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
}


// class ActivityCard extends StatelessWidget {
//   const ActivityCard({super.key});
//
//   static const Color primaryGreen = Color(0xFF00A654);
//   static const Color dividerGrey = Color(0xFFE6E6E6);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               spreadRadius: 1,
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _userRow(),
//             const SizedBox(height: 16),
//
//             // Underline
//             const Divider(color: dividerGrey, thickness: 1),
//             const SizedBox(height: 16),
//             _locationSection(),
//             const SizedBox(height: 24),
//
//             _paymentRow(),
//             const SizedBox(height: 24),
//
//             _viewDetailsButton(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ---------------- USER ROW ----------------
//   Widget _userRow() {
//     return Row(
//       children: [
//         const CircleAvatar(
//           radius: 28,
//           backgroundImage: NetworkImage('https://shorturl.at/WSMrn'),
//         ),
//         const SizedBox(width: 16),
//         const Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Jenny Wilson',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'User',
//                 style: TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//         _circleAction(Icons.chat_bubble_outline),
//         const SizedBox(width: 12),
//         _circleAction(Icons.call_outlined),
//       ],
//     );
//   }
//
//   Widget _circleAction(IconData icon) {
//     return Container(
//       width: 40,
//       height: 40,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: primaryGreen),
//       ),
//       child: Icon(icon, color: primaryGreen, size: 20),
//     );
//   }
//
//   // ---------------- LOCATION SECTION ----------------
//   Widget _locationSection() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             const Icon(Icons.radio_button_checked,
//                 color: primaryGreen, size: 18),
//             _verticalDottedLine(),
//             const Icon(Icons.location_on,
//                 color: primaryGreen, size: 20),
//           ],
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 '85 Ave, Street Side Road, Accra, Ghana',
//                 style: TextStyle(fontSize: 15),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   Expanded(
//                       child: _horizontalDottedLineN()),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.08),
//                           spreadRadius: 3,
//                           blurRadius: 8,
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: const Text(
//                         '22.6 KM',
//                         style: TextStyle(
//                           color: Color(0xFF00A654),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 '1901 Thornridge Road, Accra, Ghana',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _verticalDottedLine() {
//     return SizedBox(
//       height: 50,
//       child: CustomPaint(painter: DottedLinePainter(primaryGreen, true)),
//     );
//   }
//
//   // ---------------- PAYMENT ----------------
//   Widget _paymentRow() {
//     return Row(
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color(0xFFF5F5F5),
//           ),
//           child: const Icon(Icons.payment_outlined,
//               color: primaryGreen),
//         ),
//         const SizedBox(width: 12),
//         const Text(
//           'MTN MoMo Pay',
//           style: TextStyle(fontSize: 16),
//         ),
//         const Spacer(),
//         const Text(
//           'GH₵ 50',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: primaryGreen,
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ---------------- BUTTON ----------------
//   Widget _viewDetailsButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           backgroundColor: primaryGreen,
//           elevation: 0,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//         ),
//         child: const Text(
//           'View Details',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//       ),
//     );
//   }
//
//   Widget _horizontalDottedLineN() {
//     return Row(
//       children: List.generate(
//         15,
//             (_) => Expanded(
//           child: Container(
//             height: 1,
//             margin: const EdgeInsets.symmetric(horizontal: 2),
//             color: const Color(0xFFE6E6E6),
//           ),
//         ),
//       ),
//     );
//   }
//
// }