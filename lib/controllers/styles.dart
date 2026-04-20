
import 'package:flutter/material.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:sizer/sizer.dart';

class Styles {
  String get _fontFamily => AppLocale().isArabic() ? 'Cairo' : 'Futura';

  TextStyle bigText = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  TextStyle smallText = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  TextStyle bottomText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );

  TextStyle midText = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  TextStyle mainText = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w800,
    color: const Color(0xFFE59200),
  );

  TextStyle errorText = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
    color: Colors.red,
  );

  TextStyle buttonText = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  TextStyle get big => bigText.copyWith(fontFamily: _fontFamily);
  TextStyle get small => smallText.copyWith(fontFamily: _fontFamily);
  TextStyle get bottom => bottomText.copyWith(fontFamily: _fontFamily);
  TextStyle get mid => midText.copyWith(fontFamily: _fontFamily);
  TextStyle get main => mainText.copyWith(fontFamily: _fontFamily);
  TextStyle get error => errorText.copyWith(fontFamily: _fontFamily);
  TextStyle get button => buttonText.copyWith(fontFamily: _fontFamily);
}
