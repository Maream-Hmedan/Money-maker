import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:sizer/sizer.dart';


class CommonViews {
  static final CommonViews _shared = CommonViews._private();

  factory CommonViews() => _shared;

  CommonViews._private();

  Widget customText({
    required String textContent,
    Color? textColor,
    double? fontSize,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    FontWeight? fontWeight,
  }) {
    TextStyle baseStyle = TextStyle(
      fontSize: fontSize??18.sp,
      color: textColor ?? Colors.black,
      fontWeight: fontWeight,
    );

    return Text(
      textContent,
      softWrap: true,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: baseStyle,
    );
  }

  Widget customClickableText({
    required String textContent,
    Color? textColor,
    required VoidCallback onTap,
    required double fontSize,
    bool? withFontFamily = true,
    TextAlign? textAlign,
    FontWeight? fontWeight,
  }) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap();
      },
      child: Text(
        textContent,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor ?? AppColors.whiteColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  Widget customContainer({
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    required Color colorBorder,
    final double? radius,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          FocusManager.instance.primaryFocus?.unfocus();
          onTap.call();
        }
      },
      child: Container(
        width: width ?? 40.w,
        height: height ?? 4.h,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 20)),
          color: color ,
          border: Border.all(
            width: 3,
            color: colorBorder ,
          ),
        ),
        child: child,
      ),
    );
  }

  Widget customButton({
    required Widget child,
    required Color color,
     Color? borderColor,
    required double border,
    double? width,
    required VoidCallback onTap,
    Color shadowColor = Colors.black26,
    double elevation = 6,
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          surfaceTintColor: Colors.transparent,
          elevation: elevation,
          shadowColor: shadowColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor??Colors.transparent),
            borderRadius: BorderRadius.circular(border,), // Border radius
          ),
        ),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
