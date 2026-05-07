import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/authController/auth_controller.dart';
import 'package:project_borla/features/auth/register_screen.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/theme/app_color.dart';
import '../gen/custom_assets/assets.gen.dart';
import '../role/garbageCollector/auth/driver_register_screen.dart';
import '../theme/auth_header.dart';
import '../widgets/gradient_button.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {


  AuthController authController = Get.find<AuthController>();

  bool agree = false ;
  //RxString selectedRole = "".obs;

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
                      Color.fromRGBO(255, 214, 0, 1),
                      Color.fromRGBO(255,149,0, 1),
                    ],
                  ),
                ),
                child: AuthHeader(title: 'choose_your_role'.tr,
                  subtitle: 'enter_your_role_subtitle'.tr),
              ),
              Positioned(
                  top: 0,
                  right: -60,
                  child: Assets.images.backgroundShadow.image(height: 300, width: 400)),

              Positioned(
                top: 240,
                left: 0,
                right: 0,
                child: Container(
                  //alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(34)
                    ),
                    color: Colors.white,
                  ),
                  height: 666,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        const SizedBox(height: 12),

                        Obx(() => userSelectionWidget(
                            onTap: () {
                              authController.selectedRole.value = 'User';
                            },
                            gradientColor1: authController.selectedRole.value == "User"? AppColors.orange200 : AppColors.gray200,
                            gradientColor2: authController.selectedRole.value == "User"? AppColors.orange500 : AppColors.gray200,
                            borderWidth: authController.selectedRole.value == "User"? 2.0 : 1.0,
                            assetImage: Assets.images.user1.image(height: 145.h, width: 208.w,),
                            role: 'user_role'.tr
                        ),),

                        const SizedBox(height: 30),

                        Obx(() => userSelectionWidget(
                            onTap: () {
                              authController.selectedRole.value = 'Rider';
                            },
                            gradientColor1: authController.selectedRole.value == "Rider"? AppColors.orange200 : AppColors.gray200,
                            gradientColor2: authController.selectedRole.value == "Rider"? AppColors.orange500 : AppColors.gray200,
                            borderWidth: authController.selectedRole.value == "Rider"? 2.0 : 1.0,
                            assetImage: Assets.images.rider.image(height: 145.h, width: 208.w,),
                            role: 'rider_role'.tr
                        ),),

                        const SizedBox(height: 50),

                        GradientButton(
                          text: 'join_now'.tr,
                          onPressed: () {
                            if(authController.selectedRole.value != ""){
                              if(authController.selectedRole.value == "User"){
                                Get.to(()=> RegisterScreen());
                              }else{
                                Get.to(()=> DriverRegisterScreen());
                              }
                            }else{
                              Get.snackbar('select_role_title'.tr,
                                  'select_role_message'.tr, snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                        ),

                        const SizedBox(height: 24),

                      ],
                    ),
                  ),
                ),
              )

            ]
        )


    );
  }

  Widget userSelectionWidget({VoidCallback? onTap, gradientColor1, gradientColor2, borderWidth, assetImage, role}) {
    return InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: EdgeInsets.all(borderWidth),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [gradientColor1, gradientColor2],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.orange50
                          ),
                          child: Row(
                            children: [
                              assetImage,
                              Expanded(child: CommonText(text: role, fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.orange300,))
                            ],
                          ),
                        ),
                      )


                    );
  }
}
