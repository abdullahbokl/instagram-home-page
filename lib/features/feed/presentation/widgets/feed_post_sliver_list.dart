import 'package:flutter/material.dart';

import '../../../../core/widgets/feed_loading_skeleton.dart';
import '../../domain/models/feed_post.dart';
import 'post_card.dart';

class FeedPostSliverList extends StatelessWidget {
  const FeedPostSliverList({
    required this.posts,
    required this.isPaginating,
    required this.onApproachingEnd,
    required this.onZoomStateChanged,
    super.key,
  });

  final List<FeedPost> posts;
  final bool isPaginating;
  final VoidCallback onApproachingEnd;
  final ValueChanged<bool> onZoomStateChanged;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: posts.length + (isPaginating ? 2 : 0),
      itemBuilder: (context, index) {
        if (index >= posts.length) {
          return const PaginationPostSkeleton();
        }

        if (index == posts.length - 2) {
          onApproachingEnd();
        }

        return PostCard(
          post: posts[index],
          onZoomStateChanged: onZoomStateChanged,
        );
      },
    );
  }
}
