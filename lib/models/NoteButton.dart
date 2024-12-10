import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_files/collection/Note.dart';
import 'package:note_files/functions/boolFn.dart';
import 'package:note_files/requiredData.dart';

import '../models/FolderOrNoteButton.dart';
import '../priorityColors.dart';
import '../screens/notePage/NotePage.dart';
import 'FadeRoute.dart';
import 'MultiLineText.dart';

class NoteButton extends StatelessWidget {
  final bool isRtl = requiredData.isRtl;
  final Map<String, String> locale = requiredData.locale;

  final Note note;
  final bool? isPriorityPageOpened;
  NoteButton(
      {super.key,
      // required this.priority,
      this.isPriorityPageOpened,
      // required this.noteTitle,
      // required this.noteTime,
      // required this.noteContent,
      // required this.noteId,
      // this.parentFolderId,
      // required this.titleDirection,
      // required this.contentDirection,
      required this.note});

  @override
  Widget build(BuildContext context) {
    final String noteTitle = note.title ?? "";
    final String noteTime = formatDate(note.date!, [yy, "/", mm, "/", dd, "   ", hh, ":", nn]);
    final String noteContent = note.content??"";
    final int noteId = note.id;
    // final IsarService db = requiredData.db;
    final TextDirection titleDirection = note.isTitleRtl??false ? TextDirection.rtl :TextDirection.ltr;
    final TextDirection contentDirection = note.isContentRtl??false ? TextDirection.rtl :TextDirection.ltr;
    final int? parentFolderId = note.parentFolderId;
    final int? priority = note.priority;
   final textStyle =TextStyle(decoration: TextDecoration.lineThrough,decorationThickness: 5,decorationColor: isDarkMode(context)? Colors.black: Colors.white) ;

    return FolderOrNoteButton(
        onLongPressed: () {},
        onPressed: () {
          Navigator.push(
              context,
              FadeRoute(
                pageBuilder: (_, __, ___) => NotePage(
                  isPriorityPageOpened: isPriorityPageOpened ?? false,
                  titleDirection: titleDirection,
                  contentDirection: contentDirection,
                  priority: priority,
                  date: noteTime,
                  title: noteTitle,
                  content: noteContent,
                  id: noteId,
                  parentFolderId: parentFolderId,
                ),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              noteTitle.isEmpty
                  ? SizedBox(
                      height: 16,
                    )
                  : MultiLineText(
                      margin: 92,
                      maxLines: 1,
                      text: noteTitle,
                      bold: true,
                      textDirection: titleDirection,
                      style: note.isDone??false ? textStyle :null,
                      fontSize: 16),
              /*SizedBox(
                height: noteTitle.isEmpty ? 0 : 0,
              ),*/
              noteContent.isEmpty
                  ? SizedBox(
                      height: 14,
                    )
                  : MultiLineText(
                      margin: 92,
                      maxLines: 1,
                      text: noteContent,
                      textDirection: contentDirection,
                      style: note.isDone??false ? textStyle:null,
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(noteTime, overflow: TextOverflow.ellipsis),
                    priority == null
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            margin: const EdgeInsetsDirectional.fromSTEB(
                                10, 0, 0, 0),
                            decoration: BoxDecoration(
                                color: priorityColors[priority - 1],
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              "$priority",
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
