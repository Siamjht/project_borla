
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/custom_container.dart';

import '../../../../theme/app_color.dart';
import '../../../components/commonTextField/common_text_field.dart';
import '../../../components/text/common_text.dart';


class TopUpDialog extends StatelessWidget {
  TopUpDialog({super.key});

  TextEditingController topUpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 130,
                height: 5,
                decoration: BoxDecoration(
                    color: AppColors.black100,
                    borderRadius: BorderRadius.circular(100)
                ),
              ),
            ),
            SizedBox(height: 12,),
            /// Title
            const Center(
              child: CommonText(
                text: 'Top Up Balance',
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 24),

            /// Label
            const CommonText(
              text: 'Top Up Amount',
              fontSize: 16,
              color: AppColors.textDark,
              fontWeight: FontWeight.w400,
            ),

            const SizedBox(height: 12),

            /// Input
            CommonTextField(
              controller: topUpController,
              hintText: 'Enter Amount',
              keyboardType: TextInputType.number,
              borderRadius: 4,
              borderColor: AppColors.gray150,
            ),

            const SizedBox(height: 12),

            CommonText(text: "Minimum top up: GH₵ 50"),
            const SizedBox(height: 12),
            /// Warning
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return topUpAmountContainer(amount: 50 * (index+1));
              },),
            ),

            const SizedBox(height: 28),

            /// Action
            CommonButton(
              onTap: () {
                Get.back();
              },
              titleText: "Continue",
              buttonRadius: 4,
            )
          ],
        ),
      ),
    );
  }

  CustomContainer topUpAmountContainer({required int amount}) {
    return CustomContainer(
                borderRadius: 27,
                borderColor: AppColors.black300,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: CommonText(text: "GH₵ $amount", fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textDark,),
              );
  }
}
