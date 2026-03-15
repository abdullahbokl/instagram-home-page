import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/feed_snackbar.dart';
import '../../../../shared/design/app_assets.dart';
import '../../../../shared/design/app_spacing.dart';
import '../../../../shared/design/app_widget_keys.dart';
import '../../../../shared/presentation/widgets/app_icon_action.dart';
import '../../../../shared/presentation/widgets/app_svg_icon.dart';
import '../../../../shared/presentation/widgets/app_top_bar.dart';

class FeedTopBarDelegate extends SliverPersistentHeaderDelegate {
  FeedTopBarDelegate({required this.topInset});

  final double topInset;

  @override
  double get minExtent => topInset + AppDimensions.topBarContentHeight;

  @override
  double get maxExtent => topInset + AppDimensions.topBarContentHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final colors = context.appColors;
    return Container(
      color: colors.surface,
      padding: EdgeInsets.only(
        top: topInset,
        left: AppDimensions.topBarHorizontalPadding,
        right: AppDimensions.topBarHorizontalPadding,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: colors.subtleSeparator)),
        ),
        child: const FeedTopBar(),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant FeedTopBarDelegate oldDelegate) {
    return oldDelegate.topInset != topInset;
  }
}

class FeedTopBar extends StatelessWidget {
  const FeedTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return AppTopBar(
      key: AppWidgetKeys.topBar,
      leading: AppIconAction(
        semanticLabel: 'Open camera',
        onPressed: () => showFeedSnackbar(
          context,
          'Camera is not implemented in this demo yet.',
        ),
        child: AppSvgIcon(
          assetPath: AppAssets.camera,
          color: colors.primaryText,
          width: 24,
          height: 22,
        ),
      ),
      center: AppSvgIcon(
        assetPath: AppAssets.instagramWordmark,
        color: colors.primaryText,
        width: 111,
        height: 30,
      ),
      trailing: [
        AppIconAction(
          semanticLabel: 'Open activity',
          onPressed: () => showFeedSnackbar(
            context,
            'Activity is not implemented in this demo yet.',
          ),
          child: AppSvgIcon(
            assetPath: AppAssets.activity,
            color: colors.primaryText,
            width: 24,
            height: 25,
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        AppIconAction(
          semanticLabel: 'Open messages',
          onPressed: () => showFeedSnackbar(
            context,
            'Messages are not implemented in this demo yet.',
          ),
          child: AppSvgIcon(
            assetPath: AppAssets.messenger,
            color: colors.primaryText,
            width: 23,
            height: 20,
          ),
        ),
      ],
    );
  }
}
