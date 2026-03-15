
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/authController/auth_controller.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import 'package:project_borla/language/language_service.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/commonTextField/common_text_field.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../gen/custom_assets/assets.gen.dart';
import '../../../theme/auth_header.dart';
import '../../../widgets/social_login_button.dart';
import '../../commonScreens/profile/innerWidget/profile_items.dart';
import 'driver_otp_screen.dart';

class DriverRegisterScreen extends StatefulWidget {
  const DriverRegisterScreen({super.key});

  @override
  State<DriverRegisterScreen> createState() => _DriverRegisterScreenState();
}

class _DriverRegisterScreenState extends State<DriverRegisterScreen> {

  final _authCtrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.green500,
                  AppColors.green500,
                ],
              ),
            ),
            child: AuthHeader(
              title: 'create_your_new_account'.tr,
              subtitle: 'register_now_and_explore'.tr,
            ),
          ),

          Positioned(
            top: 0,
            right: -60,
            child: Assets.images.backgroundShadow.image(height: 300, width: 400),
          ),

          Positioned(
            top: LanguageService.setLang == 'en'? 230 : 210,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
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

                      profileItems(context, _authCtrl),

                      const SizedBox(height: 24),

                      Text(
                        'password'.tr,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),

                      const SizedBox(height: 12),
                      CommonTextField(
                        controller: _authCtrl.passController,
                        hintText: 'password_hint'.tr,
                        isPassword: true,
                      ),

                      const SizedBox(height: 24),

                      Text(
                        'confirm_password'.tr,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),

                      const SizedBox(height: 12),
                      CommonTextField(
                        controller: _authCtrl.confirmPassController,
                        hintText: 'confirm_password_hint'.tr,
                        isPassword: true,
                      ),

                      const SizedBox(height: 32),

                      CommonButton(
                        titleText: 'sign_up'.tr,
                        buttonRadius: 12,
                        onTap: () {
                          _authCtrl.createUser();
                        },
                      ),

                      const SizedBox(height: 30),

                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'or_continue_with'.tr,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // SocialLoginButton(
                      //   text: 'continue_with_google'.tr,
                      //   asset: 'assets/images/google.png',
                      //   onPressed: () {},
                      // ),
                      //
                      // const SizedBox(height: 16),
                      //
                      // SocialLoginButton(
                      //   text: 'continue_with_apple'.tr,
                      //   asset: 'assets/images/apple_2.png',
                      //   onPressed: () {},
                      // ),
                      //
                      // const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'already_have_account'.tr,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offAll(() => LoginScreen());
                            },
                            child: Text(
                              'sign_in'.tr,
                              style: const TextStyle(
                                color: AppColors.green500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 70),
                    ],
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