import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/payment_controller.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/app_color.dart';
import '../../widgets/booking-accepted-sheet-widgets/user_section_widget.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/rider-arrived-sheet-widget/user_payment_row_widget.dart';
import '../rider-review-screen/rider_review_screen.dart';

class RiderArrivedSheet extends StatefulWidget {
  final UserBookingModel booking;

  const RiderArrivedSheet({super.key, required this.booking});

  @override
  State<RiderArrivedSheet> createState() => _RiderArrivedSheetState();
}

class _RiderArrivedSheetState extends State<RiderArrivedSheet> {
  final PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,

      children: [
        Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),

          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 46),

              const Text(
                'Rider Have Arrived',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                child: Divider(color: Colors.grey.shade300, thickness: 1),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: userSectionWidget(rider: widget.booking.rider),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                child: Divider(color: Colors.grey.shade300, thickness: 1),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: summarySection(booking: widget.booking),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                child: Divider(color: Colors.grey.shade300, thickness: 1),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: userPaymentRow(booking: widget.booking),
              ),

              Padding(
                padding: const EdgeInsets.all(22.0),
                child: GradientButton(
                  isLoading: paymentController.isLoading,
                  text: 'Pay Now',
                  onPressed: () async {
                    final isSuccess = await paymentController.initiatePayment(
                      bookingId: widget.booking.id,
                      isCash: widget.booking.paymentMethod == 'cash',
                    );

                    if (isSuccess) {
                      Get.dialog(
                        barrierDismissible: false,
                        buildPaymentSuccessDialog(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          height: 90,
          width: 90,
          top: -50,
          left: MediaQuery.of(context).size.width / 2 - 45,
          child: Image.asset('assets/images/user_large_pin_2.png', scale: 6.4),
        ),
      ],
    );
  }

  AlertDialog buildPaymentSuccessDialog() {
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
                    "sent to ${widget.booking.rider.name}",
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
                        Get.to(() => RiderReviewScreen());
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

  // ── Summary Section ───────────────────────────────────────────
  Widget summarySection({required UserBookingModel booking}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonText(
                text: 'Total Price',
                fontSize: 13,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              CommonText(
                text: 'GH₵ ${booking.price.toStringAsFixed(2)}',
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
              const CommonText(
                text: 'Total Distance',
                fontSize: 13,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              CommonText(
                text: '${booking.estimatedDistance.toStringAsFixed(1)} KM',
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
              const CommonText(
                text: 'Avg. Time',
                fontSize: 13,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              CommonText(
                text: booking.estimatedTime,
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
}
