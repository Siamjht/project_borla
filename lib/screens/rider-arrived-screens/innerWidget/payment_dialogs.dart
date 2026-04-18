
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';

import '../../../theme/app_color.dart';
import '../../../widgets/gradient_button.dart';
import '../../home-screens/user_nav_bar.dart';
import '../../rider-review-screen/rider_review_screen.dart';

AlertDialog buildPaymentSuccessDialog({required UserBookingModel booking}) {
  return AlertDialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    backgroundColor: AppColors.white,
    contentPadding: EdgeInsets.zero,
    content: SizedBox(
      width: Get.width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24),

                Image.asset(
                  'assets/images/wave_tick_amber.png',
                  scale: 0.2,
                  height: 85,
                  width: 85,
                ),

                SizedBox(height: 24),

                Text(
                  'Payment Success',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 20),

                Text(
                  "Your money has been successfully",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                //SizedBox(height: 30,),
                Text(
                  "sent to ${booking.rider.name}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                  child: GradientButton(
                    text: 'Back to Home',
                    onPressed: () {
                      Get.offAll(() => UserNavBar());
                    },
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 2,
            left: 4,
            child: Image.asset('assets/images/amber_left_2.png', scale: 4),
          ),

          Positioned(
            top: 1,
            right: 4,
            child: Image.asset('assets/images/amber_right_2.png', scale: 4),
          ),
        ],
      ),
    ),
  );
}

AlertDialog buildPaymentReceivedDialog({required UserBookingModel booking}) {
  return AlertDialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    backgroundColor: AppColors.white,
    contentPadding: EdgeInsets.zero,
    content: SizedBox(
      width: Get.width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24),

                Image.asset(
                  'assets/images/wave_tick_amber.png',
                  scale: 0.2,
                  height: 85,
                  width: 85,
                ),

                SizedBox(height: 24),

                Text(
                  'Payment Received',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 20),

                Text(
                  "Your money has been received by",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                //SizedBox(height: 30,),
                Text(
                  "garbage collector:${booking.rider.name}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                  child: GradientButton(
                    text: 'Please Feedback',
                    onPressed: () {
                      Get.to(() => RiderReviewScreen(booking: booking));
                    },
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 2,
            left: 4,
            child: Image.asset('assets/images/amber_left_2.png', scale: 4),
          ),

          Positioned(
            top: 1,
            right: 4,
            child: Image.asset('assets/images/amber_right_2.png', scale: 4),
          ),
        ],
      ),
    ),
  );
}
