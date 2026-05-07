import 'package:flutter/material.dart';
import 'package:project_borla/controllers/authController/auth_controller.dart';
import '../../theme/app_color.dart';
import '../../theme/auth_header.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';
import 'otp_screen_two.dart';
import 'package:get/get.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {

  final _authCtrl = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  // ✅ helper
  bool get isRider => AuthController.selectedRole.value == 'Rider';

  Future<void> formOnSubmit() async {
    if (formKey.currentState!.validate()) {
      final bool success =
      await _authCtrl.forgotPassword(_authCtrl.emailController.text);
      if (success) {
        Get.to(() => OtpScreen(isSignup: false));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isRider
                    ? [AppColors.green300, AppColors.green500] // ✅ rider
                    : [
                  const Color.fromRGBO(255, 214, 0, 1),
                  const Color.fromRGBO(255, 149, 0, 1),
                ],
              ),
            ),
            child: AuthHeader(
              title: 'forgot_title'.tr,
              subtitle: 'forgot_subtitle'.tr,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
              color: Colors.white,
            ),
            height: 630,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 26),
                    Text(
                      'email_id'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: _authCtrl.emailController,
                      hint: 'email_hint'.tr,
                      prefix: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 40),
                    GradientButton(
                      isLoading: _authCtrl.isLoading,
                      text: 'send_code'.tr,
                      // ✅ rider uses green gradient
                      firstGradient: isRider ? AppColors.green300 : null,
                      secondGradient: isRider ? AppColors.green500 : null,
                      onPressed: formOnSubmit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
