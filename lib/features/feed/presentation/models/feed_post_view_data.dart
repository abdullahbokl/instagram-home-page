import '../../domain/models/media_item.dart';

class FeedPostViewData {
  const FeedPostViewData({
    required this.id,
    required this.username,
    required this.userAvatarUrl,
    required this.isVerified,
    required this.location,
    required this.likedByUsername,
    required this.likedByAvatarUrl,
    required this.likeCountLabel,
    required this.caption,
    required this.dateLabel,
    required this.mediaItems,
    required this.isLiked,
    required this.isSaved,
  });

  final String id;
  final String username;
  final String userAvatarUrl;
  final bool isVerified;
  final String location;
  final String likedByUsername;
  final String likedByAvatarUrl;
  final String likeCountLabel;
  final String caption;
  final String dateLabel;
  final List<MediaItem> mediaItems;
  final bool isLiked;
  final bool isSaved;
}
