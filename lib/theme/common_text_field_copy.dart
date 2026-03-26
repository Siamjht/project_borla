import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/app_color.dart';




class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.isPassword = false,
    this.readOnly = false,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.mexLength,
    this.maxLines,
    this.validator,
    this.prefixText,
    this.paddingHorizontal = 16,
    this.paddingVertical = 14,
    this.borderRadius = 10,
    this.inputFormatters,
    this.fillColor = AppColors.primaryColor,
    this.hintTextColor = AppColors.hintTextColor,
    this.labelTextColor = AppColors.hintTextColor,
    this.textColor = AppColors.textColor,
    this.borderColor = AppColors.textFieldBorderColor,
    this.onSubmitted,
    this.onTap,
    this.suffixIcon,
    this.onChanged,
    this.gradient,
    this.borderWidth = 1
  });

  final String? hintText;
  final String? labelText;
  final String? prefixText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final Color? fillColor;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color textColor;
  final Color borderColor;

  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;
  final int? mexLength;
  final int? maxLines;

  final bool isPassword;
  final bool readOnly;

  final Gradient? gradient;

  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;

  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final FormFieldValidator? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double borderWidth;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ✅ Gradient/color layer — purely visual, doesn't intercept touches
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: widget.gradient,
              color: widget.gradient == null ? widget.fillColor : null,
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderWidth,
              ),
            ),
          ),
        ),
        // ✅ TextField on top — receives all touches normally
        TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          obscureText: widget.isPassword ? obscureText : false,
          textInputAction: widget.textInputAction,
          maxLength: widget.mexLength,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          readOnly: widget.readOnly,
          cursorColor: widget.textColor,
          inputFormatters: widget.inputFormatters,
          style: TextStyle(fontSize: 14, color: widget.textColor),
          decoration: InputDecoration(
            errorMaxLines: 2,
            filled: true,
            fillColor: Colors.transparent, // transparent so gradient shows through
            counterText: "",
            prefixIcon: widget.prefixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: widget.paddingHorizontal.w,
              vertical: widget.paddingVertical.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
              borderSide: BorderSide.none,
            ),
            hintText: widget.hintText,
            labelText: widget.labelText,
            hintStyle: TextStyle(fontSize: 14, color: widget.hintTextColor),
            labelStyle: TextStyle(fontSize: 14, color: widget.labelTextColor),
            prefix: widget.prefixText != null
                ? Padding(
              padding: EdgeInsets.only(right: 6.w),
              child: Text(
                widget.prefixText!,
                style: TextStyle(fontSize: 14, color: widget.textColor),
              ),
            )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20.sp,
                color: widget.textColor,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            )
                : widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
