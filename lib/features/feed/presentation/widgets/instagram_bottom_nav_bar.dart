import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/feed_snackbar.dart';
import '../../../../shared/design/app_assets.dart';
import '../../../../shared/presentation/widgets/app_avatar.dart';
import '../../../../shared/presentation/widgets/app_bottom_nav_bar.dart';
import '../../../../shared/presentation/widgets/app_svg_icon.dart';

class InstagramBottomNavBar extends StatelessWidget {
  const InstagramBottomNavBar({super.key});

  static const String _profileAvatarUrl = 'https://i.pravatar.cc/300?img=12';

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AppBottomNavBar(
      backgroundColor: colors.surface,
      borderColor: colors.subtleSeparator,
      items: [
        _BottomNavSvgItem(
          assetPath: AppAssets.navHome,
          isSelected: true,
          semanticLabel: 'Home',
        ),
        _BottomNavSvgItem(
          assetPath: AppAssets.navSearch,
          semanticLabel: 'Search',
          onPressed: () => _showNotImplemented(context, 'Search'),
        ),
        _BottomNavSvgItem(
          assetPath: AppAssets.navCreate,
          semanticLabel: 'Create',
          onPressed: () => _showNotImplemented(context, 'Create'),
        ),
        _BottomNavIconItem(
          semanticLabel: 'Activity',
          icon: Icons.favorite_border_rounded,
          onPressed: () => _showNotImplemented(context, 'Activity'),
        ),
        _BottomNavAvatar(
          imageUrl: _profileAvatarUrl,
          onPressed: () => _showNotImplemented(context, 'Profile'),
        ),
      ],
    );
  }

  void _showNotImplemented(BuildContext context, String label) {
    showFeedSnackbar(
      context,
      '$label navigation is not implemented in this demo yet.',
    );
  }
}

class _BottomNavAvatar extends StatelessWidget {
  const _BottomNavAvatar({required this.imageUrl, required this.onPressed});

  final String imageUrl;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return IconButton(
      onPressed: onPressed,
      splashRadius: 22,
      icon: Container(
        width: 24,
        height: 24,
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors.primaryText.withValues(alpha: 0.6)),
        ),
        child: AppAvatar(imageUrl: imageUrl, size: 21),
      ),
      tooltip: 'Profile',
    );
  }
}

class _BottomNavSvgItem extends StatelessWidget {
  const _BottomNavSvgItem({
    required this.assetPath,
    required this.semanticLabel,
    this.isSelected = false,
    this.onPressed,
  });

  final String assetPath;
  final String semanticLabel;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return IconButton(
      onPressed: onPressed,
      splashRadius: 22,
      icon: Opacity(
        opacity: isSelected ? 1 : 0.92,
        child: AppSvgIcon(
          assetPath: assetPath,
          color: colors.primaryText,
          width: 24,
          height: 24,
        ),
      ),
      isSelected: isSelected,
      tooltip: semanticLabel,
    );
  }
}

class _BottomNavIconItem extends StatelessWidget {
  const _BottomNavIconItem({
    required this.semanticLabel,
    required this.icon,
    this.onPressed,
  });

  final String semanticLabel;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return IconButton(
      onPressed: onPressed,
      splashRadius: 22,
      icon: Icon(icon, size: 26, color: colors.primaryText),
      tooltip: semanticLabel,
    );
  }
}
