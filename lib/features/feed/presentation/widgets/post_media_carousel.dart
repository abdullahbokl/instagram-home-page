import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/design/app_durations.dart';
import '../../../../shared/design/app_radii.dart';
import '../../domain/models/media_item.dart';
import 'zoomable_feed_image.dart';

class PostMediaCarousel extends StatefulWidget {
  const PostMediaCarousel({
    required this.mediaItems,
    required this.currentIndex,
    required this.onPageChanged,
    required this.onZoomStateChanged,
    super.key,
  });

  final List<MediaItem> mediaItems;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<bool> onZoomStateChanged;

  @override
  State<PostMediaCarousel> createState() => _PostMediaCarouselState();
}

class _PostMediaCarouselState extends State<PostMediaCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final mediaCount = widget.mediaItems.length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final currentRatio = widget.mediaItems[widget.currentIndex].aspectRatio;
        final targetHeight = constraints.maxWidth / currentRatio;

        return AnimatedContainer(
          duration: AppDurations.long,
          curve: Curves.easeOutCubic,
          width: double.infinity,
          height: targetHeight,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                physics: mediaCount > 1
                    ? const PageScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                itemCount: mediaCount,
                onPageChanged: widget.onPageChanged,
                itemBuilder: (context, index) {
                  return ZoomableFeedImage(
                    imageUrl: widget.mediaItems[index].imageUrl,
                    onZoomStateChanged: widget.onZoomStateChanged,
                  );
                },
              ),
              if (mediaCount > 1)
                Positioned(
                  top: 14,
                  right: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colors.pillBackground,
                      borderRadius: AppRadii.pill,
                    ),
                    child: Text(
                      '${widget.currentIndex + 1}/$mediaCount',
                      style: AppTextStyles.location(
                        colors,
                      ).copyWith(color: Colors.white, letterSpacing: 0),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
