import 'package:flutter/material.dart';

class AppSectionContainer extends StatelessWidget {
  const AppSectionContainer({
    required this.child,
    this.padding,
    this.color,
    this.border,
    this.height,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Border? border;
  final double? height;

  @override
  Widget build(BuildContext context) {
    Widget content = DecoratedBox(
      decoration: BoxDecoration(color: color, border: border),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );

    if (height != null) {
      content = SizedBox(height: height, child: content);
    }

    return content;
  }
}
