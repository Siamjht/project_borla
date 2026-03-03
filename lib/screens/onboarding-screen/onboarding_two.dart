import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import 'package:project_borla/screens/select_role_screen.dart';
import '../../widgets/onboarding-widgets/onboarding_image_page_widget.dart';


class OnboardingTwo extends StatelessWidget {
  OnboardingTwo({super.key});

  final Map<String, String> onboardingData =
    {
      "image": "assets/images/onboard4.png",
      "title1": "Welcome To Borla Borla \nYour Garbage Pickup App",
      "subtitle1": "Experience fast, reliable, and convenient waste \ncollection service right at your doorstep \nanytime you need.",
    };

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 246, 217, 1),
              Color.fromRGBO(255, 255, 255, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child:  VideoOnboardingPage(
                  imagePath: onboardingData["image"]!,
                  titlePath1: onboardingData["title1"]!,
                  subtitlePath1: onboardingData["subtitle1"]!,
                ),
              ),


            Column(

              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: ElevatedButton(
                    onPressed: () {

                      Get.to(LoginScreen());

                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero, // important
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      minimumSize: const Size(100, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(255, 214, 0, 1),
                            Color.fromRGBO(255,149,0, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(140, 16, 140, 16),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                            //fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox( height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),


                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 214, 0, 1),
                          Color.fromRGBO(255,149,0, 1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(2), // border thickness
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 50),
                        backgroundColor: Colors.white, // white button
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14), // inner radius
                        ),
                      ),
                      onPressed: () {
                        Get.to(SelectRoleScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(134, 14, 134, 14),

                        child: ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Color.fromRGBO(255, 214, 0, 1),
                              Color.fromRGBO(255,149,0, 1),
                            ],
                          ).createShader(bounds),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),
                          ),
                        ),


                      ),
                    ),
                  ),

                ),

              ],

            ) ,

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
