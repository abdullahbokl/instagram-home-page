part of 'feed_bloc.dart';

enum FeedStatus { initial, loading, success, failure }

class FeedState extends Equatable {
  const FeedState({
    this.stories = const <StoryItem>[],
    this.posts = const <FeedPost>[],
    this.status = FeedStatus.initial,
    this.isPaginating = false,
    this.hasMore = true,
    this.nextPage = 0,
    this.errorMessage,
  });

  final List<StoryItem> stories;
  final List<FeedPost> posts;
  final FeedStatus status;
  final bool isPaginating;
  final bool hasMore;
  final int nextPage;
  final String? errorMessage;

  FeedState copyWith({
    List<StoryItem>? stories,
    List<FeedPost>? posts,
    FeedStatus? status,
    bool? isPaginating,
    bool? hasMore,
    int? nextPage,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return FeedState(
      stories: stories ?? this.stories,
      posts: posts ?? this.posts,
      status: status ?? this.status,
      isPaginating: isPaginating ?? this.isPaginating,
      hasMore: hasMore ?? this.hasMore,
      nextPage: nextPage ?? this.nextPage,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    stories,
    posts,
    status,
    isPaginating,
    hasMore,
    nextPage,
    errorMessage,
  ];
}
