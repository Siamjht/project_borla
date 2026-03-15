
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void success(String message, {String title = 'Success'}) {
    _show(
      title: title,
      message: message,
      iconColor: const Color(0xFF4CAF50),
      icon: Icons.check_circle_rounded,
      leftBarColor: const Color(0xFF4CAF50),
    );
  }

  static void error(String message, {String title = 'Error'}) {
    _show(
      title: title,
      message: message,
      iconColor: const Color(0xFFE53935),
      icon: Icons.cancel_rounded,
      leftBarColor: const Color(0xFFE53935),
    );
  }

  static void warning(String message, {String title = 'Warning'}) {
    _show(
      title: title,
      message: message,
      iconColor: const Color(0xFFFFA726),
      icon: Icons.warning_rounded,
      leftBarColor: const Color(0xFFFFA726),
    );
  }

  static void info(String message, {String title = 'Info'}) {
    _show(
      title: title,
      message: message,
      iconColor: const Color(0xFF42A5F5),
      icon: Icons.info_rounded,
      leftBarColor: const Color(0xFF42A5F5),
    );
  }

  // ── Core Builder ──
  static void _show({
    required String title,
    required String message,
    required Color iconColor,
    required IconData icon,
    required Color leftBarColor,
  }) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 400),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeIn,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      snackStyle: SnackStyle.FLOATING,
      messageText: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(color: leftBarColor, width: 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // ── Icon ──
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),

            const SizedBox(width: 12),

            // ── Title + Message ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // ── Close Button ──
            GestureDetector(
              onTap: () => Get.closeCurrentSnackbar(),
              child: Icon(
                Icons.close_rounded,
                color: Colors.white.withValues(alpha: 0.5),
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}