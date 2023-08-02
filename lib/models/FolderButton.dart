import 'package:flutter/material.dart';

import 'EditOrDileteFolder.dart';

class FolderButton extends StatelessWidget {
  final Map<String, String> locale;
  final bool isDark;
  final Widget child;
  final isRtl;
  final db;
  final int parentFolderId;

  final int id;

  FolderButton({
    required this.parentFolderId,
    super.key,
    required this.db,
    required this.isDark,
    required this.child,
    required this.locale,
    required this.isRtl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onLongPress: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return EditOrDeleteFolder(
                  parentFolderId: parentFolderId,
                  isRtl: isRtl,
                  onDelete: () async {
                    final existingFolder = await db.Folder.get(id);
                    /*TODO delete every notes inside this folder*/

                    await db.writeTxn(() async {
                      await db.folders.delete(existingFolder.id!);
                    });
                  },
                  onSubmitNewName: (newName) async {

                    final existingFolder = await db.folders.get(id);
                    existingFolder.name = newName;

                    await db.writeTxn(() async {
                      await db.folders.put(existingFolder.id!);
                    });
                  },
                  locale: locale,
                  db: db,
                );
              });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          //TODO open the page of this folder that can contains files and folders
          // TODO open the page of the note allow to edit it and show the count of the words
        },
        child: child);
  }
}
