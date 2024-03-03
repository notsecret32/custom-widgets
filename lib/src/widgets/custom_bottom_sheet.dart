import 'package:flutter/material.dart';

/// Wrapper over the `showModalBottomSheet` method for more convenient use.
class CustomBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required Widget child,
  }) async {
    return await showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) => child,
    );
  }
}
