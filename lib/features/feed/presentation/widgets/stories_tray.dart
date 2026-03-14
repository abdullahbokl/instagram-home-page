import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/presentation/widgets/app_section_container.dart';
import '../../domain/models/story_item.dart';
import 'story_avatar.dart';

class StoriesTray extends StatelessWidget {
  const StoriesTray({required this.stories, super.key});

  final List<StoryItem> stories;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return AppSectionContainer(
      height: AppDimensions.storiesHeight,
      color: colors.background,
      border: Border(bottom: BorderSide(color: colors.subtleSeparator)),
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 9, bottom: 8),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => StoryAvatar(story: stories[index]),
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppDimensions.storyGap),
        itemCount: stories.length,
      ),
    );
  }
}
