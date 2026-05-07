
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/helpers/other_helper.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/image/shimmer_image_loader.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../controllers/profileController/profile_controller.dart';
import '../../../gen/custom_assets/assets.gen.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../../components/gradient_scafold.dart';
import '../../components/text/common_text.dart';
import 'innerWidget/profile_items.dart';


class EditProfileScreen extends StatelessWidget {
  bool isUser;
  EditProfileScreen({super.key, this.isUser = false});

  final ProfileController controller = Get.find<ProfileController>();

  // late final PhoneController _phoneController;
  // final TextEditingController _passController = TextEditingController();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _phoneController = PhoneController(
  //     initialValue: const PhoneNumber(
  //       isoCode: IsoCode.GH,
  //       nsn: '',
  //     ),
  //   );
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _phoneController.value = const PhoneNumber(
  //       isoCode: IsoCode.GH,
  //       nsn: '',
  //     );
  //   });
  //
  // }
  //
  // @override
  // void dispose() {
  //   _phoneController.dispose();
  //   _passController.dispose();
  //   super.dispose();
  // }

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
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isUser? AppColors.orange500 : Color(0xFF4CAF50),
                                width: 4,
                              ),
                            ),
                            child: ClipOval(
                              child: controller.imagePath.value.isNotEmpty
                                  ? ShimmerImageLoader(url: controller.imagePath.value, width: 120, height: 120)
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
                            onTap: () async {
                              controller.imagePath.value = (await OtherHelper.openGallery())!;
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.fadedWhite,
                                border: Border.all(color: AppColors.gray200),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: isUser? AppColors.orange500 : AppColors.green500,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),
                    CommonText(
                      text: 'Change Your Profile Picture',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isUser? AppColors.orange300 : Color(0xFF4CAF50),
                    ),

                    SizedBox(height: 32.h),
                    profileItems(context, controller, isUser),

                    SizedBox(height: 40.h),

                    /// ---------------- UPDATE BUTTON ----------------
                    Obx(() => CommonButton(
                      isLoading: controller.isUpdating.value,
                      onTap: () {
                        controller.updateProfile(isUser: isUser);
                      },
                      buttonRadius: 12,
                      firstGradient: isUser? AppColors.orange300 : AppColors.green300,
                      secondGradient: isUser? AppColors.orange500 : AppColors.green500,
                      titleText: "Update",
                    ),)
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
