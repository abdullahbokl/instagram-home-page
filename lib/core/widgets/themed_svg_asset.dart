import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemedSvgAsset extends StatelessWidget {
  const ThemedSvgAsset({
    required this.assetPath,
    required this.color,
    this.width,
    this.height,
    super.key,
  });

  final String assetPath;
  final Color color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
