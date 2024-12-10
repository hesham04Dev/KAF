import 'package:flutter/material.dart';

class MultiLineText extends StatelessWidget {
  final int margin;
  final String text;
  final int? maxLines;
  final bool bold;
  final double? fontSize;
  final TextStyle? style;
  final TextDirection textDirection;

  const MultiLineText(
      {super.key,
      required this.margin,
      this.maxLines = 1,
      required this.text,
      this.bold = false,
      this.style,
      this.fontSize,
      this.textDirection = TextDirection.ltr});

  @override
  Widget build(BuildContext context) {
    bool unlimited = maxLines == 0 ? true : false;
    var textStyle  = style??TextStyle();
    return Row(children: [
      SizedBox(
          width: MediaQuery.sizeOf(context).width - margin,
          child: Text(
            text,
            textDirection: textDirection,
            overflow: TextOverflow.ellipsis,
            maxLines: unlimited ? null : maxLines,
            style: textStyle.copyWith(
                fontWeight: bold ? FontWeight.w600 : null, fontSize: fontSize, )
          ))
    ]);
  }
}
