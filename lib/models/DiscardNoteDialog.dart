
import 'package:flutter/material.dart';


import '../translations/translations.dart';
import 'styles.dart';

class DiscardNoteDialog extends StatelessWidget {

  final Map<String, String> locale;
  const DiscardNoteDialog({super.key , required this.locale});

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
           Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(locale[TranslationsKeys.discardYourNote]!, style: MediumText()),
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
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child:  Text(
                      locale[TranslationsKeys.discard]!,
                      style: TextStyle(
                          color: Colors.red, fontSize: 19),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child:  Text(
                      locale[TranslationsKeys.cancel]!,
                      style: TextStyle(

                      ),
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
