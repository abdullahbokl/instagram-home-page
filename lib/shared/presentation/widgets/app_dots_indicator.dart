import 'package:flutter/material.dart';

import '../../../core/constants/app_dimensions.dart';
import '../../../core/theme/app_theme.dart';

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
    final colors = context.appColors;
    if (count <= 1) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: index == currentIndex
              ? AppDimensions.pageIndicatorDot + 2
              : AppDimensions.pageIndicatorDot,
          height: index == currentIndex
              ? AppDimensions.pageIndicatorDot + 2
              : AppDimensions.pageIndicatorDot,
          margin: EdgeInsets.only(
            right: index == count - 1 ? 0 : AppDimensions.pageIndicatorGap,
          ),
          decoration: BoxDecoration(
            color: index == currentIndex
                ? colors.blueAccent
                : colors.secondaryText.withValues(alpha: 0.45),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
