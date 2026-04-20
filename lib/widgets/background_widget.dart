import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';

class CommonBackground extends StatelessWidget {
  final Widget child;
  final bool showAppBar;
  final VoidCallback? onBack;

  const CommonBackground({
    super.key,
    required this.child,
    this.showAppBar = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              onBack?.call();
              Navigator.pop(context);
            },
          ),
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
