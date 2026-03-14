import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/presentation/widgets/app_avatar.dart';
import '../models/feed_post_view_data.dart';

class PostCaption extends StatelessWidget {
  const PostCaption({required this.post, super.key});

  final FeedPostViewData post;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAvatar(
              imageUrl: post.likedByAvatarUrl,
              size: 17,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.caption(colors),
                  children: [
                    const TextSpan(text: 'Liked by '),
                    TextSpan(
                      text: post.likedByUsername,
                      style: AppTextStyles.username(colors),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: '${post.likeCountLabel} others',
                      style: AppTextStyles.username(colors),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        RichText(
          text: TextSpan(
            style: AppTextStyles.caption(colors),
            children: [
              TextSpan(
                text: post.username,
                style: AppTextStyles.username(colors),
              ),
              const TextSpan(text: ' '),
              TextSpan(text: post.caption),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(post.dateLabel, style: AppTextStyles.meta(colors)),
      ],
    );
  }
}
