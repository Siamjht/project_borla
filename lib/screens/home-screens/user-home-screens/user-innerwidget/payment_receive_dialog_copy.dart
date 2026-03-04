
import 'package:flutter/material.dart';


import '../../../../role/components/text/common_text.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/common_button_copy.dart';
import '../../../../utils/custom-gen-assets/assets.gen.dart';

import 'arrived_bottom_sheet_copy.dart';

import 'common_widgets_copy.dart';

class PaymentReceiveDialog extends StatelessWidget {
  const PaymentReceiveDialog({super.key});

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
            // Envelope Icon with Notification Badge
            Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      Assets.icons.paymentSuccess.image(height: 72, width: 72),

                      const SizedBox(height: 16),
                      // Title
                      const CommonText(
                        text: 'Payment Receive',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // Description
                      CommonText(
                        text: 'You successfully receive payment \nform Jenny Wilson',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        lineHeight: 1.5,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: AppColors.black50, thickness: 1),
                      const SizedBox(height: 8),
                      bottomSheetLocationSection(),
                      const SizedBox(height: 8),
                      const Divider(color: AppColors.black50, thickness: 1),
                      const SizedBox(height: 8),
                      paymentRow(),
                      const SizedBox(height: 16),
                      CommonButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        buttonRadius: 12,
                        titleText: "Finish Ride",
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Assets.images.patternLeft.image(scale: 0.8)
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Assets.images.patternRight.image(scale: 0.7)
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}