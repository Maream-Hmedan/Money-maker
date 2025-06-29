import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  final double border;
  final double? width;
  final VoidCallback onTap;
  final Color shadowColor;
  final double elevation;

  const ButtonWidget({
    super.key,
    required this.child,
    required this.color,
    required this.border,
    this.width,
    required this.onTap,
    this.shadowColor = Colors.black26,
    this.elevation = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: elevation,
          shadowColor: shadowColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border),
          ),
        ),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}

