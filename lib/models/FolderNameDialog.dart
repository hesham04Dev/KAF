import 'package:flutter/material.dart';
import 'package:note_files/models/AutoDirectionTextField.dart';

import '../collection/isarCURD.dart';
import '../functions/isRtlTextDirection.dart';
import '../translations/translations.dart';
import 'MultiLineText.dart';

// ignore: must_be_immutable
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
    return Directionality(
      textDirection: isRtlTextDirection(isRtl),
      child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                MultiLineText(
                  margin: 120,
                  text: locale[TranslationsKeys.enterFolderName]!,
                  maxLines: 1,
                  fontSize: 20,
                  textDirection: isRtlTextDirection(isRtl),
                ),
                const SizedBox(
                  height: 7,
                ),
                /*TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: folderNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      //constraints: BoxConstraints(maxHeight: 50),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white12),
                ),*/
                /*AutoDirectionTextField(
                    controller: folderNameController,
                    locale: locale,
                    hintText: ""),*/
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AutoDirectionTextField(
                      controller: folderNameController,
                      locale: locale,
                      isUnderLinedBorder: false,
                    )),
                const SizedBox(height: 5),
                FilledButton(
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

}
