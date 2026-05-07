import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_color.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final RxBool? isLoading;
  final double? height;
  final double? width;
  final Color? firstGradient;  // ✅ new
  final Color? secondGradient; // ✅ new

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading,
    this.height,
    this.width,
    this.firstGradient,  // ✅ new
    this.secondGradient, // ✅ new
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height ?? 52,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // ✅ use custom colors if provided, else default orange
              firstGradient ?? const Color.fromRGBO(255, 214, 0, 1),
              secondGradient ?? const Color.fromRGBO(255, 149, 0, 1),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
          ),
          child: isLoading != null
              ? Obx(() => isLoading!.value
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : _buildText())
              : _buildText(),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}