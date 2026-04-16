
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/payment_controller.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';
import '../../role/components/text/common_text.dart';
import '../../screens/choose-payment-screens/choose_payment_screen.dart';
import '../../theme/app_color.dart';

Widget userPaymentRow({required UserBookingModel booking}) {

  final PaymentController paymentController = Get.put(PaymentController());

  bool isMomo = booking.paymentMethod != 'cash';

  return Row(
    children: [
      const SizedBox(width: 12),
      Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.gray200,
        ),
        child: isMomo ?
        Image.asset('assets/images/payment_2.png', scale: 3.8,) : Image.asset('assets/images/cash_2.png',),
      ),
      const SizedBox(width: 12),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            text: "Payment",
            fontSize: 12,
            color: AppColors.gray300,
          ),
          CommonText(
            text: isMomo ? 'MTN MoMo Pay' : 'Cash on Arrival',
            fontSize: 16,
          ),
        ],
      ),
      const Spacer(),

      IconButton(
          onPressed: (){
            paymentController.isPaymentPicked.value = true ;
            Get.to(()=> ChoosePaymentScreen());
          },
          icon: const Icon(Icons.arrow_forward_ios, size: 16)
      )

    ],
  );
}
