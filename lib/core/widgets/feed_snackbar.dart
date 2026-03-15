import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';

void showFeedSnackbar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 3),
}) {
  final colors = context.appColors;
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(
        AppDimensions.snackbarMargin,
        0,
        AppDimensions.snackbarMargin,
        24,
      ),
      elevation: 0,
      content: Text(message, style: AppTextStyles.snackbar(colors)),
    ),
    snackBarAnimationStyle: AnimationStyle.noAnimation,
  );
}
