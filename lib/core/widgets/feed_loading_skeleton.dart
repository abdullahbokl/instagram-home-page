import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/app_dimensions.dart';
import '../theme/app_theme.dart';
import '../../shared/design/app_widget_keys.dart';
import '../../shared/presentation/widgets/app_shimmer_scaffold.dart';
import 'shimmer_box.dart';

class FeedLoadingSkeleton extends StatelessWidget {
  const FeedLoadingSkeleton({
    required this.topInset,
    this.postCount = 2,
    super.key,
  });

  final double topInset;
  final int postCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return AppShimmerScaffold(
      key: AppWidgetKeys.shimmerScaffold,
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: topInset + AppDimensions.topBarContentHeight,
            padding: EdgeInsets.only(
              top: topInset + 8,
              left: AppDimensions.topBarHorizontalPadding,
              right: AppDimensions.topBarHorizontalPadding,
            ),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(bottom: BorderSide(color: colors.subtleSeparator)),
            ),
            child: const Row(
              children: [
                ShimmerBox(
                  width: 120,
                  height: 28,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                Spacer(),
                ShimmerBox(
                  width: 24,
                  height: 24,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                SizedBox(width: 18),
                ShimmerBox(
                  width: 24,
                  height: 24,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: AppDimensions.storiesHeight,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 9),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => const Column(
                  children: [
                    ShimmerBox(width: 62, height: 62, shape: BoxShape.circle),
                    SizedBox(height: 7),
                    ShimmerBox(
                      width: 54,
                      height: 12,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ],
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppDimensions.storyGap),
                itemCount: 4,
              ),
            ),
          ),
        ),
        SliverList.builder(
          itemCount: postCount,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: _PostSkeleton(),
          ),
        ),
      ],
    );
  }
}

class PaginationPostSkeleton extends StatelessWidget {
  const PaginationPostSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1E1E1E)
        : const Color(0xFFE8E8E8);
    final highlightColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF2A2A2A)
        : const Color(0xFFF4F4F4);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: const Padding(
        key: AppWidgetKeys.paginationSkeleton,
        padding: EdgeInsets.only(bottom: 24),
        child: _PostSkeleton(compactHeader: true),
      ),
    );
  }
}

class _PostSkeleton extends StatelessWidget {
  const _PostSkeleton({this.compactHeader = false});

  final bool compactHeader;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppDimensions.postHeaderHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const ShimmerBox(width: 32, height: 32, shape: BoxShape.circle),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ShimmerBox(
                        width: 120,
                        height: 14,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      if (!compactHeader) ...[
                        const SizedBox(height: 6),
                        const ShimmerBox(
                          width: 68,
                          height: 12,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ],
                    ],
                  ),
                ),
                const ShimmerBox(
                  width: 18,
                  height: 18,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ],
            ),
          ),
        ),
        const AspectRatio(
          aspectRatio: AppDimensions.defaultFeedAspectRatio,
          child: ShimmerBox(borderRadius: BorderRadius.zero),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 14, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _ShimmerIconPlaceholder(icon: FontAwesomeIcons.heart),
                  SizedBox(width: 14),
                  _ShimmerIconPlaceholder(icon: FontAwesomeIcons.comment),
                  SizedBox(width: 14),
                  _ShimmerIconPlaceholder(icon: FontAwesomeIcons.paperPlane),
                  Spacer(),
                  _ShimmerIconPlaceholder(icon: FontAwesomeIcons.bookmark),
                ],
              ),
              SizedBox(height: 14),
              ShimmerBox(
                width: 260,
                height: 14,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              SizedBox(height: 12),
              ShimmerBox(
                width: 280,
                height: 14,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              SizedBox(height: 8),
              ShimmerBox(
                width: 140,
                height: 14,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              SizedBox(height: 12),
              ShimmerBox(
                width: 82,
                height: 10,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShimmerIconPlaceholder extends StatelessWidget {
  const _ShimmerIconPlaceholder({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 24,
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF2A2A2A)
          : const Color(0xFFE8E8E8),
    );
  }
}
