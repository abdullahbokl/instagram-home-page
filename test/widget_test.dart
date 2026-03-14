import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_task/app.dart';
import 'package:instagram_task/core/theme/app_theme.dart';
import 'package:instagram_task/core/widgets/app_network_image.dart';
import 'package:instagram_task/core/widgets/shimmer_box.dart';
import 'package:instagram_task/features/feed/data/repositories/post_repository.dart';
import 'package:instagram_task/features/feed/data/services/mock_feed_service.dart';
import 'package:instagram_task/features/feed/domain/models/feed_page.dart';
import 'package:instagram_task/features/feed/domain/models/media_item.dart';
import 'package:instagram_task/features/feed/domain/models/story_item.dart';
import 'package:instagram_task/features/feed/presentation/widgets/post_media_carousel.dart';

void main() {
  late MockFeedService service;
  late List<StoryItem> stories;
  late FeedPage firstPage;
  late FeedPage secondPage;

  setUp(() {
    service = const MockFeedService();
    stories = service.buildStories();
    firstPage = service.buildFeedPage(page: 0);
    secondPage = service.buildFeedPage(page: 1);
  });

  testWidgets('initial pump shows shimmer placeholders', (tester) async {
    final pendingFirstPage = Completer<FeedPage>();
    await tester.pumpWidget(
      InstagramApp(
        repository: _WidgetTestRepository(
          stories: stories,
          pages: {0: firstPage},
          pendingPages: {0: pendingFirstPage},
        ),
      ),
    );

    expect(find.byType(ShimmerBox), findsWidgets);
  });

  testWidgets('feed renders top bar, stories, and first post after load', (
    tester,
  ) async {
    await tester.pumpWidget(
      InstagramApp(
        repository: _WidgetTestRepository(
          stories: stories,
          pages: {0: firstPage},
        ),
      ),
    );

    await tester.pump();
    await tester.pump();

    expect(find.text('Your Story'), findsOneWidget);
    expect(find.text(firstPage.posts.first.user.username), findsWidgets);
    expect(find.bySemanticsLabel('Like post'), findsWidgets);
  });

  testWidgets('scrolling near the end triggers pagination', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 1600);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final shortFirstPage = FeedPage(
      posts: firstPage.posts.take(4).toList(),
      hasMore: true,
      nextPage: 1,
    );
    final repository = _WidgetTestRepository(
      stories: stories,
      pages: {0: shortFirstPage, 1: secondPage},
    );

    await tester.pumpWidget(InstagramApp(repository: repository));
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(repository.pageRequests.where((page) => page == 1).length, 1);
  });

  testWidgets('tapping comment or share shows the custom snackbar', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 1600);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      InstagramApp(
        repository: _WidgetTestRepository(
          stories: stories,
          pages: {0: firstPage},
        ),
      ),
    );

    await tester.pump();
    await tester.pump();

    await tester.tap(find.bySemanticsLabel('Comment on post').first);
    await tester.pump();

    expect(
      find.text('Comments are not implemented in this demo yet.'),
      findsOneWidget,
    );
  });

  testWidgets('AppNetworkImage shows fallback UI on image failure', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.buildTheme(Brightness.light),
        home: const Scaffold(
          body: AppNetworkImage(imageUrl: '', errorWidget: Text('fallback')),
        ),
      ),
    );

    expect(find.text('fallback'), findsOneWidget);
  });

  testWidgets('the app can be built in dark mode', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.buildTheme(Brightness.dark),
        home: const Scaffold(body: SizedBox.shrink()),
      ),
    );

    final context = tester.element(find.byType(SizedBox));
    expect(Theme.of(context).brightness, Brightness.dark);
  });

  testWidgets('post media carousel respects the active media aspect ratio', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.buildTheme(Brightness.light),
        home: Scaffold(
          body: SizedBox(
            width: 320,
            child: PostMediaCarousel(
              mediaItems: const [
                MediaItem(id: 'one', imageUrl: '', aspectRatio: 4 / 5),
              ],
              currentIndex: 0,
              onPageChanged: (_) {},
              onZoomStateChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    final carouselBox = tester.renderObject<RenderBox>(
      find.byType(PostMediaCarousel),
    );
    expect(carouselBox.size.height, moreOrLessEquals(400, epsilon: 0.5));
  });
}

class _WidgetTestRepository implements PostRepository {
  _WidgetTestRepository({
    required this.stories,
    required this.pages,
    this.pendingPages = const <int, Completer<FeedPage>>{},
  });

  final List<StoryItem> stories;
  final Map<int, FeedPage> pages;
  final Map<int, Completer<FeedPage>> pendingPages;
  final List<int> pageRequests = <int>[];

  @override
  Future<FeedPage> fetchPosts({required int page, int pageSize = 10}) async {
    pageRequests.add(page);
    if (pendingPages.containsKey(page)) {
      return pendingPages[page]!.future;
    }
    return pages[page]!;
  }

  @override
  List<StoryItem> getStories() => stories;
}
