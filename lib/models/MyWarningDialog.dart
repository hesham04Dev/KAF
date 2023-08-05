import 'package:flutter/material.dart';

import '../translations/translations.dart';
import 'styles.dart';

class MyWarningDialog extends StatelessWidget {

  final String TranslationsTitle;
  final String TranslationsWarningButton;
  final Function onWarningPressed;
  final String TranslationsCancelButton;
  const MyWarningDialog({super.key,required this.TranslationsWarningButton,required this.onWarningPressed,required this.TranslationsTitle,required this.TranslationsCancelButton});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(TranslationsTitle!,
                style: MediumText()),
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
                      TranslationsWarningButton,
                      style: TextStyle(color: Colors.red, fontSize: 19),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      TranslationsCancelButton,

                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
