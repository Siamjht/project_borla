import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../role/commonScreens/profile/innerWidget/language_bottom_sheet.dart';
import '../../role/components/text/common_text.dart';

class VideoOnboardingPage extends StatefulWidget {
  final String imagePath;
  final String titlePath1;
  final String subtitlePath1;

  const VideoOnboardingPage({
    Key? key,
    required this.imagePath,
    required this.titlePath1,
    required this.subtitlePath1,
  }) : super(key: key);

  @override
  State<VideoOnboardingPage> createState() => _VideoOnboardingPageState();
}

class _VideoOnboardingPageState extends State<VideoOnboardingPage> {

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full height if needed
      backgroundColor: Colors.transparent,
      builder: (context) => const LanguageSelectionBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: Get.width,
                  height: 489.h,
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 60,
                right: 30,
                child: InkWell(
                  onTap: () {
                    showLanguageBottomSheet(context);
                  },
                  child: Icon(Icons.language, color: AppColors.orange300,),),)
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              children: [
                CommonText(
                  text: widget.titlePath1,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),

                SizedBox(height: 8.h),

                CommonText(
                  text: widget.subtitlePath1,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray500,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}