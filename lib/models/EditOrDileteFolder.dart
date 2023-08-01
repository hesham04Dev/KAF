import 'package:flutter/material.dart';

import '../translations/translations.dart';
import 'FolderNameDialog.dart';
import 'styles.dart';

class EditOrDeleteFolder extends StatelessWidget {
  final Map<String, String> locale;
  final Function onSubmitNewName;
  final Function onDelete;

  EditOrDeleteFolder(
      {super.key,
      required this.locale,
      required this.onSubmitNewName,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) => FolderNameDialog(
                          locale: locale,
                          onSubmit: () {
                            onSubmitNewName();
                          },
                        ));
              },
              child:  SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    locale[TranslationsKeys.edit]!,
                    style: MediumText(),
                  )))),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                onDelete();
                Navigator.pop(context);
              },
              child:  SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      locale[TranslationsKeys.delete]!,
                      style: TextStyle(color: Colors.red, fontSize: 19),
                    ),
                  ))),
        ),
      ],
    );
  }
}
