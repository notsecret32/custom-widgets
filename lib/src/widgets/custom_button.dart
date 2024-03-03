import 'package:custom_widgets/src/core/theme/colors.dart';
import 'package:flutter/material.dart';

/// Wrapper above the [TextButton] with added styling
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.backgroundColor = primaryColor,
    this.enable = true,
  });

  /// Required button text.
  final String text;

  /// Callback function, triggered by pressing a button.
  final void Function()? onPressed;

  /// Text color.
  final Color? textColor;

  /// The background of the button.
  ///
  /// If the color is not specified, `theme.colorScheme.primary`
  /// is used by default.
  final Color? backgroundColor;

  /// Indicates whether this widget is active or not.
  final bool enable;

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = Theme.of(context).textTheme.titleSmall;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: TextButton(
        onPressed: enable ? onPressed : null,
        child: Text(
          text,
          style: style!.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
