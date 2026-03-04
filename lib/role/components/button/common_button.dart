import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_borla/theme/app_color.dart';
import '../text/common_text.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;

  // Text
  final Color titleColor;
  final double titleSize;
  final FontWeight titleWeight;
  final bool useGradientText;

  // Size
  final double buttonRadius;
  final double buttonHeight;
  final double buttonWidth;
  final EdgeInsetsGeometry? padding;

  // Border
  final Color? borderColor;
  final double borderWidth;
  final bool useGradientBorder;

  // Background
  final Color? backgroundColor;
  final Color firstGradient;
  final Color secondGradient;
  final bool useGradientBackground;

  final bool isLoading;
  final Widget? childWidget;

  const CommonButton({
    super.key,
    this.onTap,
    this.titleText = "",
    this.titleColor = Colors.white,
    this.titleSize = 16,
    this.titleWeight = FontWeight.w600,
    this.useGradientText = false,

    this.buttonRadius = 12,
    this.buttonHeight = 50,
    this.buttonWidth = double.infinity,
    this.padding,

    this.borderWidth = 1,
    this.borderColor,
    this.useGradientBorder = false,

    this.backgroundColor,
    this.firstGradient = AppColors.green500,
    this.secondGradient = AppColors.green500,
    this.useGradientBackground = true,

    this.isLoading = false,
    this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
    BorderRadius.circular(buttonRadius.r);

    return SizedBox(
      height: buttonHeight.h,
      width: buttonWidth.w,
      child: Container(
        decoration: BoxDecoration(
          gradient: useGradientBorder
              ? LinearGradient(
            colors: [firstGradient, secondGradient],
          )
              : null,
          borderRadius: borderRadius,
          border: useGradientBorder
              ? null
              : Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth.w,
          ),
        ),
        padding: useGradientBorder
            ? EdgeInsets.all(borderWidth.w)
            : EdgeInsets.zero,
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: isLoading ? null : onTap,
            child: Ink(
              decoration: BoxDecoration(
                color: useGradientBackground
                    ? null
                    : backgroundColor ?? firstGradient,
                gradient: useGradientBackground
                    ? LinearGradient(
                  colors: [firstGradient, secondGradient],
                )
                    : null,
                borderRadius: borderRadius,
              ),
              child: Center(
                child: isLoading
                    ? (Platform.isIOS
                    ? const CupertinoActivityIndicator(color: Colors.white)
                    : const CircularProgressIndicator(
                    color: Colors.white))
                    : childWidget ??
                    Padding(
                      padding: padding ??
                          EdgeInsets.symmetric(
                              vertical: 14.h, horizontal: 20.w),
                      child: useGradientText
                          ? ShaderMask(
                        shaderCallback: (bounds) =>
                            LinearGradient(
                              colors: [
                                firstGradient,
                                secondGradient
                              ],
                            ).createShader(bounds),
                        child: CommonText(
                          text: titleText,
                          fontSize: titleSize,
                          fontWeight: titleWeight,
                          color: Colors.white,
                          maxLines: 1,
                        ),
                      )
                          : CommonText(
                        text: titleText,
                        fontSize: titleSize,
                        fontWeight: titleWeight,
                        color: titleColor,
                        maxLines: 1,
                      ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}