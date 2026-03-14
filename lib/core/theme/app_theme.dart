import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData buildTheme(Brightness brightness) {
    final palette = brightness == Brightness.dark
        ? AppColors.dark
        : AppColors.light;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: palette.primaryText,
      onPrimary: palette.background,
      secondary: palette.blueAccent,
      onSecondary: Colors.white,
      error: palette.failure,
      onError: Colors.white,
      surface: palette.surface,
      onSurface: palette.primaryText,
    );

    final base = ThemeData(
      useMaterial3: false,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.background,
      canvasColor: palette.background,
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.transparent,
      dividerColor: palette.subtleSeparator,
      extensions: <ThemeExtension<dynamic>>[palette],
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: palette.surface.withValues(alpha: 0.98),
        contentTextStyle: TextStyle(
          color: palette.primaryText,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: palette.separator.withValues(alpha: 0.25)),
        ),
      ),
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: palette.primaryText,
        displayColor: palette.primaryText,
      ),
    );
  }
}

extension AppThemeContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
