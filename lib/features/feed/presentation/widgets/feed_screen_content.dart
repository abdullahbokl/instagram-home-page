import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/feed_loading_skeleton.dart';
import '../../../../core/widgets/feed_snackbar.dart';
import '../../../../shared/presentation/widgets/app_error_state.dart';
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
  bool _isZooming = false;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return BlocConsumer<FeedBloc, FeedState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage &&
          current.errorMessage != null,
      listener: (context, state) {
        if (state.errorMessage case final message?) {
          showFeedSnackbar(context, message);
        }
      },
      builder: (context, state) {
        if ((state.status == FeedStatus.initial ||
                state.status == FeedStatus.loading) &&
            state.posts.isEmpty) {
          return FeedLoadingSkeleton(topInset: topInset);
        }

        if (state.status == FeedStatus.failure && state.posts.isEmpty) {
          return AppErrorState(
            topPadding: topInset,
            title: 'Unable to load your feed.',
            actionLabel: 'Try again',
            onActionPressed: () =>
                context.read<FeedBloc>().add(const FeedStarted()),
          );
        }

        return CustomScrollView(
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
            SliverToBoxAdapter(child: StoriesTray(stories: state.stories)),
            FeedPostSliverList(
              posts: state.posts,
              isPaginating: state.isPaginating,
              onApproachingEnd: () =>
                  context.read<FeedBloc>().add(const FeedNextPageRequested()),
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
    );
  }
}
