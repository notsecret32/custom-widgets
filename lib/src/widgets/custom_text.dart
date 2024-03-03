import 'package:flutter/material.dart';

/// Text widget with the ability to change the style.
class CustomText {
  /// Displays text with the [activeStyle] style if [active] is `true`,
  /// otherwise the [inactiveStyle] style is displayed.
  static Widget toggle(
    String text, {
    bool active = false,
    TextStyle? activeStyle,
    TextStyle? inactiveStyle,
  }) {
    return Text(
      text,
      style: active ? activeStyle : inactiveStyle,
    );
  }
}
