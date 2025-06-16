import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:sizer/sizer.dart';

class CountrySelectorField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final double? radius;
  final Color? borderColor;
  final Color? errorBorderColor;
  final bool errorBorder;

  const CountrySelectorField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.radius,
    this.borderColor,
    this.errorBorderColor,
    this.errorBorder = false,
  });

  @override
  State<CountrySelectorField> createState() => _CountrySelectorFieldState();
}

class _CountrySelectorFieldState extends State<CountrySelectorField> {

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.trim().isEmpty) {
      widget.controller.text = '🇯🇴  Jordan';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      readOnly: true,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Futura',
        color: AppColors.whiteColor,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 3.w),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        alignLabelWithHint: true,
        errorStyle: const TextStyle(height: 0.01),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: _border(widget.radius, widget.borderColor),
        focusedBorder: _border(widget.radius, widget.borderColor),
        errorBorder:
            widget.errorBorder
                ? _border(widget.radius, widget.errorBorderColor ?? Colors.red)
                : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 8),
                  borderSide: BorderSide.none,
                ),
        focusedErrorBorder: _border(widget.radius, widget.borderColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 8),
          borderSide: BorderSide.none,
        ),
      ),
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          countryListTheme: CountryListThemeData(
            flagSize: 24,
            backgroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16),
            bottomSheetHeight: 500,
            inputDecoration: const InputDecoration(
              prefixIcon: Icon(Icons.search,color: Colors.grey,),
              border: OutlineInputBorder(),
            ),
          ),
          onSelect: (Country country) {
            widget.controller.text = '${country.flagEmoji}  ${country.name}';
          },
        );
      },
    );
  }

  OutlineInputBorder _border(double? radius, Color? color) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 8),
        borderSide: BorderSide(color: color ?? AppColors.borderTextFieldColor),
      );


  }

