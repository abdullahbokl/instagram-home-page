import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/presentation/widgets/app_avatar.dart';
import '../../domain/models/story_item.dart';

class StoryAvatar extends StatelessWidget {
  const StoryAvatar({required this.story, super.key});

  final StoryItem story;

  static const _unviewedGradient = LinearGradient(
    colors: [
      Color(0xFFFEDA75),
      Color(0xFFFA7E1E),
      Color(0xFFD62976), // Manual hex for colors.liveGradientStart
      Color(0xFF962FBF), // Manual hex for colors.liveGradientEnd
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final ringGradient = story.isViewed
        ? LinearGradient(
            colors: [
              colors.separator.withValues(alpha: 0.55),
              colors.separator.withValues(alpha: 0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : _unviewedGradient;

    return SizedBox(
      width: AppDimensions.storyCardWidth,
      child: Column(
        children: [
          RepaintBoundary(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: AppDimensions.storyAvatarOuter,
                  height: AppDimensions.storyAvatarOuter,
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: ringGradient,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.background,
                    ),
                    child: AppAvatar(
                      imageUrl: story.user.avatarUrl,
                      size: AppDimensions.storyAvatarInner,
                    ),
                  ),
                ),
                if (story.isLive)
                  Positioned(
                    left: 18,
                    bottom: -5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                          colors: [
                            colors.liveGradientStart,
                            colors.liveGradientEnd,
                          ],
                        ),
                        border: Border.all(color: colors.background, width: 2),
                      ),
                      child: Text('LIVE', style: AppTextStyles.liveBadge()),
                    ),
                  ),
                if (story.isOwn)
                  Positioned(
                    right: -1,
                    bottom: 3,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: colors.blueAccent,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.background, width: 2),
                      ),
                      child:
                          const Icon(Icons.add, size: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            story.isOwn ? 'Your Story' : story.user.username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.storyLabel(colors),
          ),
        ],
      ),
    );
  }
}
