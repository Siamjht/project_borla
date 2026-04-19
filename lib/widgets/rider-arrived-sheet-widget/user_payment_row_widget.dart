
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/payment_controller.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';
import 'package:project_borla/role/components/custom_container.dart';
import '../../bottom-sheets/payment_sheet.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/app_color.dart';

Widget userPaymentRow({required UserBookingModel booking, required BuildContext context}) {

  final PaymentController paymentController = Get.find<PaymentController>();

  return Obx(() {
    paymentController.isMomo.value = booking.paymentMethod != 'cash';
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
          child: paymentController.isMomo.value ?
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
              text: paymentController.isMomo.value ? 'MTN Momo Pay' : 'Cash on Arrival',
              fontSize: 16,
            ),
          ],
        ),
        const Spacer(),


        InkWell(
          onTap: () {
            paymentController.isPaymentPicked.value = true ;
            showModalBottomSheet(

              context: context,
              barrierColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              //showDragHandle: true,
              useSafeArea: true,
              builder: (context) => PaymentSheet(booking: booking,),

            );
          },
          child: CustomContainer(
              color: AppColors.orange100,
              borderRadius: 50,
              padding: EdgeInsets.all(12),
              child: Icon(Icons.arrow_forward_ios, size: 16)),
        )

      ],
    );
  },);
}
