
import 'package:flutter/material.dart';
import 'package:project_borla/role/garbageCollector/home/innerWidget/waste_drop_completed_dialog.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../components/button/common_button.dart';
import '../../../components/text/common_text.dart';

class ArriveAtStationDialog extends StatelessWidget {
  const ArriveAtStationDialog({super.key});

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
                      Assets.icons.arriveLocationIcon.image(height: 72, width: 72),

                      const SizedBox(height: 16),
                      // Title
                      const CommonText(
                        text: 'Arrive at Station',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // Description
                      CommonText(
                        text: "You've arrived!, The station is ready to receive your waste",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        lineHeight: 1.5,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      CommonButton(
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => const WasteDropCompletedDialog(),
                          );
                        },
                        buttonRadius: 12,
                        titleText: "Collect Payment",
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