import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static TextStyle username(AppColors colors) {
    return TextStyle(
      color: colors.primaryText,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 18 / 14,
    );
  }

  static TextStyle caption(AppColors colors) {
    return TextStyle(
      color: colors.primaryText,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 18 / 14,
    );
  }

  static TextStyle location(AppColors colors) {
    return TextStyle(
      color: colors.primaryText,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 14 / 12,
    );
  }

  static TextStyle meta(AppColors colors) {
    return TextStyle(
      color: colors.secondaryText,
      fontSize: 11,
      fontWeight: FontWeight.w400,
      height: 13 / 11,
    );
  }

  static TextStyle storyLabel(AppColors colors) {
    return TextStyle(
      color: colors.primaryText,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 14 / 12,
      letterSpacing: -0.01,
    );
  }

  static TextStyle liveBadge() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 8,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.0,
    );
  }

  static TextStyle snackbar(AppColors colors) {
    return TextStyle(
      color: colors.primaryText,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      height: 18 / 13,
    );
  }
}
