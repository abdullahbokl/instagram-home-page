import 'package:flutter/widgets.dart';

abstract final class AppWidgetKeys {
  static const feedScrollView = Key('feed-scroll-view');
  static const topBar = Key('feed-top-bar');
  static const bottomNav = Key('feed-bottom-nav');
  static const dotsIndicator = Key('feed-dots-indicator');
  static const paginationSkeleton = Key('feed-pagination-skeleton');
  static const shimmerScaffold = Key('feed-shimmer-scaffold');

  static Key postCard(String postId) => ValueKey<String>('feed-post-$postId');
  static Key mediaCarousel(String postId) =>
      ValueKey<String>('feed-carousel-$postId');
  static Key zoomableImage(String mediaId) =>
      ValueKey<String>('zoomable-image-$mediaId');
}
