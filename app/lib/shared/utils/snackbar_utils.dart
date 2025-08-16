import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Utility class for showing snackbars with FAlert components
class SnackbarUtils {
  /// Shows a snackbar with FAlert content
  static void showFAlertSnackbar(
    BuildContext context, {
    required String text,
    FBaseAlertStyle Function(FAlertStyle)? alertStyle,
    Color backgroundColor = Colors.transparent,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    double elevation = 0,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        elevation: elevation,
        content: FAlert(
          title: Text(text),
          style: alertStyle ?? FAlertStyle.primary(),
        ),
        behavior: behavior,
      ),
    );
  }
}
