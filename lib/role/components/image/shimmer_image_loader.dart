
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageLoader extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit fit;
  final bool isCircle;
  final Color? shimmerBackgroundColor;
  final Widget? defaultWidget; // new

  const ShimmerImageLoader({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
    this.isCircle = false,
    this.shimmerBackgroundColor,
    this.defaultWidget, // new
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isCircle
          ? BorderRadius.circular(width / 2)
          : BorderRadius.circular(borderRadius.r),
      child: Container(
        width: width.w,
        height: height.w,
        color: shimmerBackgroundColor ?? Colors.grey.shade200, // background color
        child: Image.network(
          url,
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
          errorBuilder: (_, __, ___) => Container(
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
          ),
        ),
      ),
    );
  }
}
