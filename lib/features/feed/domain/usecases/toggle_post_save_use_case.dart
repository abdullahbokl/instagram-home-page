import '../models/feed_post.dart';

class TogglePostSaveUseCase {
  const TogglePostSaveUseCase();

  List<FeedPost> call(List<FeedPost> posts, String postId) {
    return posts
        .map(
          (post) => post.id == postId
              ? post.copyWith(isSaved: !post.isSaved)
              : post,
        )
        .toList(growable: false);
  }
}
