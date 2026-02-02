
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/custom_container.dart';

import '../../../../theme/app_color.dart';
import '../../../components/commonTextField/common_text_field.dart';
import '../../../components/text/common_text.dart';


class WithdrawDialog extends StatelessWidget {
  WithdrawDialog({super.key});

  TextEditingController withdrawController = TextEditingController();

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
                text: 'Withdraw',
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 24),

            /// Label
            const CommonText(
              text: 'Withdraw Amount',
              fontSize: 16,
              color: AppColors.textDark,
              fontWeight: FontWeight.w400,
            ),

            const SizedBox(height: 12),

            /// Input
            CommonTextField(
              controller: withdrawController,
              hintText: 'Enter Amount',
              keyboardType: TextInputType.number,
              borderRadius: 4,
              borderColor: AppColors.gray150,
            ),

            const SizedBox(height: 20),

            /// Warning
            CustomContainer(
              borderRadius: 6,
              borderColor: AppColors.yellow500,
              color: AppColors.yellow50,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  const Icon(Icons.info_outline, color: AppColors.olive500),
                  Expanded(
                    child: CommonText(
                      textAlign: TextAlign.start,
                      text:
                      'Keep \$20 minimum for cash ride commissions',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.olive500,
                    ),
                  ),
                ],
              ),
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
}

