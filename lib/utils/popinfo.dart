import 'package:flutter/material.dart';

import 'colors.dart';

class PopInfo {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbar(
    BuildContext context,
    text, {
    Duration? snackbarDuration,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Color? iconColor,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor),
              const SizedBox(width: 10),
            ],
            Text(text, style: TextStyle(color: textColor)),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: snackbarDuration ?? const Duration(seconds: 4),
      ),
    );
  }
}
