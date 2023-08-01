
import 'package:flutter/material.dart';


import '../translations/translations.dart';

class FolderNameDialog extends StatelessWidget {
  final Map<String, String> locale;
  final Function onSubmit;

  FolderNameDialog({super.key, required this.locale, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onSubmitted: (value) {
                      onSubmit();
                    },
                    decoration: InputDecoration(
                        hintText: locale[TranslationsKeys.folderName]!,
                        border: const UnderlineInputBorder(),
                        filled: true,
                        //fillColor:  isDark == true ? Colors.black12 : null
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () {
                  /*TODO */
                  Navigator.pop(context);
                },
                child:  Text(locale[TranslationsKeys.done]!,
                  style: TextStyle(
                 // color: isDark ?Theme.of(context).primaryColor : Colors.black,
                 // fontFamily: "Cairo"
                    fontSize: 15
               ),
              ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        )
    );
  }
}
