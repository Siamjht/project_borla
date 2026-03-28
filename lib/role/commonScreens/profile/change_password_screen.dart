
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/authController/auth_controller.dart';
import 'package:project_borla/theme/common_button_copy.dart';
import '../../../controllers/settingsController/settings_controller.dart';
import '../../../theme/app_color.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../../components/commonTextField/common_text_field.dart';
import '../../components/gradient_scafold.dart';
import '../../components/text/common_text.dart';

class ChangePasswordScreen extends StatelessWidget {
  bool isUser;
  ChangePasswordScreen({super.key, this.isUser = false});

  final _settingsCtrl = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonBackButton(),
                  CommonText(
                    text: 'Change Password',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  SizedBox(width: 50,)
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  children: [
                    // Current Password
                    PasswordField(label: 'Current Password', passController: _settingsCtrl.oldPasswordController ,),
                    SizedBox(height: 20.h),

                    // New Password
                    PasswordField(label: 'New Password',  passController: _settingsCtrl.newPasswordController),
                    SizedBox(height: 20.h),

                    // Confirm Password
                    PasswordField(label: 'Confirm Password',  passController: _settingsCtrl.confirmPasswordController),
                    SizedBox(height: 40,),

                    // Save Button
                    Obx(() => CommonButton(
                      isLoading: _settingsCtrl.isLoading.value,
                      onTap: () {
                        _settingsCtrl.changePassword(context);
                      },
                      titleText: "save".tr,
                      firstGradient: isUser? AppColors.orange300 : AppColors.green500,
                      secondGradient: isUser? AppColors.orange500 : AppColors.green500,
                      buttonRadius: 12,
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable Password Field using CommonTextField
class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.label, required this.passController});
  final String label;

  final dynamic passController;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: widget.label,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        SizedBox(height: 8.h),
        CommonTextField(
          controller: widget.passController,
          hintText: '••••••••',
          isPassword: true,
        ),
      ],
    );
  }
}
