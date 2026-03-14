import 'package:flutter/material.dart';

import '../../../core/constants/app_dimensions.dart';

class AppTopBarDelegate extends SliverPersistentHeaderDelegate {
  AppTopBarDelegate({
    required this.topInset,
    required this.child,
    required this.backgroundColor,
    required this.borderColor,
  });

  final double topInset;
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;

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
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.only(
        top: topInset,
        left: AppDimensions.topBarHorizontalPadding,
        right: AppDimensions.topBarHorizontalPadding,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: borderColor)),
        ),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant AppTopBarDelegate oldDelegate) {
    return oldDelegate.topInset != topInset ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.child != child;
  }
}

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    this.leading,
    this.center,
    this.trailing = const <Widget>[],
    super.key,
  });

  final Widget? leading;
  final Widget? center;
  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.topBarContentHeight,
      child: Row(
        children: [
          SizedBox(width: 28, child: leading),
          const Spacer(),
          center ?? const SizedBox.shrink(),
          const Spacer(),
          Row(mainAxisSize: MainAxisSize.min, children: trailing),
        ],
      ),
    );
  }
}
