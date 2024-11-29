import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_files/homePageData.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:provider/provider.dart';

import '../collection/Folder.dart';
import '../collection/Note.dart';
import '../collection/isarCURD.dart';
import '../models/FolderButton.dart';
import '../models/NoteButton.dart';
import '../requiredData.dart';
import '../translations/translations.dart';

class ListViewBody extends StatelessWidget {
  final IsarService db = requiredData.db;
  final bool isRtl = requiredData.isRtl;
  final Map<String, String> locale = requiredData.locale;

  final int? parentId;
  ListViewBody({
    super.key,
    required this.parentId,
  });

  @override
  Widget build(BuildContext context) {
    List<Note> oldListNotes = homePageNotes;
    List<Folder> oldListFolders = homePageFolders;
    //print("building listview");
    oldListFolders = context.watch<ListViewProvider>().listFolders;
    oldListNotes = context.watch<ListViewProvider>().listNotes;
    if (oldListFolders.isEmpty && oldListNotes.isEmpty) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(locale[TranslationsKeys.noNotes]!),
      ));
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            ...List<Widget>.generate(oldListFolders.length, (i) {
              var index = oldListFolders.length - i -1;
              // int reverseIndex({required int listLength, required int index}) {
              //   return listLength - index - 1;
              // }

              return FolderButton(
                  parentFolderId: oldListFolders[index].parent,
                  id: oldListFolders[index].id,
                  folderName: oldListFolders[index].name as String,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.folder_rounded,
                          size: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FittedBox(
                          child: Text(
                            oldListFolders[index].name as String,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ));
            }),
            ...List<Widget>.generate(
              oldListNotes.length,
              (i) {
                var index = oldListNotes.length - 1 - i;
                return NoteButton(
                    priority: oldListNotes[index].priority,
                    contentDirection: oldListNotes[index].isContentRtl ?? isRtl
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    titleDirection: oldListNotes[index].isTitleRtl ?? isRtl
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    parentFolderId: oldListNotes[index].parentFolderId,
                    noteContent: oldListNotes[index].content!,
                    noteId: oldListNotes[index].id,
                    noteTitle: oldListNotes[index].title!,
                    noteTime: formatDate(oldListNotes[index].date!,
                        [yy, "/", mm, "/", dd, "   ", hh, ":", nn]));
              },
            )
          ],
        ),
      );
    }
  }
}
