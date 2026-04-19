import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/date_time_picker_controller.dart';
import 'package:project_borla/controllers/user-controllers/payment_controller.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';
import 'package:project_borla/screens/rider-searching-screen/rider_searching_screen.dart';

import '../controllers/user-controllers/booking_controller.dart';
import '../role/components/customSnackbar/custom_snackbar.dart';
import '../widgets/gradient_button.dart';

class PaymentSheet extends StatefulWidget {
  UserBookingModel? booking;
  PaymentSheet({super.key, this.booking});

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  final paymentCtrl = Get.find<PaymentController>();
  final dateTimeCtrl = Get.find<DateTimePickerController>();
  final bookingCtrl = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [

          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 16),
          Text(
            'Choose Payment Method',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
            child: Divider(color: Colors.grey.shade300, thickness: 1),
          ),
          const SizedBox(height: 16),

          // ── Payment Options ───────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 6, 22, 6),
            child: Obx(() => Row(
              children: [

                // ── MoMo ───────────────────────────────────
                Expanded(
                  child: InkWell(
                    onTap: () {
                      bookingCtrl.selectedIndex.value = 1;
                      bookingCtrl.selectedPaymentMethod.value = 'hubtel';
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: bookingCtrl.selectedIndex.value == 1
                              ? Colors.amber
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Center(
                        child: Image.asset('assets/images/momo_2.png', scale: 5),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // ── Cash ────────────────────────────────────
                Expanded(
                  child: InkWell(
                    onTap: () {
                      bookingCtrl.selectedIndex.value = 2;
                      bookingCtrl.selectedPaymentMethod.value = 'cash';
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: bookingCtrl.selectedIndex.value == 2
                              ? Colors.amber
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/cash_2.png', scale: 0.9),
                          SizedBox(width: 8),
                          Text(
                            'Cash',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            )),
          ),

          // ── Continue Button ───────────────────────────────
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: GradientButton(
              text: 'Continue',
              onPressed: () {
                if (bookingCtrl.selectedIndex.value == -1) {
                  CustomSnackbar.error('Please select a payment method');
                  return;
                }
                log("bookingCtrl.selectedIndex.value ${bookingCtrl.selectedIndex.value}");

                if(widget.booking != null){
                  widget.booking!.paymentMethod = bookingCtrl.selectedPaymentMethod.value;
                  paymentCtrl.isMomo.value = widget.booking!.paymentMethod != 'cash';
                  Navigator.pop(context);
                }else{
                  Get.to(() => RiderSearchingScreen());
                }

              },
            ),
          ),

        ],
      ),
    );
  }
}
