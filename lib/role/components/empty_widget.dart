import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_borla/role/components/text/common_text.dart';

import '../../theme/app_color.dart';

class EmptyStateWidget extends StatelessWidget {
  final double height;
  final Widget? icon;
  final String message;
  final String? subMessage;

  const EmptyStateWidget({
    super.key,
    this.height = 260,
    this.icon,
    this.message = 'No data found',
    this.subMessage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icon or Image ──
            if (icon != null) icon!,

            12.verticalSpace,

            // ── Message ──
            CommonText(
              text: message,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.gray400,
            ),

            // ── Sub Message ──
            if (subMessage != null) ...[
              4.verticalSpace,
              CommonText(
                text: subMessage!,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.gray200,
              ),
            ],
          ],
        ),
      ),
    );
  }
}