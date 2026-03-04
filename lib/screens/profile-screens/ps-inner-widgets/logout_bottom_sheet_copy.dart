
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import 'package:project_borla/theme/common_button_copy.dart';
import '../../../../theme/app_color.dart';
import '../../../role/components/text/common_text.dart';


void showUserLogoutBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    backgroundColor: Colors.white,
    builder: (_) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.circular(12)
                ),
              ),

              SizedBox(height: 16.h),

              // Title
              const CommonText(
                text: 'Logout',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.red500,
              ),
              SizedBox(height: 16.h),

              Divider(
                color: AppColors.gray200,
              ),
              // Description
              CommonText(
                text:
                'Are you sure you want to logout your \naccount? This action cannot be undone.\nPlease confirm your decision.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.gray300,
                textAlign: TextAlign.center,
                lineHeight: 1.5,
              ),
              SizedBox(height: 40.h),

              // Buttons
              Row(
                spacing: 16,
                children: [
                  // Cancel Button
                  Expanded(
                    child: CommonButton(
                      onTap: () {
                        Get.back();
                      },
                      titleText:  'Cancel',
                      buttonRadius: 12,
                      titleColor: AppColors.orange300,
                      borderColor: AppColors.orange300,
                      firstGradient: AppColors.transparent,
                      secondGradient: AppColors.transparent,
                    ),
                  ),
                  Expanded(
                    child: CommonButton(
                      onTap: () {
                        Get.snackbar("Log out successfully", "", snackPosition: SnackPosition.BOTTOM);
                        Get.offAll(()=> LoginScreen());
                      },
                      titleText:  'Yes, Logout',
                      buttonRadius: 12,
                      titleColor: AppColors.white,
                      firstGradient: AppColors.orange300,
                      secondGradient: AppColors.orange500,
                    ),
                  ),
                  // Logout Button
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
