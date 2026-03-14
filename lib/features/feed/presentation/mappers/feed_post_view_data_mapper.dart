import '../../domain/models/feed_post.dart';
import '../models/feed_post_view_data.dart';

class FeedPostViewDataMapper {
  const FeedPostViewDataMapper();

  FeedPostViewData call(FeedPost post) {
    return FeedPostViewData(
      id: post.id,
      username: post.user.username,
      userAvatarUrl: post.user.avatarUrl,
      isVerified: post.user.isVerified,
      location: post.location,
      likedByUsername: post.likedByUsername,
      likedByAvatarUrl: post.likedByAvatarUrl,
      likeCountLabel: _formatLikeCount(post.likeCount),
      caption: post.caption,
      dateLabel: post.dateLabel,
      mediaItems: post.mediaItems,
      isLiked: post.isLiked,
      isSaved: post.isSaved,
    );
  }

  String _formatLikeCount(int count) {
    final buffer = count.toString();
    final chars = buffer.split('').reversed.toList();
    final parts = <String>[];
    for (var i = 0; i < chars.length; i += 3) {
      parts.add(chars.skip(i).take(3).toList().reversed.join());
    }
    return parts.reversed.join(',');
  }
}
