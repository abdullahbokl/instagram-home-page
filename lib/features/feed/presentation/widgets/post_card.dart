import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/feed_snackbar.dart';
import '../../../../shared/design/app_widget_keys.dart';
import '../../domain/models/feed_post.dart';
import '../../domain/models/media_item.dart';
import '../bloc/feed_bloc.dart';
import '../mappers/feed_post_view_data_mapper.dart';
import 'carousel_indicator.dart';
import 'post_actions.dart';
import 'post_caption.dart';
import 'post_header.dart';
import 'post_media_carousel.dart';

import '../models/feed_post_view_data.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    required this.postId,
    required this.onZoomStateChanged,
    super.key,
  });

  final String postId;
  final ValueChanged<bool> onZoomStateChanged;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FeedBloc, FeedState, FeedPostViewData?>(
      selector: (state) {
        final post = _findPostById(state.posts, postId);
        if (post == null) return null;
        return const FeedPostViewDataMapper().call(post);
      },
      builder: (context, postViewData) {
        if (postViewData == null) {
          return const SizedBox.shrink();
        }

        final bloc = context.read<FeedBloc>();
        return RepaintBoundary(
          key: AppWidgetKeys.postCard(postViewData.id),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RepaintBoundary(
                child: PostHeader(
                  post: postViewData,
                  onMorePressed: () => showFeedSnackbar(
                    context,
                    'More actions are not implemented in this demo yet.',
                  ),
                ),
              ),
              _PostMediaSection(
                postId: postViewData.id,
                mediaItems: postViewData.mediaItems,
                onZoomStateChanged: onZoomStateChanged,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.feedHorizontalPadding,
                  12,
                  AppDimensions.feedHorizontalPadding,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RepaintBoundary(
                      child: PostActions(
                        isLiked: postViewData.isLiked,
                        isSaved: postViewData.isSaved,
                        onLikePressed: () =>
                            bloc.add(FeedLikeToggled(postViewData.id)),
                        onCommentPressed: () => showFeedSnackbar(
                          context,
                          'Comments are not implemented in this demo yet.',
                        ),
                        onSharePressed: () => showFeedSnackbar(
                          context,
                          'Share is not implemented in this demo yet.',
                        ),
                        onSavePressed: () =>
                            bloc.add(FeedSaveToggled(postViewData.id)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    PostCaption(post: postViewData),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PostMediaSection extends StatefulWidget {
  const _PostMediaSection({
    required this.postId,
    required this.mediaItems,
    required this.onZoomStateChanged,
  });

  final String postId;
  final List<MediaItem> mediaItems;
  final ValueChanged<bool> onZoomStateChanged;

  @override
  State<_PostMediaSection> createState() => _PostMediaSectionState();
}

class _PostMediaSectionState extends State<_PostMediaSection> {
  late final ValueNotifier<int> _currentIndexNotifier;

  @override
  void initState() {
    super.initState();
    _currentIndexNotifier = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostMediaCarousel(
          postId: widget.postId,
          mediaItems: widget.mediaItems,
          currentIndexListenable: _currentIndexNotifier,
          onZoomStateChanged: widget.onZoomStateChanged,
          onPageChanged: (index) {
            if (_currentIndexNotifier.value != index) {
              _currentIndexNotifier.value = index;
            }
          },
        ),
        if (widget.mediaItems.length > 1)
          ValueListenableBuilder<int>(
            valueListenable: _currentIndexNotifier,
            builder: (context, currentIndex, child) => Padding(
              padding: const EdgeInsets.only(top: 12),
              child: CarouselIndicator(
                count: widget.mediaItems.length,
                currentIndex: currentIndex,
              ),
            ),
          ),
      ],
    );
  }
}

FeedPost? _findPostById(List<FeedPost> posts, String postId) {
  for (final post in posts) {
    if (post.id == postId) {
      return post;
    }
  }
  return null;
}
