

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../../gen/custom_assets/assets.gen.dart';


class PulsingCircleWithIcon extends StatelessWidget {
  const PulsingCircleWithIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _dottedPulse(80, 60),
        _dottedPulse(150, 70),
        _dottedPulse(200, 80),

        Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.green100,
              shape: BoxShape.circle,
            ),
            child: Assets.icons.driverIcon.image(color: AppColors.green500, height: 40, width: 50 )
        ),
      ],
    );
  }

  Widget _dottedPulse(double size, int opacity) {
    return DottedBorder(
      options: CircularDottedBorderOptions(
        dashPattern: const [12, 8],        // dash length, gap length
        strokeWidth: 2,                    // thickness of dashes
        color: AppColors.green500.withAlpha(opacity),
        padding: EdgeInsets.zero,          // spacing inside the border
        strokeCap: StrokeCap.round,        // round ends
      ),
      child: SizedBox(
        width: size,
        height: size,
      ),
    );
  }
}