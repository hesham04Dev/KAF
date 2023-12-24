import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_files/models/FadeRoute.dart';
import 'package:note_files/requiredData.dart';
import 'package:provider/provider.dart';

import '../collection/isarCURD.dart';
import '../models/MyWarningDialog.dart';
import '../models/styles.dart';
import '../prioityColors.dart';
import '../provider/ListViewProvider.dart';
import '../provider/PriorityProvider.dart';
import '../translations/translations.dart';
import 'EditNotePage.dart';

class NotePage extends StatelessWidget {
  final Map<String, String> locale = requiredData.locale;
  final String date;
  final String title;
  final String content;
  final IsarService db = requiredData.db;
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          locale[TranslationsKeys.title]!,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  FadeRoute(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        EditNote(
                            parentFolderId: parentFolderId,
                            oldTitle: title,
                            oldContent: content,
                            idOfNote: id,
                            priority: priority,
                            isPriorityPageOpened: isPriorityPageOpened),
                  ),
                );
              },
              icon: const Icon(Icons.mode_edit_outline_rounded)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => MyWarningDialog(
                    translationsWarningButton: locale[TranslationsKeys.delete]!,
                    onWarningPressed: () {
                      db.deleteNote(id);

                      context.read<ListViewProvider>().deleteNote(id);
                      isPriorityPageOpened
                          ? context.read<PriorityProvider>().deleteNote(id)
                          : null;
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    translationsTitle:
                        locale[TranslationsKeys.permanentDelete]!,
                    translationsCancelButton: locale[TranslationsKeys.cancel]!,
                  ),
                );
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
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: [
              Row(
                textDirection: titleDirection,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: priorityColors[priority ?? 1 - 1],
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      textDirection: titleDirection,
                      " ${locale[TranslationsKeys.priority]}: $priority ",
                      style: const MediumText(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      formatDate(DateTime.now(), [
                        yyyy,
                        "-",
                        mm,
                        "-",
                        dd,
                        "   ",
                        hh,
                        ":",
                        nn
                      ]).toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textDirection: titleDirection,
                title,
                style: const BigText(),
              ),
              //const Divider(),
              const SizedBox(
                height: 10,
              ),
              Text(
                textDirection: contentDirection,
                content,
                style: const MediumText(),
              ),
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
