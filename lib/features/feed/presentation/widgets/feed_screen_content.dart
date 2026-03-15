import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/feed_loading_skeleton.dart';
import '../../../../core/widgets/feed_snackbar.dart';
import '../../../../shared/design/app_widget_keys.dart';
import '../../../../shared/presentation/widgets/app_error_state.dart';
import '../../domain/models/story_item.dart';
import '../bloc/feed_bloc.dart';
import 'feed_post_sliver_list.dart';
import 'feed_top_bar.dart';
import 'stories_tray.dart';

class FeedScreenContent extends StatefulWidget {
  const FeedScreenContent({super.key});

  @override
  State<FeedScreenContent> createState() => _FeedScreenContentState();
}

class _FeedScreenContentState extends State<FeedScreenContent> {
  final ScrollController _scrollController = ScrollController();

  bool _isZooming = false;
  bool _paginationRequestInFlight = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;
    final threshold = position.viewportDimension * 2.2;
    if (position.extentAfter > threshold || _paginationRequestInFlight) {
      return;
    }

    final bloc = context.read<FeedBloc>();
    final state = bloc.state;
    if (state.status != FeedStatus.success ||
        state.isPaginating ||
        !state.hasMore) {
      return;
    }

    _paginationRequestInFlight = true;
    bloc.add(const FeedNextPageRequested());
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return BlocListener<FeedBloc, FeedState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.isPaginating != current.isPaginating,
      listener: (context, state) {
        if (!state.isPaginating) {
          _paginationRequestInFlight = false;
        }
        if (state.errorMessage case final message?) {
          showFeedSnackbar(context, message);
        }
      },
      child: BlocSelector<FeedBloc, FeedState, _FeedScreenViewData>(
        selector: (state) => _FeedScreenViewData(
          status: state.status,
          storyItems: state.stories,
          postIds: state.posts.map((post) => post.id).toList(growable: false),
          isPaginating: state.isPaginating,
          hasPosts: state.posts.isNotEmpty,
        ),
        builder: (context, viewData) {
          if ((viewData.status == FeedStatus.initial ||
                  viewData.status == FeedStatus.loading) &&
              !viewData.hasPosts) {
            return FeedLoadingSkeleton(topInset: topInset);
          }

          if (viewData.status == FeedStatus.failure && !viewData.hasPosts) {
            return AppErrorState(
              topPadding: topInset,
              title: 'Unable to load your feed.',
              actionLabel: 'Try again',
              onActionPressed: () =>
                  context.read<FeedBloc>().add(const FeedStarted()),
            );
          }

          return CustomScrollView(
            key: AppWidgetKeys.feedScrollView,
            controller: _scrollController,
            cacheExtent: 1800,
            physics: _isZooming
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: FeedTopBarDelegate(topInset: topInset),
              ),
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: StoriesTray(stories: viewData.storyItems),
                ),
              ),
              FeedPostSliverList(
                postIds: viewData.postIds,
                isPaginating: viewData.isPaginating,
                onZoomStateChanged: (isZooming) {
                  if (_isZooming != isZooming && mounted) {
                    setState(() {
                      _isZooming = isZooming;
                    });
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FeedScreenViewData {
  const _FeedScreenViewData({
    required this.status,
    required this.storyItems,
    required this.postIds,
    required this.isPaginating,
    required this.hasPosts,
  });

  final FeedStatus status;
  final List<StoryItem> storyItems;
  final List<String> postIds;
  final bool isPaginating;
  final bool hasPosts;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is _FeedScreenViewData &&
        other.status == status &&
        other.isPaginating == isPaginating &&
        other.hasPosts == hasPosts &&
        _listEquals(other.postIds, postIds) &&
        _listEquals(other.storyItems, storyItems);
  }

  @override
  int get hashCode => Object.hash(
    status,
    Object.hashAll(storyItems),
    Object.hashAll(postIds),
    isPaginating,
    hasPosts,
  );
}

bool _listEquals<T>(List<T> left, List<T> right) {
  if (identical(left, right)) {
    return true;
  }
  if (left.length != right.length) {
    return false;
  }
  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) {
      return false;
    }
  }
  return true;
}
