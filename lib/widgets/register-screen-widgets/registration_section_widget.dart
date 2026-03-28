import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/authController/auth_controller.dart';
import 'package:project_borla/role/components/commonTextField/common_text_field.dart';
import 'package:project_borla/role/components/commonTextField/phone_text_field.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/otp_screen_two.dart';
import '../../gen/custom_assets/assets.gen.dart';
import '../../helpers/other_helper.dart';
import '../../role/components/button/common_button.dart';
import '../../role/components/searchPlaces/address_search_field.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/app_color.dart';


class RegistrationSection extends StatelessWidget {
  RegistrationSection({
    super.key,
  });

  final _authCtrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: 'name_label'.tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CommonTextField(
                    hintText: 'enter_name_hint'.tr,
                    controller: _authCtrl.nameController,
                  ),
                  SizedBox(height: 20.h),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: 'email'.tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CommonTextField(
                    hintText: 'enter_your_email'.tr,
                    controller: _authCtrl.emailController,
                  ),
                  SizedBox(height: 20.h),

                  /// ----------------- Phone Field -----------------
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: 'phone_number_label'.tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  userPhoneTextFormField(controller: _authCtrl.phoneNumController
                  ), // assuming this widget handles its own hint/label
                  SizedBox(height: 20.h),


                  /// ---------------- LOCATION ----------------
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: 'location_label'.tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  AddressSearchField(
                    hintText: 'enter_location_hint'.tr,
                    controller: _authCtrl.addressController,
                    textInputAction: TextInputAction.done,
                    fillColor: Colors.white,
                    borderColor: const Color(0xFFE5E7EB),
                    hintTextColor: AppColors.gray400,
                    textColor: AppColors.black500,
                    borderRadius: 16,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Assets.icons.location.image(height: 20, width: 20),
                    ),
                    onSelected: (suggestion) async {
                      final latLang = await OtherHelper.getCoordinatesFromAddress(suggestion.description);
                      log("LatLang $latLang");
                      if(latLang != null){
                        // _ctrl.latitude = latLang.latitude;
                        // _ctrl.longitude = latLang.longitude;
                      }
                    },),

                ],
              ),

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

              Obx(() => CommonButton(
                isLoading: _authCtrl.isLoading.value,
                titleText: 'sign_up'.tr,
                firstGradient: AppColors.orange300,
                secondGradient: AppColors.orange500,
                buttonRadius: 12,
                onTap: () async {
                  final success = await _authCtrl.createUser();
                  if(success){
                    Get.to(() => OtpScreen(isSignup: true,));
                  }
                },
              ),),

              const SizedBox(height: 30),

              // Row(
              //   children: [
              //     Expanded(child: Divider(color: Colors.grey.shade300)),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 12),
              //       child: Text(
              //         'or_continue_with'.tr,
              //         style: const TextStyle(color: Colors.grey),
              //       ),
              //     ),
              //     Expanded(child: Divider(color: Colors.grey.shade300)),
              //   ],
              // ),

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
                        color: AppColors.orange500,
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
    );
  }
}

