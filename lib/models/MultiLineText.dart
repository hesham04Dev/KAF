import 'package:flutter/material.dart';

class MultiLineText extends StatelessWidget {
  final int margin;
  final String text;
  final int maxLines;
  final bool bold;
  const MultiLineText({super.key,required this.margin, required this.maxLines, required this.text ,this.bold = false});

  @override
  Widget build(BuildContext context) {
    return  Row(children: [ SizedBox(width: MediaQuery.sizeOf(context).width -margin,child: Text(text,overflow: TextOverflow.ellipsis,maxLines: maxLines,style: TextStyle(fontWeight: bold ?FontWeight.w600: null,fontSize:  bold ? 16 : null ),))]);
  }
}
