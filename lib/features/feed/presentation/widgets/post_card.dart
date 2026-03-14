import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/feed_snackbar.dart';
import '../../domain/models/feed_post.dart';
import '../bloc/feed_bloc.dart';
import '../mappers/feed_post_view_data_mapper.dart';
import 'carousel_indicator.dart';
import 'post_actions.dart';
import 'post_caption.dart';
import 'post_header.dart';
import 'post_media_carousel.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    required this.post,
    required this.onZoomStateChanged,
    super.key,
  });

  final FeedPost post;
  final ValueChanged<bool> onZoomStateChanged;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  static const _viewDataMapper = FeedPostViewDataMapper();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FeedBloc>();
    final postViewData = _viewDataMapper(widget.post);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostHeader(
          post: postViewData,
          onMorePressed: () => showFeedSnackbar(
            context,
            'More actions are not implemented in this demo yet.',
          ),
        ),
        PostMediaCarousel(
          mediaItems: widget.post.mediaItems,
          currentIndex: _currentIndex,
          onZoomStateChanged: widget.onZoomStateChanged,
          onPageChanged: (index) {
            if (_currentIndex != index) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
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
              if (widget.post.mediaItems.length > 1)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CarouselIndicator(
                      count: widget.post.mediaItems.length,
                      currentIndex: _currentIndex,
                    ),
                  ),
                ),
              PostActions(
                isLiked: postViewData.isLiked,
                isSaved: postViewData.isSaved,
                onLikePressed: () => bloc.add(FeedLikeToggled(postViewData.id)),
                onCommentPressed: () => showFeedSnackbar(
                  context,
                  'Comments are not implemented in this demo yet.',
                ),
                onSharePressed: () => showFeedSnackbar(
                  context,
                  'Share is not implemented in this demo yet.',
                ),
                onSavePressed: () => bloc.add(FeedSaveToggled(postViewData.id)),
              ),
              const SizedBox(height: 14),
              PostCaption(post: postViewData),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ],
    );
  }
}
