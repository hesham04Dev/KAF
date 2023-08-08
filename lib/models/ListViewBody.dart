import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:provider/provider.dart';

import '../collection/Folder.dart';
import '../collection/Note.dart';
import '../isarCURD.dart';
import '../models/NoteButton.dart';
import 'FolderButton.dart';

class ListViewBody extends StatelessWidget {
  final IsarService db;
  final bool isRtl;
  final Map<String, String> locale;

  final int? parentId;
  //final List<Folder> listFolders;
  //final List<Note> listNotes;

  ListViewBody({
   // required this.listFolders,
    //required this.listNotes,

    required this.parentId,
    required this.db,
    required this.isRtl,
    required this.locale,
  });
  List<Note> oldListNotes = [];
  List<Folder> oldListFolders = [];
  @override
  Widget build(BuildContext context) {
    print("building listview");
   // Provider.of<ListViewProvider>(context,listen: true);
    if(context.read<ListViewProvider>().listFolders.isEmpty){
      print("folders is empty");
   context.read<ListViewProvider>().getFoldersAndNotes(parentId);}
    //if(provider.listFolders!.isNotEmpty){
     // oldListFolders = provider.listFolders!;
    //}
   //if(context.read<ListViewProvider>().listFolders!.isNotEmpty)
    oldListFolders = context.watch<ListViewProvider>().listFolders;
  // if(context.read<ListViewProvider>().listNotes!.isNotEmpty)
    oldListNotes = context.watch<ListViewProvider>().listNotes;
    //oldListNotes = provider.listNotes!;
    //listFolders[0].id;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          ...List<Widget>.generate(
              oldListFolders.length,
              (index) => Column(
                    children: [
                      FolderButton(

                          parentFolderId: oldListFolders[index].parent,
                          id: oldListFolders[index].id,
                          db: db,
                          folderName: oldListFolders[index].name as String,
                          isRtl: isRtl,
                          locale: locale,
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
                                    oldListFolders[index].name as String,
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
              oldListNotes.length,
              (index) => Column(
                    children: [
                      NoteButton(
                          isRtl: isRtl,
                          contentDirection:
                          oldListNotes[index].isContentRtl ?? isRtl
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                          titleDirection: oldListNotes[index].isTitleRtl ?? isRtl
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          locale: locale,
                          parentFolderId:oldListNotes[index].parentFolderId,
                          db: db,
                          noteContent: oldListNotes[index].content!,
                          noteId: oldListNotes[index].id,
                          noteTitle: oldListNotes[index].title!,
                          noteTime: formatDate(oldListNotes[index].date!,
                              [yy, "/", mm, "/", dd, "   ", hh, ":", nn])),
                      Divider(color: Colors.white54),
                    ],
                  ))
        ],
      ),
    );
  }
}
