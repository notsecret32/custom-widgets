import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The wrapper over the [TextFormField] is used to minimize repetitive code.
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.textFilter,
    this.inputType = TextInputType.text,
    this.enable = true,
    this.textMaxLength = 24,
    this.fillColor = const Color(0xFFFFFFFF),
  });

  /// Text with a hint.
  final String hintText;

  /// The controller for working with the widget.
  final TextEditingController? controller;

  /// The validation function or otherwise checking the data for correctness.
  final String? Function(String? value)? validator;

  /// Text filter for different characters.
  final TextInputFormatter? textFilter;

  /// Type of keyboard.
  final TextInputType inputType;

  /// Indicates whether this widget is active or not.
  final bool enable;

  /// Maximum number of characters.
  final int? textMaxLength;

  /// The base fill color of the decoration's container color.
  /// When [InputDecorator.isHovering] is true, the [hoverColor] is
  /// also blended into the final fill color.
  ///
  /// By default the [fillColor] is based on the
  /// current [InputDecorationTheme.fillColor].
  ///
  /// The decoration's container is the area which is filled if [filled] is
  /// true and bordered per the [border]. It's the area adjacent to [icon] and
  /// above the widgets that contain [helperText], [errorText],
  /// and [counterText].
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = Theme.of(context).textTheme.titleSmall;
    return TextFormField(
      /// ========== [Controller & Validation] ==========
      controller: controller,
      validator: validator,

      /// ========== [Text Type] ==========
      obscureText: inputType == TextInputType.visiblePassword,
      enableSuggestions: inputType != TextInputType.visiblePassword,
      autocorrect: inputType != TextInputType.visiblePassword,
      readOnly: !enable,
      keyboardType: inputType,

      /// ========== [Input Decoration] ==========
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 13.5,
          horizontal: 16,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: style!.copyWith(
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.normal,
        ),
      ),

      /// ========== [Input Formatters] ==========
      inputFormatters: <TextInputFormatter>[
        textFilter ?? FilteringTextInputFormatter.singleLineFormatter,
        LengthLimitingTextInputFormatter(textMaxLength),
      ],

      /// ========== [Text Style] ==========
      style: style.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
