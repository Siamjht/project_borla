
import 'package:flutter/material.dart';
import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../role/components/text/common_text.dart';



class ApplicationReviewDialog extends StatelessWidget {
  const ApplicationReviewDialog({super.key});

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
                      Assets.icons.applicationReview.image(height: 72, width: 72),

                      const SizedBox(height: 32),
                      // Title
                      const CommonText(
                        text: 'Application Under Review',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // Description
                      CommonText(
                        text:
                        'We\'re reviewing your documents. This usually takes 24-48 hours.',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        lineHeight: 1.5,
                        textAlign: TextAlign.center,
                      ),
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
