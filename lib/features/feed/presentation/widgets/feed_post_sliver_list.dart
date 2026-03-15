import 'package:flutter/material.dart';

import '../../../../core/widgets/feed_loading_skeleton.dart';
import 'post_card.dart';

class FeedPostSliverList extends StatelessWidget {
  const FeedPostSliverList({
    required this.postIds,
    required this.isPaginating,
    required this.onZoomStateChanged,
    super.key,
  });

  final List<String> postIds;
  final bool isPaginating;
  final ValueChanged<bool> onZoomStateChanged;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: postIds.length + (isPaginating ? 2 : 0),
      itemBuilder: (context, index) {
        if (index >= postIds.length) {
          return const PaginationPostSkeleton();
        }

        return PostCard(
          postId: postIds[index],
          onZoomStateChanged: onZoomStateChanged,
        );
      },
    );
  }
}
