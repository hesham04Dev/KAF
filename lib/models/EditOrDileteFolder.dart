import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'FolderNameDialog.dart';
import 'styles.dart';
import '../translations/locale_keys.g.dart';

class EditOrDeleteFolder extends StatelessWidget {
  final bool isDark;
  final Function onSubmitNewName;
  final Function onDelete;

  EditOrDeleteFolder(
      {super.key,
      required this.isDark,
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
                          isDark: isDark,
                          onSubmit: () {
                            onSubmitNewName();
                          },
                        ));
              },
              child:  SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    LocaleKeys.edit.tr(),
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
                      LocaleKeys.delete.tr(),
                      style: TextStyle(color: Colors.red, fontSize: 19),
                    ),
                  ))),
        ),
      ],
    );
  }
}
