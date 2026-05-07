
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/custom_container.dart';

import '../../../../theme/app_color.dart';
import '../../../components/commonTextField/common_text_field.dart';
import '../../../components/text/common_text.dart';
import '../controller/earnings_controller.dart';


class WithdrawDialog extends StatelessWidget {
  WithdrawDialog({super.key});

  final TextEditingController withdrawController = TextEditingController();
  final EarningsController controller = Get.find<EarningsController>();

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
            const SizedBox(height: 12,),
            /// Title
            Center(
              child: CommonText(
                text: 'withdraw'.tr,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 24),

            /// Label
            CommonText(
              text: 'withdraw_amount'.tr,
              fontSize: 16,
              color: AppColors.textDark,
              fontWeight: FontWeight.w400,
            ),

            const SizedBox(height: 12),

            /// Input
            CommonTextField(
              controller: withdrawController,
              hintText: 'enter_amount_hint'.tr,
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  const Icon(Icons.info_outline, color: AppColors.olive500),
                  Expanded(
                    child: CommonText(
                      textAlign: TextAlign.start,
                      text:
                      'min_withdraw_warning'.tr,
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
            Obx(() => CommonButton(
              isLoading: controller.isWithdrawLoading.value,
              onTap: () async {
                final amountStr = withdrawController.text.trim();
                if (amountStr.isEmpty) {
                  Get.snackbar('error'.tr, 'enter_amount_required'.tr);
                  return;
                }
                final amount = double.tryParse(amountStr);
                if (amount == null || amount <= 0) {
                  Get.snackbar('error'.tr, 'valid_amount_required'.tr);
                  return;
                }
                
                // Using 'momo' as default channel as requested by common practice in this app's context
                final success = await controller.withdraw(channel: 'tigo-gh', amount: amount);
                if(success){
                  Future.delayed(Duration(milliseconds: 300), (){
                    Navigator.pop(context);
                  },);
                }
              },
              titleText: "continue".tr,
              buttonRadius: 4,
            ))
          ],
        ),
      ),
    );
  }
}
