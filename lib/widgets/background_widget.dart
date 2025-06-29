import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';


class CommonBackground extends StatelessWidget {
  final Widget child;
  final bool showAppBar;

  const CommonBackground({
    super.key,
    required this.child,
    this.showAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
        )
            : null,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.whiteColor,
          child: child,
        ),
      ),
    );
  }
}
