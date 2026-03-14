import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/failures/feed_failure.dart';
import '../../domain/models/feed_post.dart';
import '../../domain/models/story_item.dart';
import '../../domain/usecases/load_feed_page_use_case.dart';
import '../../domain/usecases/toggle_post_like_use_case.dart';
import '../../domain/usecases/toggle_post_save_use_case.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({
    required LoadFeedPageUseCase loadFeedPageUseCase,
    required TogglePostLikeUseCase togglePostLikeUseCase,
    required TogglePostSaveUseCase togglePostSaveUseCase,
  }) : _loadFeedPageUseCase = loadFeedPageUseCase,
       _togglePostLikeUseCase = togglePostLikeUseCase,
       _togglePostSaveUseCase = togglePostSaveUseCase,
      super(const FeedState()) {
    on<FeedStarted>(_onStarted);
    on<FeedNextPageRequested>(_onNextPageRequested);
    on<FeedLikeToggled>(_onLikeToggled);
    on<FeedSaveToggled>(_onSaveToggled);
  }

  final LoadFeedPageUseCase _loadFeedPageUseCase;
  final TogglePostLikeUseCase _togglePostLikeUseCase;
  final TogglePostSaveUseCase _togglePostSaveUseCase;

  Future<void> _onStarted(FeedStarted event, Emitter<FeedState> emit) async {
    emit(state.copyWith(status: FeedStatus.loading, clearErrorMessage: true));

    try {
      final result = await _loadFeedPageUseCase.loadInitial();
      emit(
        state.copyWith(
          stories: result.stories,
          posts: result.page.posts,
          status: FeedStatus.success,
          hasMore: result.page.hasMore,
          nextPage: result.page.nextPage,
          isPaginating: false,
          clearErrorMessage: true,
        ),
      );
    } on FeedFailure catch (failure) {
      emit(
        state.copyWith(
          status: FeedStatus.failure,
          isPaginating: false,
          errorMessage: failure.message,
        ),
      );
    }
  }

  Future<void> _onNextPageRequested(
    FeedNextPageRequested event,
    Emitter<FeedState> emit,
  ) async {
    if (state.status != FeedStatus.success ||
        state.isPaginating ||
        !state.hasMore) {
      return;
    }

    emit(state.copyWith(isPaginating: true, clearErrorMessage: true));

    try {
      final page = await _loadFeedPageUseCase.loadPage(page: state.nextPage);
      emit(
        state.copyWith(
          posts: [...state.posts, ...page.posts],
          isPaginating: false,
          hasMore: page.hasMore,
          nextPage: page.nextPage,
          clearErrorMessage: true,
        ),
      );
    } on FeedFailure catch (failure) {
      emit(
        state.copyWith(
          isPaginating: false,
          errorMessage: failure.message,
        ),
      );
    }
  }

  void _onLikeToggled(FeedLikeToggled event, Emitter<FeedState> emit) {
    emit(
      state.copyWith(
        posts: _togglePostLikeUseCase(state.posts, event.postId),
      ),
    );
  }

  void _onSaveToggled(FeedSaveToggled event, Emitter<FeedState> emit) {
    emit(
      state.copyWith(
        posts: _togglePostSaveUseCase(state.posts, event.postId),
      ),
    );
  }
}
