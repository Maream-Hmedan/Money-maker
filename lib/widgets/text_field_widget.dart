import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:sizer/sizer.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? label;
  final TextAlign? textAlign;
  final TextInputType keyboardType;
  final TextInputAction? inputAction;
  final double? radius;
  final ValueChanged<String>? onSubmitted;
  final String? prefixText;
  final String? hint;
  final bool errorBorder;
  final double? height;
  final Widget? suffixIcon;
  final int? maxLines;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Color? fillColor;
  final String? errorText;
  final bool? readOnly;
  final FormFieldValidator<String>? validator;
  final Color? textColor;
  final Color? hintColor;
  final Color? errorBorderColor;
  final double? errorHeight;
  final bool isObscure;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.keyboardType,
    this.label,
    this.textAlign,
    this.inputAction,
    this.radius,
    this.onSubmitted,
    this.prefixText,
    this.hint,
    this.errorBorder = true,
    this.height,
    this.suffixIcon,
    this.maxLines,
    this.prefixIcon,
    this.borderColor,
    this.fillColor,
    this.errorText,
    this.readOnly,
    this.validator,
    this.textColor,
    this.hintColor,
    this.errorBorderColor,
    this.errorHeight,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      textAlign: textAlign ?? TextAlign.left,
      textInputAction: inputAction ?? TextInputAction.next,
      readOnly: readOnly ?? false,
      obscureText: isObscure,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      autovalidateMode: AutovalidateMode.disabled,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Futura',
        color: textColor??Colors.black,
      ),
      decoration: InputDecoration(
        // paddings
        contentPadding: EdgeInsets.symmetric(
          vertical: 2.5.h,
          horizontal: 3.w,
        ),
        // labels & hints
        floatingLabelBehavior: FloatingLabelBehavior.always,
        alignLabelWithHint: true,
        label: Text(label ?? ''),
        labelStyle:  TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'Futura',
          color: textColor??AppColors.whiteColor,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'Futura',
          color: hintColor??Colors.grey,
        ),
        errorText: errorText,
        errorStyle: TextStyle(height: errorHeight ?? 0.01),
        prefixIcon: prefixIcon,
        prefixIconColor: Color(0xFFE59200),
        suffixIcon: suffixIcon,
        prefix: Text(prefixText ?? ''),
        prefixStyle: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'Futura',
          color: Colors.black,
        ),
        filled: true,
        fillColor: fillColor ?? Colors.transparent,
        enabledBorder: _border(radius, borderColor),
        focusedBorder: _border(radius, borderColor),
        errorBorder: errorBorder
            ? _border(radius, errorBorderColor ?? Colors.red)
            : OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: _border(radius, borderColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  OutlineInputBorder _border(double? radius, Color? color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius ?? 8),
    borderSide: BorderSide(color: color ?? Colors.grey.shade200,width: 1.5),
  );
}
