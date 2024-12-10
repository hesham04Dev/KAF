import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:note_files/requiredData.dart';
import 'package:note_files/screens/notePage/widgets/task.dart';
import 'package:provider/provider.dart';

import '../../collection/isarCURD.dart';
import '../../models/FadeRoute.dart';
import '../../models/MyWarningDialog.dart';
import '../../models/styles.dart';
import '../../prioityColors.dart';
import '../../provider/ListViewProvider.dart';
import '../../provider/PriorityProvider.dart';
import '../../translations/translations.dart';
import '../EditNotePage.dart';

class NotePage extends StatefulWidget {
  final String date;
  final String title;
  final String content;
  final int id;
  final int? parentFolderId;
  final TextDirection titleDirection;
  final TextDirection contentDirection;
  final int? priority;
  final bool isPriorityPageOpened;
  final scrollController = ScrollController();

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
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final Map<String, String> locale = requiredData.locale;

  final IsarService db = requiredData.db;

  float fontSize = 1;

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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  if (fontSize > 0.2) {
                    fontSize -= 0.1;
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.remove_rounded)),
            Icon(
              Icons.format_size_rounded,
              color: Colors.black,
            ),
            IconButton(
                onPressed: () {
                  fontSize += 0.1;
                  setState(() {});
                },
                icon: const Icon(Icons.add_rounded,)),
          ],
        ),
        actions: [
          Task(noteId: widget.id,),
          IconButton(
              onPressed: () {
                Clipboard.setData(
                    ClipboardData(text: widget.title + "\n" + widget.content));
              },
              icon: const Icon(Icons.copy_rounded)),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  FadeRoute(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        EditNote(
                            parentFolderId: widget.parentFolderId,
                            oldTitle: widget.title,
                            oldContent: widget.content,
                            idOfNote: widget.id,
                            priority: widget.priority,
                            isPriorityPageOpened: widget.isPriorityPageOpened),
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
                      db.deleteNote(widget.id);

                      context.read<ListViewProvider>().deleteNote(widget.id);
                      widget.isPriorityPageOpened
                          ? context
                              .read<PriorityProvider>()
                              .deleteNote(widget.id)
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
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Column(
            children: [
              Row(
                textDirection: widget.titleDirection,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        color: priorityColors[(widget.priority ?? 1) - 1],
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      textDirection: widget.titleDirection,
                      " ${locale[TranslationsKeys.priority]}: ${widget.priority} ",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.date,
                      style: TextStyle(
                          fontSize: (MediumText().fontSize! * fontSize)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  textDirection: widget.titleDirection,
                  widget.title,
                  style: TextStyle(fontSize: BigText().fontSize! * fontSize),
                ),
              ),
              //const Divider(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Scrollbar(
                  controller: widget.scrollController,
                  child:
                      ListView(controller: widget.scrollController, children: [
                    Text(
                      textDirection: widget.contentDirection,
                      widget.content,
                      style: TextStyle(
                          fontSize: (MediumText().fontSize! * fontSize)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
