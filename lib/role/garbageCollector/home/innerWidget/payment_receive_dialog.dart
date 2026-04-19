
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/navBar/nav_bar.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../../../../theme/app_color.dart';
import '../../../components/button/common_button.dart';
import '../../../components/text/common_text.dart';
import '../../activity/controller/activity_controller.dart';
import '../../activity/innerWidget/common_widgets.dart';
import '../navigate_station_screen.dart';


class PaymentReceiveDialog extends StatelessWidget {
  RiderBookingModel booking;
  PaymentReceiveDialog({super.key, required this.booking});


  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      Assets.icons.paymentSuccess
                          .image(height: 72, width: 72),

                      const SizedBox(height: 16),

                      const CommonText(
                        text: 'Payment Receive',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      // ✅ real user name
                      CommonText(
                        text:
                        'You successfully receive payment \nfrom ${booking.user.name}',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        lineHeight: 1.5,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),
                      const Divider(color: AppColors.black50, thickness: 1),
                      const SizedBox(height: 8),

                      locationSection(booking),

                      const SizedBox(height: 8),
                      const Divider(color: AppColors.black50, thickness: 1),
                      const SizedBox(height: 8),

                      paymentRow(booking),

                      const SizedBox(height: 16),

                      Obx(() => CommonButton(
                        isLoading: ActivityController.instance.isPaymentCollectionLoading.value,
                        onTap: () {
                          log("Booking status: ${booking.status}");
                          if(booking.status == "payment_collected"){
                            Get.offAll(() => NavigateStationScreen(booking: booking,));
                          }else{
                            ActivityController.instance.paymentCollection(bookingId: booking.id);
                          }
                        },
                        buttonRadius: 12,
                        titleText: 'Confirm Payment',
                      )),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Assets.images.patternLeft.image(scale: 0.8),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Assets.images.patternRight.image(scale: 0.7),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
