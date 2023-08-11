import 'package:flutter/material.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:note_files/requiredData.dart';
import 'package:provider/provider.dart';
import '../collection/Folder.dart';
import '../functions/isRtlTextDirection.dart';
import '../models/FolderOrNoteButton.dart';
import '../models/MultiLineText.dart';
import '../screens/FolderPage.dart';
import '../isarCURD.dart';
import 'EditOrDeleteFolder.dart';

class FolderButton extends StatelessWidget {
 final Map<String, String> locale = requiredData.locale;
  final Widget child;
  final bool isRtl = requiredData.isRtl;
  final IsarService db = requiredData.db;
  final int? parentFolderId;
  final int id;
  final String folderName;

  FolderButton(
      {
      required this.parentFolderId,
      super.key,
      required this.child,
      required this.id,
      required this.folderName});

  @override
  Widget build(BuildContext context) {

    return FolderOrNoteButton(

      child: MultiLineText(margin: 148,
      text:folderName,maxLines: 1,bold: true,fontSize: 18,textDirection: isRtlTextDirection(isRtl), ),
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
                  final Folder? existingFolder = await db.getFolder(id);
                  existingFolder ?? print("we dont get the folder");
                  print("the folder id $id");
                  print("we get the folder");

                  await context.read<ListViewProvider>().deleteFolder(existingFolder!);
                  print(context.read<ListViewProvider>().listFolders.length);
                  await db.deleteFolder(existingFolder.id);
                  print("we delete the folder");

                 print("we apdate the screenshot");
                },
                onSubmitNewName: (newName) async {

                  final existingFolder = await db.getFolder(id);
                  existingFolder!.name = newName;
                  await db.updateFolder(existingFolder);

                  await context.read<ListViewProvider>().updateFolders(existingFolder);

                },
                locale: locale,
                db: db,
              );
            });
      },
      onPressed: () async{
        print("pushing parent is $id");
        await context.read<ListViewProvider>().getFoldersAndNotes(id);
        Navigator.pushNamed(
            context,
            FolderPage.routeName,
            arguments: {
              "folderId": id,
              "parentFolderId": parentFolderId,
              "folderName": folderName,
            });


      },
    );
  }
}
