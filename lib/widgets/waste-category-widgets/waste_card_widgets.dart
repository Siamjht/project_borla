
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../screens/waste-screens/waste-controllers/waste_category_controller.dart';

class GradientBorderPainter extends CustomPainter {
  final Gradient gradient;
  final double strokeWidth;
  final double radius;

  GradientBorderPainter({
    required this.gradient,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rRect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(radius),
    );

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant GradientBorderPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gradient != gradient;
  }

}





Widget buildCategoryCard({
  required int index,
  required String image,
  required String label,
  required double scale,
}) {

  WasteCategoryController wasteController = Get.find<WasteCategoryController>();

  return Obx(() {
    final bool isSelected =
        wasteController.selectedIndex.value == index;

    return GestureDetector(
      onTap: () {
        wasteController.changeIndex(index);
      },
      child: CustomPaint(
        painter: isSelected
            ? GradientBorderPainter(
          strokeWidth: 2,
          radius: 12,
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFFC107),
              Color(0xFFFF9800),
            ],
          ),
        )
            : GradientBorderPainter(
          strokeWidth: 1,
          radius: 12,
          gradient: const LinearGradient(
            colors: [
              Colors.yellow,
              Colors.yellow,
            ],
          ),
        ),
        child: Container(
          height: 170,
          width: Get.width * 0.42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            children: [
              Image.asset(image, height: 105, width: 100,),
              const SizedBox(height: 6),
              Text(
                label.tr,
                style: TextStyle(
                  color: isSelected
                      ? Colors.orange
                      : Colors.grey.shade500,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}

