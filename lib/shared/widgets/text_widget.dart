import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final String fontFamily;
  final Color color;
  final double fontSize;
  final double minFontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxline;
  final TextDecoration textDecoration;
  final TextOverflow overflow;
  final double height;
  const TextWidget({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.textAlign,
    this.maxline,
    this.overflow = TextOverflow.clip,
    this.textDecoration = TextDecoration.none,
    this.minFontSize = 10,
    this.fontFamily = 'Tajawal',
    this.height = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      minFontSize: minFontSize,
      text,
      style: TextStyle(
        height: height,
        overflow: overflow,
        decoration: textDecoration,
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxline,
    );
  }
}
