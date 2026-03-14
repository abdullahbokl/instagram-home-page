import '../models/feed_post.dart';

class TogglePostLikeUseCase {
  const TogglePostLikeUseCase();

  List<FeedPost> call(List<FeedPost> posts, String postId) {
    return posts
        .map(
          (post) => post.id == postId
              ? post.copyWith(
                  isLiked: !post.isLiked,
                  likeCount: post.isLiked
                      ? post.likeCount - 1
                      : post.likeCount + 1,
                )
              : post,
        )
        .toList(growable: false);
  }
}
