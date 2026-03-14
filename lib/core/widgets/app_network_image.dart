import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'shimmer_box.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.isCircular = false,
    this.placeholder,
    this.errorWidget,
    this.alignment = Alignment.center,
    super.key,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool isCircular;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.trim().isEmpty) {
      return errorWidget ?? _NetworkImageError(width: width, height: height);
    }

    Widget child = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      fadeInDuration: const Duration(milliseconds: 180),
      fadeOutDuration: const Duration(milliseconds: 120),
      placeholderFadeInDuration: const Duration(milliseconds: 120),
      placeholder: (context, url) =>
          placeholder ?? ShimmerBox(width: width, height: height),
      errorWidget: (context, url, error) =>
          errorWidget ?? _NetworkImageError(width: width, height: height),
    );

    if (isCircular) {
      child = ClipOval(child: child);
    } else if (borderRadius != null) {
      child = ClipRRect(borderRadius: borderRadius!, child: child);
    }

    return child;
  }
}

class _NetworkImageError extends StatelessWidget {
  const _NetworkImageError({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      width: width,
      height: height,
      color: colors.surface,
      alignment: Alignment.center,
      child: Icon(Icons.broken_image_outlined, color: colors.secondaryText),
    );
  }
}
