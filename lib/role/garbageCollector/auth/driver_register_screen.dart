
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import 'package:project_borla/role/commonScreens/profile/controller/profile_controller.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/commonTextField/common_text_field.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../gen/custom_assets/assets.gen.dart';
import '../../../theme/auth_header.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/social_login_button.dart';
import '../../commonScreens/profile/innerWidget/profile_items.dart';
import 'driver_otp_screen.dart';

class DriverRegisterScreen extends StatefulWidget {
  const DriverRegisterScreen({super.key});

  @override
  State<DriverRegisterScreen> createState() => _DriverRegisterScreenState();
}

class _DriverRegisterScreenState extends State<DriverRegisterScreen> {

  ProfileController controller = Get.put(ProfileController());

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
                      AppColors.green500
                    ],
                  ),
                ),
                child: AuthHeader(
                    title: 'Create Your New Account',
                    subtitle: 'Register now and explore the world your way.'),
              ),
              Positioned(
                top: 0,
                  right: -60,
                  child: Assets.images.backgroundShadow.image(height: 300, width: 400)),

              Container(
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

                        profileItems(context, controller),

                        const SizedBox(height: 24),

                        Text('Password', style: TextStyle(
                            fontWeight: FontWeight.w700
                        ),),

                        const SizedBox(height: 12),
                        CommonTextField(
                          hintText: 'Password',
                          isPassword: true,
                        ),

                        const SizedBox(height: 24),

                        Text(' Confirm Password', style: TextStyle(
                            fontWeight: FontWeight.w700
                        ),),

                        const SizedBox(height: 12),
                        CommonTextField(
                          hintText: 'Confirm Password',
                          isPassword: true,
                        ),

                        const SizedBox(height: 32),

                        CommonButton(
                          titleText: 'Sign Up',
                          buttonRadius: 12,
                          onTap: () {
                            Get.to(()=> DriverOtpScreen());
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

                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text("Already have an account?", style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),),
                            //SizedBox(width: 2,),
                            TextButton(
                              onPressed: (){
                                Get.offAll(()=> LoginScreen());
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: AppColors.green500,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),)
                          ],
                        ),

                        const SizedBox(height: 70),

                      ],
                    ),
                  ),
                ),
              )

            ]
        )



    );
  }
}