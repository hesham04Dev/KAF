import 'package:flutter/material.dart';
import 'package:note_files/requiredData.dart';
import 'package:provider/provider.dart';
import '../models/styles.dart';

import '../isarCURD.dart';
import '../models/MyWarningDialog.dart';
import '../provider/ListViewProvider.dart';
import '../provider/PriorityProvider.dart';
import '../translations/translations.dart';
import 'EditNotePage.dart';

class NotePage extends StatelessWidget {
  final Map<String, String> locale =requiredData.locale;
  final String date;
  final String title;
  final String content;
  final IsarService db =requiredData.db;
  final int id;
  final int? parentFolderId;
  final TextDirection titleDirection;
  final TextDirection contentDirection;
  final int? priority;
  final bool isPriorityPageOpened;

   NotePage({
    super.key,
    required this.priority,
    required this.date,
    required this.title,
    required this.isPriorityPageOpened,
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
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(date.toString()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, EditNote.routeName, arguments: {

                  "parentFolderId": parentFolderId,
                  "title": title,
                  "content": content,
                  "id": id,
                  "priority": priority,
                  "isPriorityPageOpened": isPriorityPageOpened
                });
              },
              icon: const Icon(Icons.mode_edit_outline_rounded)),
          IconButton(
              onPressed: () {
                showDialog(context: context, builder: (context) =>
                MyWarningDialog(
                    translationsWarningButton: locale[TranslationsKeys.delete]!,
                  onWarningPressed: () {
                    db.deleteNote(id);
                    
                    context.read<ListViewProvider>().deleteNote(id);
                    isPriorityPageOpened ?context.read<PriorityProvider>().deleteNote(id): null;
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  translationsTitle: locale[TranslationsKeys.permanentDelete]!,
                  translationsCancelButton: locale[TranslationsKeys.cancel]!,
                ),);
              },
              icon: const Icon(
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
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),

                child: Center(
                  child: Text(
                    textDirection: titleDirection,
                    " ${TranslationsKeys.priority}: $priority ",
                    style: const MediumText(),
                  ),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    textDirection: titleDirection,
                    title,
                    style: const BigText(),
                  )),
              const Divider(),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    textDirection: contentDirection,
                    content,
                    style: const MediumText(),
                  )),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
