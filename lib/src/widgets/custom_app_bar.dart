import 'package:custom_widgets/src/widgets/custom_app_bar_action_button.dart';
import 'package:flutter/material.dart';

/// Wrapper over the [AppBar] widget, used to minimize repetitive code.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.leadingIconColor,
    this.onLeadingIconPressed,
    this.leadingIconWeight,
    this.actions,
    this.automaticallyImplyLeading = false,
  });

  /// AppBar title.
  final String title;

  /// Optional icon in front of the title.
  final IconData? leadingIcon;

  /// The color of the icon, by default it is `white`.
  final Color? leadingIconColor;

  /// Callback function, triggered by clicking on the icon.
  final Function()? onLeadingIconPressed;

  /// The stroke weight for drawing the icon.
  final double? leadingIconWeight;

  /// A list of buttons that will be displayed after the title.
  final List<CustomAppBarActionButton>? actions;

  /// Controls whether we should try to imply the leading widget if null.
  ///
  /// If true and [leading] is null, automatically try to deduce
  /// what the leading widget should be. If false and [leading] is null,
  /// leading space is given to [title]. If leading widget is not null,
  /// this parameter has no effect.
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: _createLeadingIcon(
        leadingIconColor ?? colors.onSecondary,
        colors.inversePrimary,
      ),
      actions: actions,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
    );
  }

  /// A method that creates a button with an icon, or returns null.
  Widget? _createLeadingIcon(Color activeColor, Color inactiveColor) {
    if (leadingIcon != null) {
      return IconButton(
        icon: Icon(
          leadingIcon,
          color: onLeadingIconPressed == null ? inactiveColor : activeColor,
          weight: leadingIconWeight,
        ),
        onPressed: onLeadingIconPressed,
      );
    }

    return null;
  }
}
