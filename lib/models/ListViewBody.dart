import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_filest1/models/NoteButton.dart';

import '../collection/Folder.dart';
import '../collection/Note.dart';
import '../isarCURD.dart';
import 'FolderButton.dart';

class ListViewBody extends StatefulWidget {
  final IsarService db;
  final bool isRtl;
  final Map<String, String> locale;
  //final bool isDark;
  final bool isGridView;
  final List<Folder> listFolders;
  final List<Note> listNotes;

   ListViewBody(
      {super.key,
      required this.db,
      required this.isRtl,
      //required this.isDark,
      required this.locale,
      required this.isGridView,
      required this.listFolders,
      required this.listNotes});

  @override
  State<ListViewBody> createState() => _ListViewBodyState();
}

class _ListViewBodyState extends State<ListViewBody> {
  /*final List<Folder> listFolders = await db.getAllHomePageFolders();
  final List<Note> listNotes = await db.getAllHomePageNotes();*/
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          ...List<Widget>.generate(
              widget.listFolders.length,
              (index) => Column(
                    children: [
                      FolderButton(
                        onDelete: (){
                          setState(() {

                          });
                        },
                          parentFolderId: widget.listFolders[index].parent,
                          id: widget.listFolders[index].id,
                          db: widget.db,
                          isGridView: widget.isGridView,
                          folderName: widget.listFolders[index]!.name as String,
                          isRtl: widget.isRtl,
                          locale: widget.locale,
                          //isDark: widget.isDark,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.folder_rounded,
                                  size: 50,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                FittedBox(
                                  child: Text(
                                    widget.listFolders[index]!.name as String,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Divider(color: Colors.white54),
                    ],
                  )),
          ...List<Widget>.generate(
              widget.listNotes.length,
              (index) => Column(
                    children: [
                      NoteButton(

                          parentFolderId: widget.listNotes[index]!.parentFolderId,
                          db: widget.db,
                          isGridView: widget.isGridView,
                          noteContent: widget.listNotes[index]!.content!,
                          noteId: widget.listNotes[index]!.id,
                          noteTitle: widget.listNotes[index]!.title!,
                          noteTime: formatDate(widget.listNotes[index]!.date!,
                              [yy, "/", mm, "/", dd, "   ", hh, ":", nn])),
                      Divider(color: Colors.white54),
                    ],
                  ))
        ],
      ),
    );
  }
}
