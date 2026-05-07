import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/authController/auth_controller.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import 'package:project_borla/role/components/commonTextField/common_text_field.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../gen/custom_assets/assets.gen.dart';
import '../../theme/auth_header.dart';
import '../../widgets/gradient_button.dart';

class SetPassScreen extends StatefulWidget {
  const SetPassScreen({super.key});

  @override
  State<SetPassScreen> createState() => _SetPassScreenState();
}

class _SetPassScreenState extends State<SetPassScreen> {

  final _authCtrl = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  // helper
  bool get isRider => AuthController.selectedRole.value == 'Rider';

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
                    ? [AppColors.green300, AppColors.green500] // rider
                    : [
                  const Color.fromRGBO(255, 214, 0, 1),
                  const Color.fromRGBO(255, 149, 0, 1),
                ],
              ),
            ),
            child: AuthHeader(
              title: 'set_pass_title'.tr,
              subtitle: 'set_pass_subtitle'.tr,
            ),
          ),

          Positioned(
            top: 0,
            right: -60,
            child: Assets.images.backgroundShadow
                .image(height: 300, width: 400),
          ),

          Container(
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(34)),
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

                    const SizedBox(height: 20),

                    Text(
                      'new_password'.tr,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),

                    const SizedBox(height: 16),

                    CommonTextField(
                      controller: _authCtrl.passController,
                      hintText: 'new_password_hint'.tr,
                      isPassword: true,
                      borderRadius: 14,
                      // ✅ rider uses green border
                      borderColor: isRider
                          ? AppColors.green500
                          : AppColors.primaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'password_required'.tr;
                        }
                        if (value.length < 6) {
                          return 'password_min_length'.tr;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'confirm_password'.tr,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),

                    const SizedBox(height: 16),

                    CommonTextField(
                      controller: _authCtrl.confirmPassController,
                      hintText: 'confirm_password_hint'.tr,
                      isPassword: true,
                      borderRadius: 14,
                      // ✅ rider uses green border
                      borderColor: isRider
                          ? AppColors.green500
                          : AppColors.primaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'confirm_password_required'.tr;
                        }
                        if (value != _authCtrl.passController.text) {
                          return 'passwords_not_match'.tr;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 50),

                    GradientButton(
                      isLoading: _authCtrl.isLoading,
                      text: 'save'.tr,
                      // ✅ rider uses green gradient
                      firstGradient:
                      isRider ? AppColors.green300 : null,
                      secondGradient:
                      isRider ? AppColors.green500 : null,
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;

                        final bool success =
                        await _authCtrl.resetPassword(
                          newPassword: _authCtrl.passController.text,
                          confirmPassword:
                          _authCtrl.confirmPassController.text,
                        );

                        if (success) {
                          Get.offAll(() => LoginScreen());
                        }
                      },
                    ),

                    const SizedBox(height: 24),

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
