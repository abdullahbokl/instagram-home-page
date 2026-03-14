import 'package:equatable/equatable.dart';

import 'feed_post.dart';

class FeedPage extends Equatable {
  const FeedPage({
    required this.posts,
    required this.hasMore,
    required this.nextPage,
  });

  final List<FeedPost> posts;
  final bool hasMore;
  final int nextPage;

  @override
  List<Object?> get props => [posts, hasMore, nextPage];
}
