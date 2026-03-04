import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/role/components/commonTextField/common_text_field.dart';

import '../../controllers/user-controllers/auth_controller.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/otp_screen_two.dart';
import '../../role/components/commonTextField/phone_text_field.dart';
import '../custom_text_field.dart';
import '../gradient_button.dart';
import '../social_login_button.dart';
import 'already_have_account_widget.dart';

class RegistrationSection extends StatelessWidget {
  const RegistrationSection({
    super.key,
    required this.registerScreenController,
  });

  final UserAuthController registerScreenController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(34)
        ),
        color: Colors.white,
      ),
      height: 666,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text('name'.tr, style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),
              const SizedBox(height: 12),
              CommonTextField(
                controller: registerScreenController.registerNameController,
                hintText: 'enter_your_name'.tr,
                //prefix: const Icon(Icons.phone),
              ),

              const SizedBox(height: 24),

              Text('phone_number'.tr, style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),

              const SizedBox(height: 12),

              userPhoneTextFormField(
                  controller: registerScreenController.registerPhoneController,
              ),

              const SizedBox(height: 24),

              Text('email'.tr, style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),

              const SizedBox(height: 12),

              CommonTextField(
                controller: registerScreenController.registerEmailController,
                hintText: 'enter_your_email'.tr,
                prefixIcon: const Icon(Icons.email),
              ),

              const SizedBox(height: 24),

              Text('location'.tr, style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),

              const SizedBox(height: 12),

              CommonTextField(
                controller: registerScreenController.registerLocationController,
                hintText: 'enter_your_location'.tr,
                prefixIcon: const Icon(Icons.location_on_outlined),
              ),

              const SizedBox(height: 24),

              Text('password'.tr, style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),

              const SizedBox(height: 12),

              CommonTextField(
                controller: registerScreenController.registerPassController,
                hintText: 'password_hint'.tr,
                isPassword: true,
              ),

              const SizedBox(height: 24),

              Text('confirm_password'.tr, style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),

              const SizedBox(height: 12),

              CommonTextField(
                controller: registerScreenController.registerConfirmPassController,
                hintText: 'confirm_password_hint'.tr,
                isPassword: true,
              ),

              const SizedBox(height: 32),

              GradientButton(
                text: 'sign_up'.tr,
                onPressed: () {
                  Get.to(()=> OtpScreen());
                },
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or_continue_with'.tr,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),

              const SizedBox(height: 30),

              SocialLoginButton(
                text: 'continue_with_google'.tr,
                asset: 'assets/images/google.png',
                onPressed: () {},
              ),

              const SizedBox(height: 16),

              SocialLoginButton(
                text: 'continue_with_apple'.tr,
                asset: 'assets/images/apple_2.png',
                onPressed: () {},
              ),

              const SizedBox(height: 12),

              AlreadyHaveAccountSection(),

              const SizedBox(height: 70),

            ],
          ),
        ),
      ),
    );
  }
}

