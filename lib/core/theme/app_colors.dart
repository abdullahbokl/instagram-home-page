import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.primaryText,
    required this.secondaryText,
    required this.separator,
    required this.subtleSeparator,
    required this.blueAccent,
    required this.liveGradientStart,
    required this.liveGradientEnd,
    required this.pillBackground,
    required this.failure,
    required this.success,
  });

  final Color background;
  final Color surface;
  final Color primaryText;
  final Color secondaryText;
  final Color separator;
  final Color subtleSeparator;
  final Color blueAccent;
  final Color liveGradientStart;
  final Color liveGradientEnd;
  final Color pillBackground;
  final Color failure;
  final Color success;

  static const AppColors light = AppColors(
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF8F9FA),
    primaryText: Color(0xFF000000),
    secondaryText: Color(0xFF8E8E8E),
    separator: Color(0xFFDBDBDB),
    subtleSeparator: Color(0xFFDBDBDB),
    blueAccent: Color(0xFF0095F6),
    liveGradientStart: Color(0xFFC90083),
    liveGradientEnd: Color(0xFFE10038),
    pillBackground: Color(0xB2121212),
    failure: Color(0xFFFF453A),
    success: Color(0xFF34C759),
  );

  static const AppColors dark = AppColors(
    background: Color(0xFF121212),
    surface: Color(0xFF121212),
    primaryText: Color(0xFFE0E0E0),
    secondaryText: Color(0xFFA0A0A0),
    separator: Color(0xFF262626),
    subtleSeparator: Color(0xFF262626),
    blueAccent: Color(0xFF0095F6),
    liveGradientStart: Color(0xFFC90083),
    liveGradientEnd: Color(0xFFE10038),
    pillBackground: Color(0xB2121212),
    failure: Color(0xFFFF6961),
    success: Color(0xFF32D74B),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? primaryText,
    Color? secondaryText,
    Color? separator,
    Color? subtleSeparator,
    Color? blueAccent,
    Color? liveGradientStart,
    Color? liveGradientEnd,
    Color? pillBackground,
    Color? failure,
    Color? success,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      separator: separator ?? this.separator,
      subtleSeparator: subtleSeparator ?? this.subtleSeparator,
      blueAccent: blueAccent ?? this.blueAccent,
      liveGradientStart: liveGradientStart ?? this.liveGradientStart,
      liveGradientEnd: liveGradientEnd ?? this.liveGradientEnd,
      pillBackground: pillBackground ?? this.pillBackground,
      failure: failure ?? this.failure,
      success: success ?? this.success,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      background: Color.lerp(background, other.background, t) ?? background,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      primaryText: Color.lerp(primaryText, other.primaryText, t) ?? primaryText,
      secondaryText:
          Color.lerp(secondaryText, other.secondaryText, t) ?? secondaryText,
      separator: Color.lerp(separator, other.separator, t) ?? separator,
      subtleSeparator:
          Color.lerp(subtleSeparator, other.subtleSeparator, t) ??
          subtleSeparator,
      blueAccent: Color.lerp(blueAccent, other.blueAccent, t) ?? blueAccent,
      liveGradientStart:
          Color.lerp(liveGradientStart, other.liveGradientStart, t) ??
          liveGradientStart,
      liveGradientEnd:
          Color.lerp(liveGradientEnd, other.liveGradientEnd, t) ??
          liveGradientEnd,
      pillBackground:
          Color.lerp(pillBackground, other.pillBackground, t) ?? pillBackground,
      failure: Color.lerp(failure, other.failure, t) ?? failure,
      success: Color.lerp(success, other.success, t) ?? success,
    );
  }
}
