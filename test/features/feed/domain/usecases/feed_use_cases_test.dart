import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_task/features/feed/data/repositories/post_repository.dart';
import 'package:instagram_task/features/feed/data/services/mock_feed_service.dart';
import 'package:instagram_task/features/feed/domain/models/feed_page.dart';
import 'package:instagram_task/features/feed/domain/models/story_item.dart';
import 'package:instagram_task/features/feed/domain/usecases/load_feed_page_use_case.dart';
import 'package:instagram_task/features/feed/domain/usecases/toggle_post_like_use_case.dart';
import 'package:instagram_task/features/feed/domain/usecases/toggle_post_save_use_case.dart';

void main() {
  late MockFeedService service;
  late FeedPage page;
  late List<StoryItem> stories;

  setUp(() {
    service = const MockFeedService();
    page = service.buildFeedPage(page: 0);
    stories = service.buildStories();
  });

  test('LoadFeedPageUseCase returns stories and first page for initial load', () async {
    final useCase = LoadFeedPageUseCase(
      repository: _FakePostRepository(stories: stories, pages: {0: page}),
    );

    final result = await useCase.loadInitial();

    expect(result.stories, stories);
    expect(result.page, page);
  });

  test('TogglePostLikeUseCase updates only the targeted post', () {
    final posts = page.posts;

    final updated = const TogglePostLikeUseCase()(posts, posts.first.id);

    expect(updated.first.isLiked, isNot(posts.first.isLiked));
    expect(updated[1], posts[1]);
  });

  test('TogglePostSaveUseCase updates only the targeted post', () {
    final posts = page.posts;

    final updated = const TogglePostSaveUseCase()(posts, posts.first.id);

    expect(updated.first.isSaved, isNot(posts.first.isSaved));
    expect(updated[1], posts[1]);
  });
}

class _FakePostRepository implements PostRepository {
  _FakePostRepository({required this.stories, required this.pages});

  final List<StoryItem> stories;
  final Map<int, FeedPage> pages;

  @override
  Future<FeedPage> fetchPosts({required int page, int pageSize = 10}) async {
    return pages[page]!;
  }

  @override
  List<StoryItem> getStories() => stories;
}
