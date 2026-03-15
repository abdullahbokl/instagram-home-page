import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/design/app_assets.dart';
import '../../../../shared/design/app_icon_sizes.dart';
import '../../../../shared/design/app_spacing.dart';
import '../../../../shared/presentation/widgets/app_icon_action.dart';
import '../../../../shared/presentation/widgets/app_svg_icon.dart';

class PostActions extends StatelessWidget {
  const PostActions({
    required this.isLiked,
    required this.isSaved,
    required this.onLikePressed,
    required this.onCommentPressed,
    required this.onSharePressed,
    required this.onSavePressed,
    super.key,
  });

  final bool isLiked;
  final bool isSaved;
  final VoidCallback onLikePressed;
  final VoidCallback onCommentPressed;
  final VoidCallback onSharePressed;
  final VoidCallback onSavePressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return SizedBox(
      height: AppSpacing.touchTarget,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIconAction(
            semanticLabel: 'Like post',
            onPressed: onLikePressed,
            child: FaIcon(
              isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              size: AppIconSizes.large,
              color: isLiked ? const Color(0xFFED4956) : colors.primaryText,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          AppIconAction(
            semanticLabel: 'Comment on post',
            onPressed: onCommentPressed,
            child: AppSvgIcon(
              assetPath: AppAssets.comment,
              color: colors.primaryText,
              width: 22,
              height: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          AppIconAction(
            semanticLabel: 'Share post',
            onPressed: onSharePressed,
            child: AppSvgIcon(
              assetPath: AppAssets.messenger,
              color: colors.primaryText,
              width: 23,
              height: 20,
            ),
          ),
          const Spacer(),
          AppIconAction(
            semanticLabel: 'Save post',
            onPressed: onSavePressed,
            child: AppSvgIcon(
              assetPath: AppAssets.save,
              color: colors.primaryText.withValues(alpha: isSaved ? 1.0 : 0.92),
              width: 20,
              height: 22,
            ),
          ),
        ],
      ),
    );
  }
}
