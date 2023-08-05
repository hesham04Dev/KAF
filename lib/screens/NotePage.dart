import 'package:flutter/material.dart';
import '../models/styles.dart';

import '../isarCURD.dart';
import '../models/MyWarningDialog.dart';
import '../translations/translations.dart';
import 'editNote.dart';

class NotePage extends StatelessWidget {
  final Map<String, String> locale;
  final String date;
  final String title;
  final String content;
  final IsarService db;
  final int id;
  final int? parentFolderId;
  final TextDirection titleDirection;
  final TextDirection contentDirection;

  const NotePage({
    super.key,
    required this.locale,
    required this.date,
    required this.title,
    required this.db,
    required this.id,
    required this.content,
    required this.parentFolderId,
    required this.contentDirection,
    required this.titleDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(date.toString()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, EditNote.routeName, arguments: {
                  //"isDark": isDark,
                  "parentFolderId": parentFolderId,
                  "title": title,
                  "content": content,
                  "id": id
                });
              },
              icon: Icon(Icons.mode_edit_outline_rounded)),
          IconButton(
              onPressed: () {
                showDialog(context: context, builder: (context) =>
                MyWarningDialog(
                  TranslationsWarningButton: locale[TranslationsKeys.delete]!,
                  onWarningPressed: () {
                    db.deleteNote(id);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  TranslationsTitle: "permenntaly delete",
                  /*TODO add this to the locales*/
                  TranslationsCancelButton: locale[TranslationsKeys.cancel]!,
                ),);
              },
              icon: Icon(
                Icons.delete_forever_rounded,
                color: Colors.red,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: Container(
          decoration: BoxDecoration(
              //color: isDark == true ? Colors.white10 : Colors.black12,
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(8),
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    textDirection: titleDirection,
                    title,
                    style: BigText(),
                  )),
              Divider(),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    textDirection: contentDirection,
                    content,
                    style: MediumText(),
                  )),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
