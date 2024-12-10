import 'package:flutter/material.dart';

import 'styles.dart';

class MyWarningDialog extends StatelessWidget {
  final String translationsTitle;
  final String translationsWarningButton;
  final Function onWarningPressed;
  final Function? onCancelPressed;
  final String translationsCancelButton;
  const MyWarningDialog(
      {super.key,
      required this.translationsWarningButton,
      required this.onWarningPressed,
      required this.translationsTitle,
      required this.translationsCancelButton,
      this.onCancelPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(translationsTitle, style: const MediumText()),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        onWarningPressed();
                      },
                      child: Text(
                        translationsWarningButton,
                        style: const TextStyle(color: Colors.red, fontSize: 19),
                      )),
                  TextButton(
                      onPressed: () {
                        if (onCancelPressed != null) {
                          onCancelPressed!();
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        translationsCancelButton,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
