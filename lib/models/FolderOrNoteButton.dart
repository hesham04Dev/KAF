import 'package:flutter/material.dart';
import 'package:note_files/requiredData.dart';

import '../functions/isRtlTextDirection.dart';

class FolderOrNoteButton extends StatelessWidget {
  final bool isRtl = requiredData.isRtl;
  final Function onLongPressed;
  final Function onPressed;
  final Widget child;
  final Icon? icon;
  final bool withBackground;

   FolderOrNoteButton(
      {super.key,

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
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
              textDirection:isRtlTextDirection(isRtl),
                children: [
                  icon ?? SizedBox(),
                   SizedBox(
                    width: icon == null ? null :10,
                  ),
                  child,
                ],
              ),
      ),
    );
  }
}
