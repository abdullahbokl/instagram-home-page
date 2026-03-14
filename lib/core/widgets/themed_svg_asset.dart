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
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString(assetPath),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(width: width, height: height);
        }

        final svg = snapshot.data!
            .replaceAll('var(--fill-0, #262626)', _hexColor(color))
            .replaceAll('#262626', _hexColor(color));

        return SvgPicture.string(svg, width: width, height: height);
      },
    );
  }

  String _hexColor(Color color) {
    final red = (color.r * 255)
        .round()
        .clamp(0, 255)
        .toRadixString(16)
        .padLeft(2, '0');
    final green = (color.g * 255)
        .round()
        .clamp(0, 255)
        .toRadixString(16)
        .padLeft(2, '0');
    final blue = (color.b * 255)
        .round()
        .clamp(0, 255)
        .toRadixString(16)
        .padLeft(2, '0');
    return '#$red$green$blue';
  }
}
