import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_task/core/constants/app_dimensions.dart';
import 'package:instagram_task/features/feed/data/repositories/mock_post_repository.dart';
import 'package:instagram_task/features/feed/data/services/mock_feed_service.dart';

void main() {
  group('MockPostRepository', () {
    test('waits 1.5 seconds before returning data', () async {
      final repository = MockPostRepository(service: const MockFeedService());
      final watch = Stopwatch()..start();

      await repository.fetchPosts(page: 0);

      watch.stop();
      expect(watch.elapsedMilliseconds, greaterThanOrEqualTo(1450));
    });

    test('returns 10 posts and increments nextPage', () async {
      final repository = MockPostRepository(service: const MockFeedService());

      final page = await repository.fetchPosts(page: 0);

      expect(page.posts, hasLength(10));
      expect(page.nextPage, 1);
      expect(page.hasMore, isTrue);
    });

    test(
      'seeds mostly 4:5 media ratios with square and 3:4 variants',
      () async {
        final repository = MockPostRepository(service: const MockFeedService());

        final page = await repository.fetchPosts(page: 0);
        final ratios = page.posts
            .expand((post) => post.mediaItems.map((media) => media.aspectRatio))
            .toSet();

        expect(ratios, contains(AppDimensions.defaultFeedAspectRatio));
        expect(ratios, contains(AppDimensions.compactFeedAspectRatio));
        expect(ratios, contains(AppDimensions.tallFeedAspectRatio));
      },
    );
  });
}
