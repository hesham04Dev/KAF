import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../collection/Folder.dart';
import '../collection/Note.dart';
import 'FolderButton.dart';
import 'NoteButton.dart';

class GridViewBody extends StatefulWidget {
  final db;
  final isRtl;
  final locale;
  //final isDark;
  final bool isGridView;

  const GridViewBody(
      {super.key,
      required this.db,
      required this.isRtl,
      //required this.isDark,
      required this.locale,
      required this.isGridView});

  @override
  State<GridViewBody> createState() => _GridViewBodyState();
}

class _GridViewBodyState extends State<GridViewBody> {
  @override
  Widget build(BuildContext context) {
    List<Folder> listFolders = widget.db.getAllHomePageFolders().then((value) {
      return value;
    });
    List<Note> listNotes = widget.db.getAllHomePageNotes().then((value) {
      return value;
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            childAspectRatio: 1.2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          ...List<Widget>.generate(
              listFolders.length,
              (index) => Column(
                    children: [
                      FolderButton(
                          onDelete: (){
                            setState(() {

                            });
                          },
                          parentFolderId: listFolders[index].parent,
                          id: listFolders[index].id,
                          db: widget.db,
                          isGridView: widget.isGridView,
                          folderName: listFolders[index]!.name as String,
                          isRtl: widget.isRtl,
                          locale: widget.locale,
                         // isDark: widget.isDark,
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
                                    listFolders[index]!.name as String,
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
              listNotes.length,
              (index) => Column(
                    children: [
                      NoteButton(
                          locale:  widget.locale,
                          isRtl: widget.isRtl,
                          noteContent: listNotes[index]!.content!,
                          noteId: listNotes[index]!.id,
                          db: widget.db,
                          isGridView: widget.isGridView,
                          noteTitle: listNotes[index]!.title!,
                          noteTime: formatDate(listNotes[index]!.date!,
                              [yy, "/", mm, "/", dd, "   ", hh, ":", nn])),
                      Divider(color: Colors.white54),
                    ],
                  ))
        ],
      ),
    );
  }
}
