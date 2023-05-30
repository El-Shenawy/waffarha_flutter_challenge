import 'package:flutter/material.dart';
import 'package:waffarha_flutter_challenge/utils/font_manager.dart';

/// A custom text widget that can be used throughout the app.
class CustomText extends StatelessWidget {
  /// The text to display.
  final String? text;

  /// The font size of the text.
  final double fontSize;

  /// The color of the text.
  final Color? textColor;

  /// The font family of the text.
  final String? fontFamily;

  /// Whether the text should be centered.
  final bool isCentered;

  /// The maximum number of lines to display.
  final int maxLines;

  /// The spacing between letters in the text.
  final double letterSpacing;

  /// Whether the text should be displayed in all caps.
  final bool textAllCaps;

  /// Whether the text is long.
  final bool isLongText;

  /// Whether to display a line through the text.
  final bool lineThrough;

  /// Whether the text should be bold.
  final bool isBold;

  /// The spacing between words in the text.
  final double? wordSpacing;

  const CustomText({
    this.text,
    this.fontSize = FontSize.s16,
    this.textColor,
    this.fontFamily,
    this.isCentered = false,
    this.maxLines = 3,
    this.letterSpacing = 0.5,
    this.textAllCaps = false,
    this.isLongText = false,
    this.lineThrough = false,
    this.isBold = false,
    this.wordSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAllCaps ? text!.toUpperCase() : text!,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLines,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        wordSpacing: wordSpacing,
        fontFamily: fontFamily,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize,
        color: textColor,
        height: 1.5,
        letterSpacing: letterSpacing,
        decoration: lineThrough ? TextDecoration.lineThrough : null,
      ),
    );
  }
}
