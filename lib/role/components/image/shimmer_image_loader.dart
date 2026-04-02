
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_borla/utils/app_urls.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageLoader extends StatelessWidget {
  final String? url; // ✅ nullable
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit fit;
  final bool isCircle;
  final Color? shimmerBackgroundColor;
  final Widget? defaultWidget;

  const ShimmerImageLoader({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
    this.isCircle = false,
    this.shimmerBackgroundColor,
    this.defaultWidget,
  });

  // ✅ safe null checks
  bool get _isNetwork =>
      url != null &&
          (url!.startsWith('http://') ||
              url!.startsWith('https://') ||
              url!.startsWith('public/uploads'));
  bool get _isFile =>
      url != null &&
          (url!.startsWith('/') || url!.startsWith('file://'));
  bool get _isAsset =>
      url != null && url!.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isCircle
          ? BorderRadius.circular(width / 2)
          : BorderRadius.circular(borderRadius.r),
      child: Container(
        width: width.w,
        height: height.w,
        color: shimmerBackgroundColor ?? Colors.grey.shade200,
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    // ✅ null or empty → show error widget, no crash
    if (url == null || url!.isEmpty) return _errorWidget();

    if (_isFile) {
      return Image.file(
        File(url!.replaceFirst('file://', '')),
        width: width.w,
        height: height.w,
        fit: fit,
        errorBuilder: (_, __, ___) => _errorWidget(),
      );
    }

    if (_isAsset) {
      return Image.asset(
        url!,
        width: width.w,
        height: height.w,
        fit: fit,
        errorBuilder: (_, __, ___) => _errorWidget(),
      );
    }

    if (_isNetwork) {
      log("NetworkImage: ${AppUrls.imageBase}$url");
      return Image.network(
        "${AppUrls.imageBase}$url",
        width: width.w,
        height: height.w,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: width.w,
              height: height.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              ),
            ),
          );
        },
        errorBuilder: (_, __, ___) => _errorWidget(),
      );
    }

    return _errorWidget();
  }

  Widget _errorWidget() {
    return Container(
      width: width.w,
      height: height.w,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: defaultWidget ??
          Icon(
            Icons.broken_image_outlined,
            color: Colors.grey.shade400,
            size: 20.sp,
          ),
    );
  }
}
