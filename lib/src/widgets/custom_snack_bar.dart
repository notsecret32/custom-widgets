import 'package:flutter/material.dart';

class CustomSnackBarViewer {
  static void showSnackBar({
    required BuildContext context,
    required String text,
    bool error = false,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextStyle? style = Theme.of(context).textTheme.bodyMedium;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: error ? colorScheme.error : colorScheme.primary,
        content: Text(
          text,
          style: style!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
