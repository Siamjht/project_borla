import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

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
              Text('Name', style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),
              const SizedBox(height: 12),
              CustomTextField(
                controller: registerScreenController.registerNameController,
                hint: 'Enter your name',
                //prefix: const Icon(Icons.phone),
              ),

              const SizedBox(height: 24),

              Text('Phone Number', style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),

              const SizedBox(height: 12),

              userPhoneTextFormField(
                  controller: registerScreenController.registerPhoneController,
              ),

              const SizedBox(height: 24),

              Text('Email', style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),

              const SizedBox(height: 12),

              CustomTextField(
                controller: registerScreenController.registerEmailController,
                hint: 'Enter your email',
                prefix: const Icon(Icons.email),
              ),

              const SizedBox(height: 24),

              Text('Location', style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),

              const SizedBox(height: 12),

              CustomTextField(
                controller: registerScreenController.registerLocationController,
                hint: 'Enter your location',
                prefix: const Icon(Icons.location_on_outlined),
              ),

              const SizedBox(height: 24),

              Text('Password', style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),

              const SizedBox(height: 12),

              CustomTextField(
                controller: registerScreenController.registerPassController,
                hint: 'Password',
                obscureText: true,
                suffix: const Icon(Icons.visibility_off),
              ),

              const SizedBox(height: 24),

              Text(' Confirm Password', style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),

              const SizedBox(height: 12),

              CustomTextField(
                controller: registerScreenController.registerConfirmPassController,
                hint: 'Password',
                obscureText: true,
                suffix: const Icon(Icons.visibility_off),
              ),

              const SizedBox(height: 32),

              GradientButton(
                text: 'Sign Up',
                onPressed: () {
                  Get.to(()=> OtpScreen());
                },
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or continue with',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),

              const SizedBox(height: 30),

              SocialLoginButton(
                text: 'Continue with Google',
                asset: 'assets/images/google.png',
                onPressed: () {},
              ),

              const SizedBox(height: 16),

              SocialLoginButton(
                text: 'Continue with Apple',
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

