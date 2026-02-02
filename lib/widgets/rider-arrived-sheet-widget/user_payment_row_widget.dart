import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../controllers/user-controllers/bottom-sheet-controllers/choose_payment_sheet_controllers.dart';
import '../../role/components/text/common_text.dart';
import '../../screens/choose-payment-screens/choose_payment_screen.dart';
import '../../theme/app_color.dart';

Widget userPaymentRow() {

  ChoosePaymentSheetControllers paymentController = Get.put(ChoosePaymentSheetControllers());

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
        child: paymentController.selectedIndex.value==1?
        Image.asset('assets/images/payment_2.png', scale: 3.8,) : Image.asset('assets/images/cash_2.png',),
      ),
      const SizedBox(width: 12),

      paymentController.selectedIndex.value==1?
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            text: "Payment",
            fontSize: 12,
            color: AppColors.gray300,
          ),
          const CommonText(
            text: 'MTN MoMo Pay',
            fontSize: 16,
          ),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            text: "Payment",
            fontSize: 12,
            color: AppColors.gray300,
          ),
          const CommonText(
            text: 'Cash on Arrival',
            fontSize: 16,
          ),
        ],
      ),
      const Spacer(),

      IconButton(
          onPressed: (){
            paymentController.isPaymentPicked.value = true ;
            //???????????
            Get.to(()=> ChoosePaymentScreen());
          },
          icon: Icon(Icons.arrow_forward_ios)
      )

    ],
  );
}