
import 'package:flutter/material.dart';


import '../collection/Folder.dart';
import '../translations/translations.dart';

class FolderNameDialog extends StatelessWidget {
  final Map<String, String> locale;
  final Function onSubmit;
  final isRtl;
  final db;
  final int parentFolderId;

  FolderNameDialog({super.key, required this.locale, required this.onSubmit,required this.isRtl,required this.db,required this.parentFolderId });

  @override
  Widget build(BuildContext context) {
    var folderNameController =TextEditingController();
    return Directionality(
      textDirection:isRtl? TextDirection.rtl : TextDirection.ltr,
      child: Dialog(
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
                      controller: folderNameController,
                      keyboardType: TextInputType.text,
                      onSubmitted: (value) {

                      },
                      decoration: InputDecoration(
                          hintText: locale[TranslationsKeys.folderName]!,
                          border: const UnderlineInputBorder(),
                          filled: true,

                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () async {
                    /*TODO */
                    final newFolder = Folder()..name = folderNameController.text
                      ..parent = parentFolderId;
                    await db.writeTxn(() async {
                      await db.Folder.put(newFolder);
                      /*TODO move the above code to the home page in opening the add new folder*/
                      onSubmit(folderNameController.text);
                    });
                    Navigator.pop(context);
                  },
                  child:  Text(locale[TranslationsKeys.done]!,
                    style: TextStyle(
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
      ),
    );
  }
}
