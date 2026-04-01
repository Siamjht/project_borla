import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/user-controllers/booking_controller.dart';
import '../../helpers/other_helper.dart';
import '../../theme/app_color.dart';

class WasteContainer extends StatelessWidget {
  const WasteContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingCtrl = Get.find<BookingController>();

    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const Radius.circular(12),
        dashPattern: const [10, 5],
        strokeWidth: 2,
        padding: const EdgeInsets.all(8),
        color: AppColors.gray200,
      ),
      child: SizedBox(
        height: 180.h,
        width: double.infinity,
        child: GestureDetector(
          onTap: () async {
            final path = await OtherHelper.openGallery();
            if (path != null && path.isNotEmpty) {
              bookingCtrl.addWasteImage(path);
            }
          },
          child: Column(
            children: [
              SizedBox(height: 26),
              Container(
                height: 72,
                width: 72,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 214, 0, 1),
                      Color.fromRGBO(255, 149, 0, 1),
                    ],
                  ),
                ),
                child: Image.asset('assets/images/bin_camera.png', scale: 3.4),
              ),
              SizedBox(height: 10),
              Text(
                'Capture Waste Photo',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Take a clear photo of the waste',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class WastePickPhoto extends StatelessWidget {
  const WastePickPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingCtrl = Get.find<BookingController>();

    return Obx(() {
      if (bookingCtrl.wasteImagePaths.isEmpty) return const SizedBox();

      return GridView.builder(
        itemCount: bookingCtrl.wasteImagePaths.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final path = bookingCtrl.wasteImagePaths[index];

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // ── Image ──────────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(path),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // ── Delete Button ───────────────────────────────
              Positioned(
                right: -8,
                top: -8,
                child: GestureDetector(
                  onTap: () => bookingCtrl.removeWasteImage(index),
                  child: Container(
                    height: 23,
                    width: 23,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}