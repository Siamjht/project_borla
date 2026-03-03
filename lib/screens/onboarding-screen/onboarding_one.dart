import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/screens/onboarding-screen/onboarding_two.dart';

import '../../widgets/onboarding-widgets/onboarding_data.dart';
import '../../widgets/onboarding-widgets/onboarding_image_page_widget.dart';

class OnboardingOne extends StatefulWidget {
  const OnboardingOne({super.key});

  @override
  State<OnboardingOne> createState() => _OnboardingOneState();
}

class _OnboardingOneState extends State<OnboardingOne> {

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF8E8),  // Much closer to the screenshot
              Colors.white,
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        _currentPage = value;
                      });
                    },
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) => VideoOnboardingPage(
                      imagePath: onboardingData[index]["image"]!,
                      titlePath1: onboardingData[index]["title1"]!,
                      subtitlePath1: onboardingData[index]["subtitle1"]!,
                    ),
                  ),
                ),
                //const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                        (index) => buildDot(index),
                  ),
                ),

                const SizedBox(height: 46),

                _currentPage == 2 ? Row(

                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [

                        ElevatedButton(
                          onPressed: () {

                            Get.to(()=> OnboardingTwo());

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
                              padding: const EdgeInsets.fromLTRB(150, 16, 150, 16),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  //fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )

                      ],

                    ) : Row(

                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [

                    Container(
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
                          Get.to(()=> OnboardingTwo());
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(50, 14, 50, 14),

                          child: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Color.fromRGBO(255, 214, 0, 1),
                                Color.fromRGBO(255,149,0, 1),
                              ],
                            ).createShader(bounds),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),


                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage == onboardingData.length - 1) {
                         // _completeOnboarding();

                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
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
                          padding: const EdgeInsets.fromLTRB(60, 16, 60, 16),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              //fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )


                  ],

                ),

                const SizedBox(height: 80),
              ],
            ),

          ],
        ),
      ),
    );

  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 1),
      height: 8,
      width: _currentPage == index? 56 : 10,
      decoration: BoxDecoration(
        gradient: _currentPage == index ? LinearGradient(
            colors: [
              Color.fromRGBO(255, 214, 0, 1),
              Color.fromRGBO(255,149,0, 1),
            ]
        ) : LinearGradient(
            colors: [
              Color.fromRGBO(189, 189, 189, 1),
              Color.fromRGBO(189, 189, 189, 1),
            ]
        ) ,
        borderRadius: BorderRadius.circular(20),
        //shape: BoxShape.circle,
      ),
    );
  }

}





