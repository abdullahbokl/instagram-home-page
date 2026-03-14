import 'package:flutter/material.dart';

import '../../../core/widgets/themed_svg_asset.dart';

class AppSvgIcon extends StatelessWidget {
  const AppSvgIcon({
    required this.assetPath,
    this.size,
    this.width,
    this.height,
    this.color,
    super.key,
  });

  final String assetPath;
  final double? size;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final resolvedWidth = width ?? size;
    final resolvedHeight = height ?? size;
    return ThemedSvgAsset(
      assetPath: assetPath,
      color: color ?? IconTheme.of(context).color ?? Colors.black,
      width: resolvedWidth,
      height: resolvedHeight,
    );
  }
}
