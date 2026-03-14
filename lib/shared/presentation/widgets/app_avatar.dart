import 'package:flutter/material.dart';

import '../../../core/widgets/app_network_image.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.imageUrl,
    required this.size,
    this.borderColor,
    this.borderWidth = 0,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  final String imageUrl;
  final double size;
  final Color? borderColor;
  final double borderWidth;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    Widget avatar = AppNetworkImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      isCircular: true,
    );

    if (borderWidth > 0 && borderColor != null) {
      avatar = Container(
        width: size,
        height: size,
        padding: padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor!, width: borderWidth),
        ),
        child: avatar,
      );
    }

    return avatar;
  }
}
