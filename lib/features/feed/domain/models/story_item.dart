import 'package:equatable/equatable.dart';

import 'feed_user.dart';

class StoryItem extends Equatable {
  const StoryItem({
    required this.id,
    required this.user,
    this.isOwn = false,
    this.isLive = false,
    this.isViewed = false,
  });

  final String id;
  final FeedUser user;
  final bool isOwn;
  final bool isLive;
  final bool isViewed;

  @override
  List<Object?> get props => [id, user, isOwn, isLive, isViewed];
}
