import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/navBar/nav_bar.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../gen/custom_assets/assets.gen.dart';
import '../../../theme/auth_header.dart';
import '../../../theme/otp_theme.dart';

class DriverOtpScreen extends StatefulWidget {
  const DriverOtpScreen({super.key});

  @override
  State<DriverOtpScreen> createState() => _DriverOtpScreenState();
}

class _DriverOtpScreenState extends State<DriverOtpScreen> {

  TextEditingController otpController = TextEditingController();

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
                  title: "Confirm It's Really You.",
                  subtitle: "Enter the 4-digit code from your email.",
                ),
              ),

              Positioned(
                  top: 0,
                  right: -60,
                  child: Assets.images.backgroundShadow.image(height: 300, width: 400)),

              Container(

                //alignment: Alignment.center,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(34)
                  ),
                  color: Colors.white,
                ),
                height: 666,

                child: Padding(
                  padding: const EdgeInsets.all(24),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0),
                        child: PinCodeTextField(
                          controller: otpController,
                          cursorColor: AppColors.black100,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            appContext: context,
                            length: 4,
                            pinTheme: appOTPStyle(),
                            animationType: AnimationType.fade,
                            animationDuration: Duration(milliseconds: 300),
                            enableActiveFill: true,
                            hintCharacter: '-',
                            hintStyle: const TextStyle(
                              fontSize: 36,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w400
                            ),
                            onCompleted: (v) {
                            },
                            onChanged: (value) {
                            }

                        ),
                      ),
                      SizedBox(height: 20,),
                      Column(
                        children: [
                          Text(
                            "Didn't receive OTP?",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.grey.shade600
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: () {

                            },
                            child: ShaderMask(
                              shaderCallback: (bounds) =>
                                  const LinearGradient(
                                    colors: [
                                      AppColors.green500,
                                      AppColors.green500
                                    ],
                                  ).createShader(bounds),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 0.3),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 3),
                                  ),
                                ),
                                child: const Text(
                                  'Resend Code',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,

                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40,),
                          CommonButton(
                            titleText: "Verify",
                            firstGradient: AppColors.green500,
                            secondGradient: AppColors.green500,
                            buttonRadius: 12,
                            onTap: () {
                              Get.to(()=> DriverNavbar());
                              },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )

            ]
        )


    );
  }
}


