import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/authController/auth_controller.dart';
import 'package:project_borla/controllers/user-controllers/auth_controller.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import 'package:project_borla/role/components/commonTextField/common_text_field.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../theme/auth_header.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

class SetPassScreen extends StatefulWidget {
  const SetPassScreen({super.key});

  @override
  State<SetPassScreen> createState() => _SetPassScreenState();
}

class _SetPassScreenState extends State<SetPassScreen> {

  final _authCtrl = Get.find<AuthController>();

  final formKey = GlobalKey <FormState> () ;

  bool agree = false ;

  // TextEditingController newPassController = TextEditingController();
  // TextEditingController confirmPassController = TextEditingController();

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
                child: AuthHeader(title: 'Set a New Password.', subtitle: 'Enter a strong and secure password to get back to your journey.'),
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
                height: 630,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text('New Password', style: TextStyle(
                            fontWeight: FontWeight.w700
                        ),),

                        const SizedBox(height: 16),

                        CommonTextField(
                          controller: _authCtrl.passController,
                          hintText: 'Password',
                          isPassword: true,
                          borderRadius: 14,
                          borderColor: AppColors.primaryColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),


                        const SizedBox(height: 20),

                        Text('Confirm Password', style: TextStyle(
                            fontWeight: FontWeight.w700
                        ),),

                        const SizedBox(height: 16),

                        CommonTextField(
                          controller: _authCtrl.confirmPassController,
                          hintText: 'Confirm password',
                          isPassword: true,
                          borderRadius: 14,
                          borderColor: AppColors.primaryColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Confirm password is required";
                            }
                            if (value != _authCtrl.passController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 50),

                        GradientButton(
                          text: 'Save',
                          onPressed: () async {

                            if (!formKey.currentState!.validate()) return;

                            final bool success = await _authCtrl.resetPassword(
                              newPassword: _authCtrl.passController.text,
                              confirmPassword: _authCtrl.confirmPassController.text,
                            );

                            if (success) {
                              Get.offAll(() => LoginScreen());
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
}
