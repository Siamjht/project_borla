

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:project_borla/screens/profile-screens/ps-controllers/profile_controller_copy.dart';
import '../../theme/common_back_button_copy.dart';
import '../../theme/common_text_field_copy.dart';
import '../../theme/common_text_two.dart';
import '../../theme/gradient_scaffold_copy.dart';

class UserChangePasswordScreen extends StatelessWidget {
  UserChangePasswordScreen({super.key});

  ProfileControllerCopy profileControllerCopy = Get.put(ProfileControllerCopy());

  // final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [

              Row(
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
              SizedBox(height: 40,),
              // Current Password
              PasswordField(label: 'Current Password', passController: profileControllerCopy.passController ),
              SizedBox(height: 20.h),

              // New Password
              PasswordField(label: 'New Password', passController: profileControllerCopy.passController ),
              SizedBox(height: 20.h),

              // Confirm Password
              PasswordField(label: 'Confirm Password', passController: profileControllerCopy.passController ),
              const Spacer(),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: CommonText(
                          text: 'Password changed successfully',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    elevation: 0,
                  ),
                  child: const CommonText(
                    text: 'Save',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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

  TextEditingController passController = TextEditingController();

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
          controller: passController,
          hintText: '••••••••',
          isPassword: true,
        ),
      ],
    );
  }
}
