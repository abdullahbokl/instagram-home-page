import '../../data/repositories/post_repository.dart';
import '../failures/feed_failure.dart';
import '../models/feed_page.dart';
import '../models/story_item.dart';

class InitialFeedLoad {
  const InitialFeedLoad({required this.stories, required this.page});

  final List<StoryItem> stories;
  final FeedPage page;
}

class LoadFeedPageUseCase {
  const LoadFeedPageUseCase({required PostRepository repository})
    : _repository = repository;

  final PostRepository _repository;

  Future<InitialFeedLoad> loadInitial() async {
    try {
      final stories = _repository.getStories();
      final page = await _repository.fetchPosts(page: 0);
      return InitialFeedLoad(stories: stories, page: page);
    } catch (_) {
      throw const FeedFailure('We could not load the feed right now.');
    }
  }

  Future<FeedPage> loadPage({required int page}) async {
    try {
      return await _repository.fetchPosts(page: page);
    } catch (_) {
      throw const FeedFailure('Could not load more posts.');
    }
  }
}
