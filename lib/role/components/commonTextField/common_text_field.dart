
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/app_color.dart';
import '../text/common_text.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
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
    this.fillColor = AppColors.transparent,
    this.hintTextColor = AppColors.hintTextColor,
    this.labelTextColor = AppColors.hintTextColor,
    this.textColor = AppColors.textColor,
    this.borderColor = AppColors.textFieldBorderColor,
    this.onSubmitted,
    this.onTap,
    this.onChanged,
  });

  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color fillColor;
  final Color hintTextColor;
  final Color labelTextColor;
  final Color textColor;
  final Color borderColor;
  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;
  final double borderWidth;
  final int? maxLength;
  final int maxLines;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _obscureText = true; // ✅ plain bool in State

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: widget.maxLength,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      obscureText: widget.isPassword ? _obscureText : false, // ✅
      cursorColor: AppColors.textDark,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: widget.textColor,
      ),
      decoration: _inputDecoration(),
    );
  }

  InputDecoration _inputDecoration() {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      borderSide: BorderSide(color: widget.borderColor, width: widget.borderWidth),
    );

    return InputDecoration(
      filled: true,
      fillColor: widget.fillColor,
      errorMaxLines: 2,
      counterText: "",
      prefixIcon: widget.prefixIcon,
      prefix: widget.prefixText == null
          ? null
          : CommonText(
        text: widget.prefixText!,
        fontWeight: FontWeight.w400,
        textAlign: TextAlign.left,
      ),
      suffixIcon: widget.isPassword ? _passwordToggle() : widget.suffixIcon,
      contentPadding: EdgeInsets.symmetric(
        horizontal: widget.paddingHorizontal.w,
        vertical: widget.paddingVertical.h,
      ),
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      disabledBorder: border,
      errorBorder: border,
      hintText: widget.hintText,
      labelText: widget.labelText,
      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: widget.hintTextColor,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: TextStyle(
        fontSize: 14.sp,
        color: widget.labelTextColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _passwordToggle() {
    return GestureDetector(
      onTap: () => setState(() => _obscureText = !_obscureText), // ✅ setState
      child: Padding(
        padding: EdgeInsetsDirectional.only(end: 10.w),
        child: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 20.sp,
          color: widget.textColor,
        ),
      ),
    );
  }
}