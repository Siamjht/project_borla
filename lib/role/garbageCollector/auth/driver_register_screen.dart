
import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/authController/auth_controller.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import 'package:project_borla/language/language_service.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/commonTextField/common_text_field.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../gen/custom_assets/assets.gen.dart';
import '../../../helpers/other_helper.dart';
import '../../../theme/auth_header.dart';
import '../../components/commonTextField/phone_text_field.dart';
import '../../components/image/shimmer_image_loader.dart';
import '../../components/searchPlaces/address_search_field.dart';
import '../../components/text/common_text.dart';
import 'driver_otp_screen.dart';

class DriverRegisterScreen extends StatefulWidget {
  const DriverRegisterScreen({super.key});

  @override
  State<DriverRegisterScreen> createState() => _DriverRegisterScreenState();
}

class _DriverRegisterScreenState extends State<DriverRegisterScreen> {

  final _authCtrl = Get.put(AuthController());
  RxBool isOpeningGallery = false.obs;

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
                          driverPhoneTextFormField(
                              phoneController: _authCtrl.phoneNumController
                          ), // assuming this widget handles its own hint/label
                          SizedBox(height: 20.h),

                          /// ---------------- DATE OF BIRTH ----------------
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CommonText(
                              text: 'date_of_birth_label'.tr,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: () async {
                              _authCtrl.isoDateController.text = await OtherHelper.openDatePicker(_authCtrl.dobController);
                              log("ISo Date: ${_authCtrl.isoDateController}");
                            },
                            child: AbsorbPointer(
                              child: CommonTextField(
                                controller: _authCtrl.dobController,
                                hintText: 'date_of_birth_hint'.tr,
                                suffixIcon: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: Assets.icons.dobCalenderIcon.image(
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

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
                              child: Assets.icons.locationPointer.image(height: 20, width: 20),
                            ),
                            onSelected: (suggestion) async {
                              final latLang = await OtherHelper.getCoordinatesFromAddress(suggestion.description);
                              log("LatLang $latLang");
                              if(latLang != null){
                                // _ctrl.latitude = latLang.latitude;
                                // _ctrl.longitude = latLang.longitude;
                              }
                            },),

                          SizedBox(height: 20.h),

                          /// ---------------- GHANA CARD ----------------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: 'ghana_card_id_label'.tr,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 8.h),
                              DottedBorder(
                                options: RoundedRectDottedBorderOptions(
                                  radius: const Radius.circular(12),
                                  dashPattern: const [10, 5],
                                  strokeWidth: 2,
                                  padding: const EdgeInsets.all(8),
                                  color: AppColors.gray200,
                                ),
                                child: Obx(() {
                                  return SizedBox(
                                    height: 130.h,
                                    width: double.infinity,
                                    child: GestureDetector(
                                      onTap: () async {
                                        isOpeningGallery.value = true;
                                        final path = await OtherHelper.openGallery();
                                        if (path != null) {
                                          _authCtrl.ghanaICard.value = path; // ✅ only set if not null
                                        }
                                        isOpeningGallery.value = false;
                                      },
                                      child: _authCtrl.ghanaICard.value.isNotEmpty
                                          ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: ShimmerImageLoader(url: _authCtrl.ghanaICard.value, width: double.infinity, height: 130.h),
                                      )
                                          :   isOpeningGallery.value == true? Center(child: CircularProgressIndicator()) : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.cloud_upload_outlined,
                                            size: 32,
                                            color: AppColors.gray300,
                                          ),
                                          SizedBox(height: 8.h),
                                          CommonText(
                                            text: 'upload_button'.tr,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.gray300,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
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
                        buttonRadius: 12,
                        onTap: () async {
                         final success = await _authCtrl.createDriver();
                         if(success){
                           Get.offAll(() => DriverOtpScreen());
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
                                color: AppColors.green500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 300),
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