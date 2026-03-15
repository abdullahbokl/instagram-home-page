import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/design/app_durations.dart';
import '../../../../shared/design/app_radii.dart';
import '../../../../shared/design/app_widget_keys.dart';
import '../../domain/models/media_item.dart';
import 'zoomable_feed_image.dart';

class PostMediaCarousel extends StatefulWidget {
  const PostMediaCarousel({
    required this.postId,
    required this.mediaItems,
    required this.currentIndexListenable,
    required this.onPageChanged,
    required this.onZoomStateChanged,
    super.key,
  });

  final String postId;
  final List<MediaItem> mediaItems;
  final ValueNotifier<int> currentIndexListenable;
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

    return ValueListenableBuilder<int>(
      valueListenable: widget.currentIndexListenable,
      builder: (context, currentIndex, child) {
        final currentRatio = widget.mediaItems[currentIndex].aspectRatio;
        return TweenAnimationBuilder<double>(
          duration: AppDurations.long,
          curve: Curves.easeOutCubic,
          tween: Tween<double>(end: currentRatio),
          builder: (context, ratio, innerChild) {
            return AspectRatio(
              key: AppWidgetKeys.mediaCarousel(widget.postId),
              aspectRatio: ratio,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  innerChild!,
                  if (mediaCount > 1)
                    Positioned(
                      top: 14,
                      right: 14,
                      child: RepaintBoundary(
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
                            '${currentIndex + 1}/$mediaCount',
                            style: AppTextStyles.location(
                              colors,
                            ).copyWith(color: Colors.white, letterSpacing: 0),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
          child: child,
        );
      },
      child: RepaintBoundary(
        child: PageView.builder(
          controller: _pageController,
          physics: mediaCount > 1
              ? const PageScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          itemCount: mediaCount,
          onPageChanged: widget.onPageChanged,
          itemBuilder: (context, index) {
            return ZoomableFeedImage(
              key: AppWidgetKeys.zoomableImage(widget.mediaItems[index].id),
              imageUrl: widget.mediaItems[index].imageUrl,
              onZoomStateChanged: widget.onZoomStateChanged,
            );
          },
        ),
      ),
    );
  }
}
