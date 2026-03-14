import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/design/app_assets.dart';
import '../../../../shared/presentation/widgets/app_avatar.dart';
import '../models/feed_post_view_data.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    required this.post,
    required this.onMorePressed,
    super.key,
  });

  final FeedPostViewData post;
  final VoidCallback onMorePressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return SizedBox(
      height: AppDimensions.postHeaderHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            AppAvatar(
              imageUrl: post.userAvatarUrl,
              size: AppDimensions.postAvatarSize,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          post.username,
                          style: AppTextStyles.username(colors),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (post.isVerified) ...[
                        const SizedBox(width: 4),
                        SvgPicture.asset(
                          AppAssets.verifiedBadge,
                          width: 10,
                          height: 10,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 1),
                  Text(
                    post.location,
                    style: AppTextStyles.location(colors),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onMorePressed,
              splashRadius: 18,
              icon: Icon(Icons.more_horiz, color: colors.primaryText, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
