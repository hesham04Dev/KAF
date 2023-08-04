import 'package:flutter/material.dart';

class FolderOrNoteButton extends StatelessWidget {
  final Function onLongPressed;
  final Function onPressed;
  final Widget child;
  final bool isGridView;
  final Icon? icon;

  const FolderOrNoteButton(
      {super.key,
      required this.onLongPressed,
      required this.onPressed,
      required this.child,
       this.icon,
      required this.isGridView});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onLongPress: () {
        onLongPressed();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {
        onPressed();
      },
      child: isGridView
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon ?? SizedBox(),
                const SizedBox(
                  height: 5,
                ),
                FittedBox(child: child)
              ],
            )
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                children: [
                  icon ?? SizedBox(),
                   SizedBox(
                    width: icon == null ? null :10,
                  ),
                  FittedBox(
                      child:  child),
                ],
              ),
          ),
    );
  }
}
