import '../../domain/models/feed_page.dart';
import '../../domain/models/story_item.dart';
import '../services/mock_feed_service.dart';
import 'post_repository.dart';

class MockPostRepository implements PostRepository {
  const MockPostRepository({required this.service});

  final MockFeedService service;

  @override
  Future<FeedPage> fetchPosts({required int page, int pageSize = 10}) async {
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    return service.buildFeedPage(page: page, pageSize: pageSize);
  }

  @override
  List<StoryItem> getStories() => service.buildStories();
}
