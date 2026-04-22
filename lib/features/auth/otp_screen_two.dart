import 'package:flutter/material.dart';
import 'package:flutter_modern_animated_loader/flutter_animated_loader.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project_borla/controllers/authController/auth_controller.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import 'package:project_borla/features/auth/set_pass_screen.dart';
import '../../gen/custom_assets/assets.gen.dart';
import '../../theme/app_color.dart';
import '../../theme/auth_header.dart';
import '../../theme/otp_theme.dart';
import '../../widgets/gradient_button.dart';


class OtpScreen extends StatefulWidget {
  bool isSignup;
  OtpScreen({super.key, this.isSignup = true});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _authCtrl = Get.find<AuthController>();
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // ← prevents whole screen from resizing
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(255, 214, 0, 1),
                  Color.fromRGBO(255, 149, 0, 1),
                ],
              ),
            ),
            child: AuthHeader(
              title: "confirm_its_really_you".tr,
              subtitle: "enter_4_digit_code_from_email".tr,
            ),
          ),

          Positioned(
            top: 0,
            right: -60,
            child: Assets.images.backgroundShadow.image(height: 300, width: 400),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
              color: Colors.white,
            ),
            height: 650,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              // ↓ Wrap only the inner column with SingleChildScrollView
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  // ↓ Add bottom padding equal to keyboard height so content
                  //   shifts up just enough when keyboard opens
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0),
                        child: PinCodeTextField(
                          controller: _authCtrl.otpController,
                          cursorColor: AppColors.black100,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          keyboardType: TextInputType.number,
                          appContext: context,
                          length: 4,
                          pinTheme: appOTPStyle(),
                          animationType: AnimationType.fade,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          hintCharacter: '-',
                          hintStyle: const TextStyle(
                            fontSize: 36,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400,
                          ),
                          onCompleted: (v) {},
                          onChanged: (value) {},
                        ),
                      ),

                      const SizedBox(height: 32),

                      Column(
                        children: [
                          Text(
                            "didnt_receive_otp".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Obx(
                                () => _authCtrl.isOtpSending.value
                                ? Center(
                              child: FlutterAnimatedLoader.staggerWave(
                                color: AppColors.orange500,
                                size: 20,
                              ),
                            )
                                : GestureDetector(
                              onTap: () {
                                _authCtrl.resendOtp(
                                    _authCtrl.emailController.text);
                              },
                              child: ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(255, 214, 0, 1),
                                        Color.fromRGBO(255, 149, 0, 1),
                                      ],
                                    ).createShader(bounds),
                                child: Container(
                                  padding:
                                  const EdgeInsets.only(bottom: 0.3),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.white, width: 3),
                                    ),
                                  ),
                                  child: Text(
                                    "resend_code".tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 36),

                      GradientButton(
                        isLoading: _authCtrl.isLoading,
                        text: "verify".tr,
                        onPressed: () async {
                          if (widget.isSignup) {
                            final success = await _authCtrl.verifyEmailOTP(
                              _authCtrl.otpController.text,
                            );
                            if (success) {
                              Get.offAll(() => LoginScreen());
                            }
                          } else {
                            final success = await _authCtrl.verifyEmailOTP(
                              _authCtrl.otpController.text,
                            );
                            if (success) {
                              Get.to(() => SetPassScreen());
                            }
                          }
                        },
                      ),
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
