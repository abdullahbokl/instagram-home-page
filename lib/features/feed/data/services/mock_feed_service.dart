import '../../domain/models/feed_page.dart';
import '../../domain/models/feed_post.dart';
import '../../domain/models/feed_user.dart';
import '../../domain/models/media_item.dart';
import '../../domain/models/story_item.dart';
import '../../../../core/constants/app_dimensions.dart';

class MockFeedService {
  const MockFeedService();

  static const int totalPages = 4;

  static const List<_ProfileSeed> _profiles = [
    _ProfileSeed(
      id: 'u1',
      username: 'joshua_l',
      avatarUrl: 'https://i.pravatar.cc/300?img=12',
      isVerified: true,
    ),
    _ProfileSeed(
      id: 'u2',
      username: 'karennne',
      avatarUrl: 'https://i.pravatar.cc/300?img=32',
    ),
    _ProfileSeed(
      id: 'u3',
      username: 'zackjohn',
      avatarUrl: 'https://i.pravatar.cc/300?img=14',
    ),
    _ProfileSeed(
      id: 'u4',
      username: 'kieron_d',
      avatarUrl: 'https://i.pravatar.cc/300?img=25',
    ),
    _ProfileSeed(
      id: 'u5',
      username: 'craig_love',
      avatarUrl: 'https://i.pravatar.cc/300?img=47',
    ),
    _ProfileSeed(
      id: 'u6',
      username: 'marina.g',
      avatarUrl: 'https://i.pravatar.cc/300?img=5',
      isVerified: true,
    ),
    _ProfileSeed(
      id: 'u7',
      username: 'noah.eats',
      avatarUrl: 'https://i.pravatar.cc/300?img=21',
    ),
    _ProfileSeed(
      id: 'u8',
      username: 'emery.day',
      avatarUrl: 'https://i.pravatar.cc/300?img=36',
    ),
  ];

  static const List<String> _captions = [
    'Golden hour hit perfectly and the whole street looked unreal.',
    'Weekend photo dump with the kind of weather we needed all month.',
    'A little quiet coffee stop before the rest of the day got loud.',
    'The details on this place were too good not to save for later.',
    'Still thinking about how good this gallery and soundtrack pairing was.',
    'Quick reset, clean air, and a skyline that did all the work.',
    'Could not pick one frame, so the carousel had to happen.',
    'Tiny moments from today that felt better than the big plans.',
  ];

  static const List<String> _locations = [
    'Tokyo, Japan',
    'Brooklyn, New York',
    'Cairo, Egypt',
    'Paris, France',
    'Seoul, South Korea',
    'Barcelona, Spain',
    'Istanbul, Turkey',
    'Lisbon, Portugal',
  ];

  static const List<String> _dateLabels = [
    '2 HOURS AGO',
    '5 HOURS AGO',
    'YESTERDAY',
    'MARCH 10',
    'MARCH 8',
    'MARCH 6',
  ];

  static const List<List<String>> _mediaPools = [
    [
      'https://picsum.photos/id/1011/1200/1200',
      'https://picsum.photos/id/1015/1200/1200',
      'https://picsum.photos/id/1016/1200/1200',
    ],
    [
      'https://picsum.photos/id/1025/1200/1200',
      'https://picsum.photos/id/1027/1200/1200',
    ],
    ['https://picsum.photos/id/1035/1200/1200'],
    [
      'https://picsum.photos/id/1040/1200/1200',
      'https://picsum.photos/id/1041/1200/1200',
      'https://picsum.photos/id/1042/1200/1200',
    ],
    ['https://picsum.photos/id/1050/1200/1200'],
    [
      'https://picsum.photos/id/1060/1200/1200',
      'https://picsum.photos/id/1068/1200/1200',
    ],
    [
      'https://picsum.photos/id/1074/1200/1200',
      'https://picsum.photos/id/1081/1200/1200',
      'https://picsum.photos/id/1082/1200/1200',
    ],
    ['https://picsum.photos/id/1084/1200/1200'],
    [
      'https://picsum.photos/id/1080/1200/1200',
      'https://picsum.photos/id/1083/1200/1200',
    ],
    ['https://picsum.photos/id/1081/1200/1200'],
  ];

  List<StoryItem> buildStories() {
    return List<StoryItem>.generate(_profiles.length, (index) {
      final profile = _profiles[index];
      return StoryItem(
        id: 'story-$index',
        user: FeedUser(
          id: profile.id,
          username: profile.username,
          avatarUrl: profile.avatarUrl,
          isVerified: profile.isVerified,
        ),
        isOwn: index == 0,
        isLive: index == 1,
        isViewed: index > 4,
      );
    });
  }

  FeedPage buildFeedPage({required int page, int pageSize = 10}) {
    final posts = List<FeedPost>.generate(pageSize, (index) {
      final seedIndex = (page * pageSize) + index;
      final profile = _profiles[seedIndex % _profiles.length];
      final likedByProfile = _profiles[(seedIndex + 4) % _profiles.length];
      final mediaSet = _mediaPools[seedIndex % _mediaPools.length];
      return FeedPost(
        id: 'post-$seedIndex',
        user: FeedUser(
          id: profile.id,
          username: profile.username,
          avatarUrl: profile.avatarUrl,
          isVerified: profile.isVerified,
        ),
        location: _locations[seedIndex % _locations.length],
        caption: _captions[seedIndex % _captions.length],
        likedByUsername: likedByProfile.username,
        likedByAvatarUrl: likedByProfile.avatarUrl,
        likeCount: 18230 + (seedIndex * 347),
        dateLabel: _dateLabels[seedIndex % _dateLabels.length],
        mediaItems: mediaSet
            .asMap()
            .entries
            .map(
              (entry) => MediaItem(
                id: 'post-$seedIndex-media-${entry.key}',
                imageUrl: entry.value,
                aspectRatio: _aspectRatioFor(seedIndex + entry.key),
              ),
            )
            .toList(growable: false),
        isLiked: seedIndex.isEven,
        isSaved: seedIndex % 5 == 0,
      );
    });

    return FeedPage(
      posts: posts,
      hasMore: page < totalPages - 1,
      nextPage: page + 1,
    );
  }

  double _aspectRatioFor(int seed) {
    final index = seed % 10;
    if (index <= 6) {
      return AppDimensions.defaultFeedAspectRatio;
    }
    if (index <= 8) {
      return AppDimensions.compactFeedAspectRatio;
    }
    return AppDimensions.tallFeedAspectRatio;
  }
}

class _ProfileSeed {
  const _ProfileSeed({
    required this.id,
    required this.username,
    required this.avatarUrl,
    this.isVerified = false,
  });

  final String id;
  final String username;
  final String avatarUrl;
  final bool isVerified;
}
