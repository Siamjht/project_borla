import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class VideoOnboardingPage extends StatefulWidget {
  final String imagePath;
  final String titlePath1;
  final String titlePath2;
  final String subtitlePath1;
  final String subtitlePath2;
  final String subtitlePath3;

  const VideoOnboardingPage({
    Key? key,
    required this.imagePath,
    required this.titlePath1,
    required this.titlePath2,
    required this.subtitlePath1,
    required this.subtitlePath2,
    required this.subtitlePath3,
  }) : super(key: key);

  @override
  State<VideoOnboardingPage> createState() => _VideoOnboardingPageState();
}

class _VideoOnboardingPageState extends State<VideoOnboardingPage> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(

        children: [


          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
                width: Get.width,
                height: 489.h,
                child: Image.asset(widget.imagePath, fit: BoxFit.cover,)
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20,10,20,10),
            child: Column(
              children: [
                Text(
                  widget.titlePath1,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.titlePath2,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),

                //const SizedBox(height: 20),
                Text(
                  widget.subtitlePath1,
                  //textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.subtitlePath2,
                  //textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.subtitlePath3,
                  //textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}