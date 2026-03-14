import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_task/features/feed/data/repositories/post_repository.dart';
import 'package:instagram_task/features/feed/data/services/mock_feed_service.dart';
import 'package:instagram_task/features/feed/domain/models/feed_page.dart';
import 'package:instagram_task/features/feed/domain/models/story_item.dart';
import 'package:instagram_task/features/feed/domain/usecases/load_feed_page_use_case.dart';
import 'package:instagram_task/features/feed/domain/usecases/toggle_post_like_use_case.dart';
import 'package:instagram_task/features/feed/domain/usecases/toggle_post_save_use_case.dart';
import 'package:instagram_task/features/feed/presentation/bloc/feed_bloc.dart';

void main() {
  late MockFeedService service;
  late FeedPage firstPage;
  late FeedPage secondPage;
  late List<StoryItem> stories;

  setUp(() {
    service = const MockFeedService();
    firstPage = service.buildFeedPage(page: 0);
    secondPage = service.buildFeedPage(page: 1);
    stories = service.buildStories();
  });

  blocTest<FeedBloc, FeedState>(
    'FeedStarted emits loading then success with stories and posts',
    build: () => FeedBloc(
      loadFeedPageUseCase: LoadFeedPageUseCase(
        repository: _TestPostRepository(stories: stories, pages: {0: firstPage}),
      ),
      togglePostLikeUseCase: const TogglePostLikeUseCase(),
      togglePostSaveUseCase: const TogglePostSaveUseCase(),
    ),
    act: (bloc) => bloc.add(const FeedStarted()),
    expect: () => [
      const FeedState(status: FeedStatus.loading),
      FeedState(
        stories: stories,
        posts: firstPage.posts,
        status: FeedStatus.success,
        hasMore: firstPage.hasMore,
        nextPage: firstPage.nextPage,
      ),
    ],
  );

  blocTest<FeedBloc, FeedState>(
    'FeedNextPageRequested appends posts and preserves existing items',
    build: () => FeedBloc(
      loadFeedPageUseCase: LoadFeedPageUseCase(
        repository: _TestPostRepository(
          stories: stories,
          pages: {0: firstPage, 1: secondPage},
        ),
      ),
      togglePostLikeUseCase: const TogglePostLikeUseCase(),
      togglePostSaveUseCase: const TogglePostSaveUseCase(),
    ),
    act: (bloc) async {
      bloc.add(const FeedStarted());
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);
      bloc.add(const FeedNextPageRequested());
    },
    expect: () => [
      const FeedState(status: FeedStatus.loading),
      FeedState(
        stories: stories,
        posts: firstPage.posts,
        status: FeedStatus.success,
        hasMore: firstPage.hasMore,
        nextPage: firstPage.nextPage,
      ),
      FeedState(
        stories: stories,
        posts: firstPage.posts,
        status: FeedStatus.success,
        hasMore: firstPage.hasMore,
        nextPage: firstPage.nextPage,
        isPaginating: true,
      ),
      FeedState(
        stories: stories,
        posts: [...firstPage.posts, ...secondPage.posts],
        status: FeedStatus.success,
        hasMore: secondPage.hasMore,
        nextPage: secondPage.nextPage,
      ),
    ],
  );

  blocTest<FeedBloc, FeedState>(
    'pagination failure keeps current posts and reports the error',
    build: () => FeedBloc(
      loadFeedPageUseCase: LoadFeedPageUseCase(
        repository: _TestPostRepository(
          stories: stories,
          pages: {0: firstPage},
          failingPages: const {1},
        ),
      ),
      togglePostLikeUseCase: const TogglePostLikeUseCase(),
      togglePostSaveUseCase: const TogglePostSaveUseCase(),
    ),
    act: (bloc) async {
      bloc.add(const FeedStarted());
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);
      bloc.add(const FeedNextPageRequested());
    },
    expect: () => [
      const FeedState(status: FeedStatus.loading),
      FeedState(
        stories: stories,
        posts: firstPage.posts,
        status: FeedStatus.success,
        hasMore: firstPage.hasMore,
        nextPage: firstPage.nextPage,
      ),
      FeedState(
        stories: stories,
        posts: firstPage.posts,
        status: FeedStatus.success,
        hasMore: firstPage.hasMore,
        nextPage: firstPage.nextPage,
        isPaginating: true,
      ),
      FeedState(
        stories: stories,
        posts: firstPage.posts,
        status: FeedStatus.success,
        hasMore: firstPage.hasMore,
        nextPage: firstPage.nextPage,
        errorMessage: 'Could not load more posts.',
      ),
    ],
  );

  test('like and save toggles only mutate the targeted post', () async {
    final repository = _TestPostRepository(
      stories: stories,
      pages: {0: firstPage},
    );
    final bloc = FeedBloc(
      loadFeedPageUseCase: LoadFeedPageUseCase(repository: repository),
      togglePostLikeUseCase: const TogglePostLikeUseCase(),
      togglePostSaveUseCase: const TogglePostSaveUseCase(),
    )..add(const FeedStarted());

    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final target = bloc.state.posts.first;
    final untouched = bloc.state.posts[1];

    bloc
      ..add(FeedLikeToggled(target.id))
      ..add(FeedSaveToggled(target.id));

    await Future<void>.delayed(Duration.zero);

    final updatedTarget = bloc.state.posts.first;
    final updatedUntouched = bloc.state.posts[1];

    expect(updatedTarget.isLiked, isNot(target.isLiked));
    expect(updatedTarget.isSaved, isNot(target.isSaved));
    expect(updatedUntouched, untouched);

    await bloc.close();
  });

  test(
    'pagination requests are not duplicated while a page is loading',
    () async {
      final pendingPage = Completer<FeedPage>();
      final repository = _TestPostRepository(
        stories: stories,
        pages: {0: firstPage},
        pendingPages: {1: pendingPage},
      );
      final bloc = FeedBloc(
        loadFeedPageUseCase: LoadFeedPageUseCase(repository: repository),
        togglePostLikeUseCase: const TogglePostLikeUseCase(),
        togglePostSaveUseCase: const TogglePostSaveUseCase(),
      )..add(const FeedStarted());

      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      bloc
        ..add(const FeedNextPageRequested())
        ..add(const FeedNextPageRequested());

      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(repository.pageRequests.where((page) => page == 1), hasLength(1));

      pendingPage.complete(secondPage);
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);
      await bloc.close();
    },
  );
}

class _TestPostRepository implements PostRepository {
  _TestPostRepository({
    required this.stories,
    required this.pages,
    this.failingPages = const <int>{},
    this.pendingPages = const <int, Completer<FeedPage>>{},
  });

  final List<StoryItem> stories;
  final Map<int, FeedPage> pages;
  final Set<int> failingPages;
  final Map<int, Completer<FeedPage>> pendingPages;
  final List<int> pageRequests = <int>[];

  @override
  Future<FeedPage> fetchPosts({required int page, int pageSize = 10}) {
    pageRequests.add(page);

    if (failingPages.contains(page)) {
      return Future<FeedPage>.error(Exception('fetch failed'));
    }

    if (pendingPages.containsKey(page)) {
      return pendingPages[page]!.future;
    }

    return Future<FeedPage>.value(pages[page]!);
  }

  @override
  List<StoryItem> getStories() => stories;
}
