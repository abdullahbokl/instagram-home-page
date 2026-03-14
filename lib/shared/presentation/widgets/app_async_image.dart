import 'package:flutter/material.dart';

import '../../../core/widgets/app_network_image.dart';

class AppAsyncImage extends StatelessWidget {
  const AppAsyncImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.isCircular = false,
    super.key,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final BorderRadius? borderRadius;
  final bool isCircular;

  @override
  Widget build(BuildContext context) {
    return AppNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      borderRadius: borderRadius,
      isCircular: isCircular,
    );
  }
}
