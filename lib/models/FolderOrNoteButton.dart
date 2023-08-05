import 'package:flutter/material.dart';

class FolderOrNoteButton extends StatelessWidget {
  final bool isRtl;
  final Function onLongPressed;
  final Function onPressed;
  final Widget child;
  final Icon? icon;
  final bool withBackground;

  const FolderOrNoteButton(
      {super.key,
      required this.isRtl,
      required this.onLongPressed,
      required this.onPressed,
      required this.child,
      this.icon,
      this.withBackground = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: withBackground ? Theme.of(context).primaryColor.withOpacity(0.1) :null,
      elevation: 0,
      hoverElevation: 0,
      onLongPress: () {
        onLongPressed();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      onPressed: () {
        onPressed();
      },
      child:  Row(
            textDirection:isRtl ? TextDirection.rtl : TextDirection.ltr,
              children: [
                icon ?? SizedBox(),
                 SizedBox(
                  width: icon == null ? null :10,
                ),
                child,
              ],
            ),
    );
  }
}
