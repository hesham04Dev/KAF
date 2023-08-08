import 'package:flutter/material.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:provider/provider.dart';
import '../models/FolderOrNoteButton.dart';
import '../models/MultiLineText.dart';
import '../screens/FolderPage.dart';

import '../isarCURD.dart';
import 'EditOrDileteFolder.dart';

class FolderButton extends StatelessWidget {
  final Map<String, String> locale;
  final Widget child;
  final bool isRtl;
  final IsarService db;
  final int? parentFolderId;
  final int id;
  //final Function onDone;
  //final ListViewProvider provider;
  final String folderName;

  FolderButton(
      {//required this.provider,
      required this.parentFolderId,
      super.key,
      required this.db,
      required this.child,
      required this.locale,
      required this.isRtl,
      required this.id,
      required this.folderName});

  @override
  Widget build(BuildContext context) {

    return FolderOrNoteButton(
      isRtl: isRtl,
      child: MultiLineText(margin: 138,
      text:folderName,maxLines: 1,bold: true,fontSize: 18,textDirection: isRtl? TextDirection.rtl : TextDirection.ltr, ),
      icon: Icon(

        Icons.folder_rounded,

        size: 50,
      ),
      onLongPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return EditOrDeleteFolder(
                parentFolderId: parentFolderId,
                isRtl: isRtl,
                onDelete: () async {
                  final existingFolder = await db.getFolder(id);
                  await db.deleteFolder(existingFolder!.id);
                 await context.read<ListViewProvider>().deleteFolder(existingFolder);
                },
                onSubmitNewName: (newName) async {
                  
                  final existingFolder = await db.getFolder(id);
                  existingFolder!.name = newName;
                  await db.updateFolder(existingFolder);
                  await context.read<ListViewProvider>().updateFolders(id);

                },
                locale: locale,
                db: db,
              );
            });
      },
      onPressed: () {
        print("pushing parent is $id");
        context.read<ListViewProvider>().getFoldersAndNotes(id);
        Navigator.pushNamed(
            context,
            FolderPage.routeName,
            arguments: {
              "parentFolderId": id,
              "folderName": folderName,
            });
            /*MaterialPageRoute(
              builder: (context) =>
                  FolderPage(locale: locale, isRtl: isRtl, db: db,parentFolderId: id,folderName: folderName,),
            ));*/

      },
    );
  }
}
