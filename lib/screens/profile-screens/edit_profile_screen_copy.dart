import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:project_borla/role/components/commonTextField/phone_text_field.dart';
import 'package:project_borla/screens/profile-screens/ps-controllers/profile_controller_copy.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../theme/common_back_button_copy.dart';
import '../../theme/common_button_copy.dart';
import '../../theme/common_text_field_copy.dart';
import '../../theme/common_text_two.dart';
import '../../theme/gradient_scaffold_copy.dart';
import '../../utils/custom-gen-assets/assets.gen.dart';


class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileControllerCopy controller = Get.put(ProfileControllerCopy());

  late PhoneController _phoneController = PhoneController();


  @override
  void initState() {
    super.initState();
    _phoneController = PhoneController(
      initialValue: const PhoneNumber(
        isoCode: IsoCode.GH,
        nsn: '',
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _phoneController.value = const PhoneNumber(
        isoCode: IsoCode.GH,
        nsn: '',
      );
    });

  }

  @override
  void dispose() {
    _phoneController.dispose();
    //_passController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(
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
                    text: 'Edit Profile',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  SizedBox(width: 50,)
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  children: [

                    /// ---------------- PROFILE IMAGE ----------------
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(() {
                          return Container(
                            width: 120.w,
                            height: 120.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.amber,
                                width: 4,
                              ),
                            ),
                            child: ClipOval(
                              child: controller.profileImage.value != null
                                  ? Image.file(
                                controller.profileImage.value!,
                                fit: BoxFit.cover,
                              )
                                  : Center(
                                child: Assets.images.emptyProfile.image(height: 100.w, width: 100.w),
                              ),
                            ),
                          );
                        }),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () =>
                                controller.pickImage(isProfile: true),
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.fadedWhite,
                                border: Border.all(color: AppColors.gray200),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.orangeAccent,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),
                    const CommonText(
                      text: 'Change Your Profile Picture',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.amber,
                    ),

                    SizedBox(height: 32.h),

                    /// ---------------- NAME ----------------
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CommonText(
                        text: 'Name',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CommonTextField(
                      hintText: 'Enter Name',
                      controller: controller.nameController,
                    ),
                    SizedBox(height: 20.h),

                    // Phone Field
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const CommonText(
                        text: 'Phone Number',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // PhoneFormField(
                    //   //controller: _phoneController,
                    //   initialValue: PhoneNumber.parse('+233'),
                    //   // initialCountryCode: 'GH',
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.transparent,
                    //     hintText: 'Enter phone number',
                    //     hintStyle: TextStyle(color: Colors.grey[500]),
                    //     contentPadding: EdgeInsets.symmetric(
                    //         vertical: 16.h, horizontal: 16.w),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12.r),
                    //       borderSide: BorderSide(color: Colors.grey[300]!),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12.r),
                    //       borderSide: BorderSide(color: Colors.grey[300]!),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12.r),
                    //       borderSide: const BorderSide(color: Colors.amber,
                    //           width: 2),
                    //     ),
                    //   ),
                    //   countryButtonStyle: const CountryButtonStyle(
                    //     showFlag: true,
                    //     showDialCode: true,
                    //     showIsoCode: false,
                    //     flagSize: 20,
                    //   ),
                    // ),

                    userPhoneTextFormField(
                      controller: _phoneController,
                    ),

                    SizedBox(height: 20.h),

                    /// ---------------- DATE OF BIRTH ----------------
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const CommonText(
                        text: 'Date of Birth',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => controller.pickDate(context),
                      child: AbsorbPointer(
                        child: CommonTextField(
                          controller: controller.dobController,
                          hintText: 'DD / MM / YYYY',
                          suffixIcon:
                          SizedBox(height: 20, width: 20,
                            child: Center(
                              child: Assets.icons.dobCalenderIcon.image(
                                  height: 20, width: 20),
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
                        text: 'Location',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CommonTextField(
                      hintText: 'Enter Location',
                      controller: controller.locationController,
                    ),

                    SizedBox(height: 20.h),

                    /// ---------------- GHANA CARD ----------------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonText(
                          text: 'Ghana Card ID',
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
                                onTap: () =>
                                    controller.pickImage(isProfile: false),
                                child: controller.ghanaCardImage.value !=
                                    null
                                    ? ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(12),
                                  child: Image.file(
                                    controller.ghanaCardImage.value!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload_outlined,
                                      size: 32,
                                      color: AppColors.gray300,
                                    ),
                                    SizedBox(height: 8.h),
                                    CommonText(
                                      text: 'Upload',
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

                    SizedBox(height: 40.h),

                    /// ---------------- UPDATE BUTTON ----------------
                    CommonButton(
                      onTap: () {
                        Get.back();
                      },
                      buttonRadius: 12,
                      titleText: "Update",
                    )
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