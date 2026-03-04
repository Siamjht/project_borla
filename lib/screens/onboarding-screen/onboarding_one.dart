import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/screens/onboarding-screen/onboarding_two.dart';
import '../../role/components/button/common_button.dart';
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
        child: Column(
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
                  titlePath1: onboardingData[index]["title"]!.tr,
                  subtitlePath1: onboardingData[index]["subtitle"]!.tr,
                ),
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                    (index) => buildDot(index),
              ),
            ),

            const SizedBox(height: 30),

                _currentPage == 2
        ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
        Expanded(
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: 16.0),
            child: CommonButton(
              titleText: "get_started".tr,
              firstGradient: const Color(0xFFFFD600),
              secondGradient: const Color(0xFFFF9500),
              useGradientBackground: true,
              buttonRadius: 12,
              onTap: () {
                Get.to(() => OnboardingTwo());
              },
            ),
          ),
        ),
                  ],
                )
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
          // Skip button (white with gradient text and border)
          Expanded(
            child: CommonButton(
              titleText: "skip".tr,
              firstGradient: const Color(0xFFFFD600),
              secondGradient: const Color(0xFFFF9500),
              useGradientBorder: true,
              useGradientBackground: false,
              useGradientText: true,
              backgroundColor: Colors.white,
              buttonRadius: 16,
              borderWidth: 2,
              onTap: () {
                Get.to(() => OnboardingTwo());
              },
            ),
          ),

          12.horizontalSpace,
          // Continue button (full gradient)
          Expanded(
            child: CommonButton(
              titleText: "continue".tr,
              firstGradient: const Color(0xFFFFD600),
              secondGradient: const Color(0xFFFF9500),
              useGradientBackground: true,
              buttonRadius: 12,
              onTap: () {
                if (_currentPage == onboardingData.length - 1) {
                  // _completeOnboarding();
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
                    ],
                  ),
        ),

            const SizedBox(height: 80),
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





