part of 'feed_bloc.dart';

sealed class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

final class FeedStarted extends FeedEvent {
  const FeedStarted();
}

final class FeedNextPageRequested extends FeedEvent {
  const FeedNextPageRequested();
}

final class FeedLikeToggled extends FeedEvent {
  const FeedLikeToggled(this.postId);

  final String postId;

  @override
  List<Object?> get props => [postId];
}

final class FeedSaveToggled extends FeedEvent {
  const FeedSaveToggled(this.postId);

  final String postId;

  @override
  List<Object?> get props => [postId];
}
