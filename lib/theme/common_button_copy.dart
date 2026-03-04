import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../role/components/text/common_text.dart';


class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;
  final Color titleColor;
  final Color? borderColor;
  final double borderWidth;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double buttonWidth;
  final bool isLoading;
  final Color firstGradient;
  final Color secondGradient;
  final Widget? childWidget;

  const CommonButton({
    super.key,
    this.onTap,
    this.titleText = "",
    this.titleColor = Colors.white,
    this.titleSize = 16,
    this.buttonRadius = 50,
    this.titleWeight = FontWeight.w600,
    this.buttonHeight = 48,
    this.buttonWidth = double.infinity,
    this.borderWidth = 1,
    this.borderColor,
    this.isLoading = false,
    this.firstGradient = Colors.amber,
    this.secondGradient = Colors.amber,
    this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight.h,
      width: buttonWidth.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [borderColor != null ? Colors.transparent : firstGradient , borderColor != null? Colors.transparent : secondGradient],
          ),
          borderRadius: BorderRadius.circular(buttonRadius.r),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth.w,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(buttonRadius.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(buttonRadius.r),
            onTap: isLoading ? null : onTap,
            child: Center(
              child: isLoading
                  ? (Platform.isIOS
                  ? const CupertinoActivityIndicator(color: Colors.white)
                  : const CircularProgressIndicator(color: Colors.white))
                  : childWidget ??
                  CommonText(
                    text: titleText,
                    fontSize: titleSize,
                    fontWeight: titleWeight,
                    color: titleColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  )
              ,
            ),
          ),
        ),
      ),
    );
  }
}