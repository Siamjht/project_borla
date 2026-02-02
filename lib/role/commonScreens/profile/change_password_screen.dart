
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../../components/commonTextField/common_text_field.dart';
import '../../components/gradient_scafold.dart';
import '../../components/text/common_text.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

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
                    PasswordField(label: 'Current Password', passController: _currentPassController ,),
                    SizedBox(height: 20.h),

                    // New Password
                    PasswordField(label: 'New Password',  passController: _newPassController),
                    SizedBox(height: 20.h),

                    // Confirm Password
                    PasswordField(label: 'Confirm Password',  passController: _confirmPassController),
                    SizedBox(height: 40,),

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
                          backgroundColor: const Color(0xFF4CAF50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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
