import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';


class CommonBackground extends StatelessWidget {
  final Widget child;

  const CommonBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Container(
            color: AppColors.whiteColor,
            child: child,
          ),
        ),
      ),
    );
  }
}