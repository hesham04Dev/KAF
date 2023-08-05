import 'package:flutter/material.dart';
import '../models/FolderOrNoteButton.dart';
import '../models/MultiLineText.dart';
import '../screens/MyHomePage.dart';

import '../isarCURD.dart';
import 'EditOrDileteFolder.dart';

class FolderButton extends StatelessWidget {
  final Map<String, String> locale;
  //final bool isDark;
  final Widget child;
  final bool isRtl;
  final IsarService db;
  final int? parentFolderId;
  final bool isGridView;
  final int id;
  final Function onDelete;

  final String folderName;

  FolderButton(
      {required this.onDelete,
      required this.parentFolderId,
      super.key,
      required this.db,
      //required this.isDark,
      required this.child,
      required this.locale,
      required this.isRtl,
      required this.id,
      required this.isGridView,
      required this.folderName});

  @override
  Widget build(BuildContext context) {
    return FolderOrNoteButton(
      isRtl: isRtl,
      child: /*Text(folderName, style: TextStyle(fontSize: 20)),*/
      MultiLineText(margin: 132,
      text:folderName,maxLines: 1,bold: true,fontSize: 18,textDirection: isRtl? TextDirection.rtl : TextDirection.ltr, ),
      icon: Icon(
        Icons.folder_rounded,
        size: 50,
      ),
      isGridView: isGridView,
      onLongPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return EditOrDeleteFolder(
                parentFolderId: parentFolderId,
                isRtl: isRtl,
                onDelete: () async {
                  final existingFolder = await db.getFolder(id);
                  db.deleteFolder(existingFolder!.id);
                },
                onSubmitNewName: (newName) async {
                  final existingFolder = await db.getFolder(id);
                  existingFolder!.name = newName;
                  db.updateFolder(existingFolder);
                },
                locale: locale,
                db: db,
              );
            });
      },
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MyHomePage(locale: locale, isRtl: isRtl, db: db,parentFolderId: id,folderName: folderName),
            ));
      },
    );
  }
}
