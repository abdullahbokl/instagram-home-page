import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_task/features/feed/data/services/mock_feed_service.dart';
import 'package:instagram_task/features/feed/presentation/mappers/feed_post_view_data_mapper.dart';

void main() {
  test('FeedPostViewDataMapper formats feed post into reusable presentation data', () {
    final service = const MockFeedService();
    final post = service.buildFeedPage(page: 0, pageSize: 1).posts.single;

    final result = const FeedPostViewDataMapper()(post);

    expect(result.id, post.id);
    expect(result.username, post.user.username);
    expect(result.userAvatarUrl, post.user.avatarUrl);
    expect(result.isVerified, post.user.isVerified);
    expect(result.likeCountLabel, contains(','));
    expect(result.mediaItems, post.mediaItems);
  });
}
