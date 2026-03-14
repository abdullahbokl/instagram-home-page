import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/app_dots_indicator.dart';

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    required this.count,
    required this.currentIndex,
    super.key,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return AppDotsIndicator(count: count, currentIndex: currentIndex);
  }
}
