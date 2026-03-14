import 'package:flutter/material.dart';

import '../../design/app_spacing.dart';

class AppIconAction extends StatelessWidget {
  const AppIconAction({
    required this.semanticLabel,
    required this.onPressed,
    required this.child,
    this.size = AppSpacing.touchTarget,
    super.key,
  });

  final String semanticLabel;
  final VoidCallback? onPressed;
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: InkResponse(
        onTap: onPressed,
        radius: AppSpacing.iconButtonRadius,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: child),
        ),
      ),
    );
  }
}
