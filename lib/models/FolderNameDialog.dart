import 'package:flutter/material.dart';

import '../functions/boolFn.dart';
import '../functions/isRtlTextDirection.dart';
import '../isarCURD.dart';
import '../translations/translations.dart';

class FolderNameDialog extends StatelessWidget {
  final Map<String, String> locale;
  final Function onSubmit;
  final bool isRtl;
  final IsarService db;
  final int? parentFolderId;

  FolderNameDialog({
    super.key,
    required this.locale,
    required this.onSubmit,
    required this.isRtl,
    required this.db,
    required this.parentFolderId,
  });


  var folderNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkMode(context);


    return Directionality(
      textDirection: isRtlTextDirection(isRtl),
      child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                      controller: folderNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: locale[TranslationsKeys.folderName]!,
                          border: UnderlineInputBorder(),
                          filled: true,
                          fillColor: isDark
                              ? Colors.white12
                              : Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.15)),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () async {
                    if (folderNameController.text.isNotEmpty) {
                      onSubmit(folderNameController.text);
                      Navigator.pop(context);
                    } else {
                      onSubmit(locale[TranslationsKeys.newFolder]!);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    locale[TranslationsKeys.done]!,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
    );
  }

  @override
  void dispose(){
    folderNameController.dispose;
  }
}
