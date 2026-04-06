import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/controllers/date_time_picker_controller.dart';
import 'package:project_borla/controllers/user-controllers/bottom-sheet-controllers/choose_payment_sheet_controllers.dart';
import 'package:project_borla/screens/ride-schedule-screens/ride_schedule_screen.dart';
import 'package:project_borla/screens/rider-arrived-screens/rider_arrived_screen.dart';
import 'package:project_borla/screens/rider-searching-screen/rider_searching_screen.dart';

import '../controllers/user-controllers/booking_controller.dart';
import '../role/components/customSnackbar/custom_snackbar.dart';
import '../screens/waste-screens/waste_category_screen.dart';
import '../widgets/gradient_button.dart';

class PaymentSheet extends StatefulWidget {
  const PaymentSheet({super.key});

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  // final ChoosePaymentSheetControllers paymentController = Get.put(ChoosePaymentSheetControllers());
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
                      bookingCtrl.selectedPaymentMethod.value = 'momo';
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
                if (bookingCtrl.selectedIndex.value == 0) {
                  CustomSnackbar.error('Please select a payment method');
                  return;
                }
                Get.to(() => RiderSearchingScreen());

                // if (bookingCtrl.isPaymentPicked.value == true) {
                //   Get.to(() => RiderArrivedScreen());
                // } else if (controller.isSetScheduled.value) {
                //   Get.to(() => RideScheduleScreen());
                // } else {
                //   Get.to(() => RiderSearchingScreen());
                // }
              },
            ),
          ),

        ],
      ),
    );
  }
}
