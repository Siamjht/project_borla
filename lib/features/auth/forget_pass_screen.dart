import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/controllers/user-controllers/auth_controller.dart';
import '../../theme/auth_header.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/social_login_button.dart';
import 'login_screen.dart';
import 'otp_screen_two.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {

  UserAuthController authController = Get.put(UserAuthController());

  final formKey = GlobalKey <FormState>() ;

  bool agree = false ;

  //TextEditingController emailController = TextEditingController();

  void formOnSubmit() {
    if(formKey.currentState!.validate()) {
      print ('Form is valid');
      Get.to(()=> OtpScreen(isSignup: false,));
    }
    else {
      print ('Form is Invalid');
    }
  }

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
                child: AuthHeader(
                    title: 'Forgot Your Password?',
                    subtitle: "Don't worry, it happens! Enter your email and we'll send you a link to reset your password. "),
              ),

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

                      const SizedBox(height: 26),

                      Text('Email ID', style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16
                      ),),

                      const SizedBox(height: 24),

                      CustomTextField(

                        controller: authController.emailController,
                        hint: 'Enter your email',
                        prefix: const Icon(Icons.email),


                      ),



                      const SizedBox(height: 16),


                      const SizedBox(height: 8),


                      const SizedBox(height: 16),

                      GradientButton(
                        text: 'Send Code',
                        onPressed: () {
                          //Get.to(()=> OtpScreen(isSignup: false,));
                          formOnSubmit();
                        },
                      ),


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
