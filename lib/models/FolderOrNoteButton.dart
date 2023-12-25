import 'package:flutter/material.dart';

import '../functions/isRtlTextDirection.dart';
import '../requiredData.dart';

class FolderOrNoteButton extends StatelessWidget {
  final bool isRtl = requiredData.isRtl;
  final Function onLongPressed;
  final Function onPressed;
  final Widget child;
  final Widget? icon;

  FolderOrNoteButton({
    super.key,
    required this.onLongPressed,
    required this.onPressed,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: MaterialButton(
        color: Colors.black12,
        elevation: 0,
        hoverElevation: 0,
        onLongPress: () {
          onLongPressed();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          onPressed();
        },
        child: SizedBox(
          height: 83,
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0, bottom: 1),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: isRtlTextDirection(isRtl),
              children: [
                icon ?? const SizedBox(),
                SizedBox(
                  width: icon == null ? null : 20,
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
