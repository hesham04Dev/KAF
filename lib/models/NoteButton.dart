import 'package:flutter/material.dart';
import 'package:note_files/requiredData.dart';

import '../collection/isarCURD.dart';
import '../models/FolderOrNoteButton.dart';
import '../prioityColors.dart';
import '../screens/NotePage.dart';
import 'FadeRoute.dart';
import 'MultiLineText.dart';

class NoteButton extends StatelessWidget {
  final bool isRtl = requiredData.isRtl;
  final Map<String, String> locale = requiredData.locale;

  final String noteTitle;
  final String noteTime;
  final String noteContent;
  final int noteId;
  final IsarService db = requiredData.db;
  final TextDirection titleDirection;
  final TextDirection contentDirection;
  final int? parentFolderId;
  final int? priority;
  final bool? isPriorityPageOpened;
  NoteButton({
    super.key,
    required this.priority,
    this.isPriorityPageOpened,
    required this.noteTitle,
    required this.noteTime,
    required this.noteContent,
    required this.noteId,
    this.parentFolderId,
    required this.titleDirection,
    required this.contentDirection,
  });

  @override
  Widget build(BuildContext context) {
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
                  ? SizedBox()
                  : MultiLineText(
                      margin: 92,
                      maxLines: 1,
                      text: noteTitle,
                      bold: true,
                      textDirection: titleDirection,
                      fontSize: 16),
              /*SizedBox(
                height: noteTitle.isEmpty ? 0 : 0,
              ),*/
              noteContent.isEmpty
                  ? SizedBox()
                  : MultiLineText(
                      margin: 92,
                      maxLines: 1,
                      text: noteContent,
                      textDirection: contentDirection,
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
                                color: priorityColors[priority! - 1],
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
