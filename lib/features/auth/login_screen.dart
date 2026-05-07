import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/authController/auth_controller.dart';
import 'package:project_borla/helpers/other_helper.dart';
import 'package:project_borla/role/components/commonTextField/common_text_field.dart';
import 'package:project_borla/theme/auth_header.dart';
import '../../gen/custom_assets/assets.gen.dart';
import '../../theme/app_color.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/login-screen-widgets/login_screen_widgets.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _authCtrl = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  bool agree = false;

  // ✅ helper to check role
  bool get isRider => AuthController.selectedRole.value == 'Rider';

  void formOnSubmit() {
    if (formKey.currentState!.validate()) {
      _authCtrl.login(
        email: _authCtrl.emailController.text,
        password: _authCtrl.passController.text,
      );
    } else {
      debugPrint('Form is Invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    log("AuthController.selectedRole.value: ${AuthController.selectedRole.value}");

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
                ], // ✅ user
              ),
            ),
            child: AuthHeader(
              title: 'welcome_back'.tr,
              subtitle: 'sign_in_to_continue'.tr,
            ),
          ),
          Positioned(
            top: 0,
            right: -60,
            child: Assets.images.backgroundShadow
                .image(height: 300, width: 400),
          ),
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(34),
                  ),
                  color: Colors.white,
                ),
                height: 666,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Email'.tr,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        CommonTextField(
                          controller: _authCtrl.emailController,
                          hintText: 'Email',
                          validator: OtherHelper.emailValidator,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'password'.tr,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        CommonTextField(
                          controller: _authCtrl.passController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password_required'.tr;
                            }
                            return null;
                          },
                          hintText: 'password'.tr,
                          isPassword: true,
                        ),

                        CheckboxSection(
                          value: agree,
                          onChanged: (val) {
                            setState(() {
                              agree = val;
                              _authCtrl.keepLoggedIn.value = val;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        GradientButton(
                          isLoading: _authCtrl.isLoading,
                          text: 'log_in'.tr,
                          firstGradient: isRider
                              ? AppColors.green300
                              : null,
                          secondGradient: isRider
                              ? AppColors.green500
                              : null,
                          onPressed: formOnSubmit,
                        ),

                        const SizedBox(height: 24),

                        DontHaveAccountSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
