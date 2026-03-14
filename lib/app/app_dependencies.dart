import '../features/feed/data/repositories/mock_post_repository.dart';
import '../features/feed/data/repositories/post_repository.dart';
import '../features/feed/data/services/mock_feed_service.dart';
import '../features/feed/domain/usecases/load_feed_page_use_case.dart';
import '../features/feed/domain/usecases/toggle_post_like_use_case.dart';
import '../features/feed/domain/usecases/toggle_post_save_use_case.dart';

class AppDependencies {
  AppDependencies({
    required this.postRepository,
    LoadFeedPageUseCase? loadFeedPageUseCase,
    TogglePostLikeUseCase? togglePostLikeUseCase,
    TogglePostSaveUseCase? togglePostSaveUseCase,
  }) : loadFeedPageUseCase =
           loadFeedPageUseCase ??
           LoadFeedPageUseCase(repository: postRepository),
       togglePostLikeUseCase =
           togglePostLikeUseCase ?? const TogglePostLikeUseCase(),
       togglePostSaveUseCase =
           togglePostSaveUseCase ?? const TogglePostSaveUseCase();

  factory AppDependencies.create() {
    const service = MockFeedService();
    return AppDependencies(
      postRepository: const MockPostRepository(service: service),
    );
  }

  factory AppDependencies.fromRepository(PostRepository repository) {
    return AppDependencies(postRepository: repository);
  }

  final PostRepository postRepository;
  final LoadFeedPageUseCase loadFeedPageUseCase;
  final TogglePostLikeUseCase togglePostLikeUseCase;
  final TogglePostSaveUseCase togglePostSaveUseCase;
}
