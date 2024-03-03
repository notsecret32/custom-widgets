import 'package:flutter/material.dart';

/// The wrapper above the [IconButton] is used for convenient operation
/// with the [CustomAppBar].
class CustomAppBarActionButton extends StatelessWidget {
  const CustomAppBarActionButton({
    super.key,
    required this.icon,
    this.iconColor,
    this.iconWeight,
    this.onPressed,
  });

  /// The icon that will be displayed.
  final IconData icon;

  /// The icon color is white by default. The color depends on the theme.
  final Color? iconColor;

  /// Displays how big the icon will be.
  final double? iconWeight;

  /// A callback function that is called by clicking on the icon.
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        weight: iconWeight,
        color: onPressed == null
            ? colors.inversePrimary
            : iconColor ?? colors.onSecondary,
      ),
    );
  }
}
