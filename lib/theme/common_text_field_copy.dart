

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_color.dart';
import 'common_text_two.dart';


class CommonTextField extends StatelessWidget {
  CommonTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.maxLines = 1,
    this.validator,
    this.paddingHorizontal = 16,
    this.paddingVertical = 16,
    this.borderRadius = 10,
    this.borderWidth = 1,
    this.inputFormatters,
    this.fillColor = AppColors.white,
    this.hintTextColor = AppColors.hintTextColor,
    this.labelTextColor = AppColors.hintTextColor,
    this.textColor = AppColors.textColor,
    this.borderColor = AppColors.textFieldBorderColor,
    this.onSubmitted,
    this.onTap,
  });

  // Text
  final String? hintText;
  final String? labelText;
  final String? prefixText;

  // Icons
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  // Colors
  final Color fillColor;
  final Color hintTextColor;
  final Color labelTextColor;
  final Color textColor;
  final Color borderColor;

  // Layout
  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;
  final double borderWidth;

  // Input config
  final int? maxLength;
  final int maxLines;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  // Callbacks
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;

  /// Password visibility
  final RxBool _obscureText = true.obs;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onTap: onTap,
      onFieldSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      maxLength: maxLength,
      maxLines: isPassword ? 1 : maxLines,
      obscureText: isPassword ? _obscureText.value : false,

      cursorColor: AppColors.textDark,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),

      decoration: _inputDecoration(),
    );
  }

  InputDecoration _inputDecoration() {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      borderSide: BorderSide(color: borderColor, width: borderWidth,),
    );

    return InputDecoration(
      filled: true,
      fillColor: fillColor,
      errorMaxLines: 2,
      counterText: "",

      prefixIcon: prefixIcon,
      prefix: prefixText == null
          ? null
          : CommonText(
        text: prefixText!,
        fontWeight: FontWeight.w400,
        textAlign: TextAlign.left,
      ),

      suffixIcon: isPassword ? _passwordToggle() : suffixIcon,

      contentPadding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal.w,
        vertical: paddingVertical.h,
      ),

      border: border,
      enabledBorder: border,
      focusedBorder: border,
      disabledBorder: border,
      errorBorder: border,

      hintText: hintText,
      labelText: labelText,

      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: hintTextColor,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: TextStyle(
        fontSize: 14.sp,
        color: labelTextColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _passwordToggle() {
    return GestureDetector(
      onTap: () => _obscureText.toggle(),
      child: Padding(
        padding: EdgeInsetsDirectional.only(end: 10.w),
        child: Icon(
          _obscureText.value
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 20.sp,
          color: textColor,
        ),
      ),
    );
  }
}
