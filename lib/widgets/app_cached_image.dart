import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yalla_activity/configuration/app_colors.dart';

class AppCachedImage extends StatelessWidget {
  final String? url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  final Widget? placeholder;
  final Widget? errorWidget;
  final Widget Function(BuildContext context, ImageProvider imageProvider)? imageBuilder;

  final VoidCallback? onError;
  final VoidCallback? onImageLoaded;

  const AppCachedImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.imageBuilder,
    this.onError,
    this.onImageLoaded,
  });

  bool get _isValid => url != null && url!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(10);

    Widget defaultPlaceholder() => Container(
      width: width,
      height: height,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: AppColors.brandColorDark,
        strokeWidth: 2,
      ),
    );

    Widget defaultError() => Container(
      width: width,
      height: height ?? 22.h,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Icon(Icons.broken_image, size: 8.h, color: Colors.grey.shade500),
    );

    final img = !_isValid
        ? (errorWidget ?? defaultError())
        : CachedNetworkImage(
      imageUrl: url!.trim(),
      fit: fit,
      width: width,
      height: height,
      placeholder: (_, __) => placeholder ?? defaultPlaceholder(),
      errorWidget: (_, __, ___) {
        onError?.call();
        return errorWidget ?? defaultError();
      },
      imageBuilder: imageBuilder != null
          ? (context, provider) {
        onImageLoaded?.call();
        return imageBuilder!(context, provider);
      }
          : null,
    );
    return ClipRRect(
      borderRadius: br,
      child: img,
    );
  }
}

