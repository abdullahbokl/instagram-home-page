import 'package:flutter/material.dart';

import '../../../core/constants/app_dimensions.dart';
import '../../../core/theme/app_theme.dart';
import '../../design/app_widget_keys.dart';

class AppDotsIndicator extends StatelessWidget {
  const AppDotsIndicator({
    required this.count,
    required this.currentIndex,
    super.key,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    if (count <= 1) {
      return const SizedBox.shrink();
    }

    final colors = context.appColors;
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      tween: Tween<double>(end: currentIndex.toDouble()),
      builder: (context, animIndex, _) {
        return RepaintBoundary(
          child: CustomPaint(
            key: AppWidgetKeys.dotsIndicator,
            size: Size(
              (count * AppDimensions.pageIndicatorDot) +
                  ((count - 1) * AppDimensions.pageIndicatorGap) +
                  2,
              AppDimensions.pageIndicatorDot + 2,
            ),
            painter: _DotsPainter(
              count: count,
              animIndex: animIndex,
              activeColor: colors.blueAccent,
              inactiveColor: colors.secondaryText.withValues(alpha: 0.45),
              dotSize: AppDimensions.pageIndicatorDot,
              gap: AppDimensions.pageIndicatorGap,
            ),
          ),
        );
      },
    );
  }
}

class _DotsPainter extends CustomPainter {
  _DotsPainter({
    required this.count,
    required this.animIndex,
    required this.activeColor,
    required this.inactiveColor,
    required this.dotSize,
    required this.gap,
  });

  final int count;
  final double animIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;
    final centerY = size.height / 2;

    for (var i = 0; i < count; i++) {
      // Calculate interpolation factor for this dot
      final distance = (i - animIndex).abs();
      final factor = (1.0 - distance).clamp(0.0, 1.0);

      final currentDotSize = dotSize + (factor * 2.0);
      final color = Color.lerp(inactiveColor, activeColor, factor)!;

      final x = (i * (dotSize + gap)) + (dotSize / 2) + 1;

      paint.color = color;
      canvas.drawCircle(Offset(x, centerY), currentDotSize / 2, paint);
    }
  }

  @override
  bool shouldRepaint(_DotsPainter oldDelegate) =>
      oldDelegate.animIndex != animIndex ||
      oldDelegate.count != count ||
      oldDelegate.activeColor != activeColor ||
      oldDelegate.inactiveColor != inactiveColor;
}
