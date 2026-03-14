import '../../domain/models/feed_page.dart';
import '../../domain/models/story_item.dart';

abstract class PostRepository {
  Future<FeedPage> fetchPosts({required int page, int pageSize = 10});

  List<StoryItem> getStories();
}
