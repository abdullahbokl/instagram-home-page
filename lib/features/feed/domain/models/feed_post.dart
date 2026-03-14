import 'package:equatable/equatable.dart';

import 'feed_user.dart';
import 'media_item.dart';

class FeedPost extends Equatable {
  const FeedPost({
    required this.id,
    required this.user,
    required this.location,
    required this.caption,
    required this.likedByUsername,
    required this.likedByAvatarUrl,
    required this.likeCount,
    required this.dateLabel,
    required this.mediaItems,
    this.isLiked = false,
    this.isSaved = false,
  });

  final String id;
  final FeedUser user;
  final String location;
  final String caption;
  final String likedByUsername;
  final String likedByAvatarUrl;
  final int likeCount;
  final String dateLabel;
  final List<MediaItem> mediaItems;
  final bool isLiked;
  final bool isSaved;

  FeedPost copyWith({
    FeedUser? user,
    String? location,
    String? caption,
    String? likedByUsername,
    String? likedByAvatarUrl,
    int? likeCount,
    String? dateLabel,
    List<MediaItem>? mediaItems,
    bool? isLiked,
    bool? isSaved,
  }) {
    return FeedPost(
      id: id,
      user: user ?? this.user,
      location: location ?? this.location,
      caption: caption ?? this.caption,
      likedByUsername: likedByUsername ?? this.likedByUsername,
      likedByAvatarUrl: likedByAvatarUrl ?? this.likedByAvatarUrl,
      likeCount: likeCount ?? this.likeCount,
      dateLabel: dateLabel ?? this.dateLabel,
      mediaItems: mediaItems ?? this.mediaItems,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [
    id,
    user,
    location,
    caption,
    likedByUsername,
    likedByAvatarUrl,
    likeCount,
    dateLabel,
    mediaItems,
    isLiked,
    isSaved,
  ];
}
