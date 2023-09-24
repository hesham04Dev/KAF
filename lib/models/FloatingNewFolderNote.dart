import 'package:flutter/material.dart';
import 'package:note_files/models/FadeRoute.dart';
import 'package:note_files/requiredData.dart';
import 'package:provider/provider.dart';

import '../collection/Folder.dart';
import '../isarCURD.dart';
import '../provider/ListViewProvider.dart';
import '../screens/EditNotePage.dart';
import 'FolderNameDialog.dart';

class FloatingNewFolderNote extends StatefulWidget {
  final IsarService db = requiredData.db;
  final bool isRtl = requiredData.isRtl;
  final Map<String, String> locale = requiredData.locale;
  final int? parentFolderId;

  FloatingNewFolderNote({super.key, required this.parentFolderId});

  @override
  State<FloatingNewFolderNote> createState() => _FloatingNewFolderNoteState();
}

class _FloatingNewFolderNoteState extends State<FloatingNewFolderNote> {
  bool actionButtonPressed = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (actionButtonPressed)
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => FolderNameDialog(
                              db: widget.db,
                              parentFolderId: null,
                              isRtl: widget.isRtl,
                              onSubmit: (text) {
                                final newFolder = Folder()
                                  ..name = text
                                  ..parent = widget.parentFolderId;
                                widget.db.saveFolder(newFolder);
                                context
                                    .read<ListViewProvider>()
                                    .addFolder(newFolder);
                              },
                              locale: widget.locale,
                            ));
                  },
                  child: const Icon(Icons.create_new_folder),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  heroTag: null,
                  mini: true,
                  onPressed: () {
                    Navigator.push(
                        context,
                        FadeRoute(
                          pageBuilder: (_, __, ___) =>
                              EditNote(parentFolderId: widget.parentFolderId),
                        ));
                  },
                  child: const Icon(Icons.note_add),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        FloatingActionButton(
            heroTag: null,
            onPressed: () {
              if (actionButtonPressed == false) {
                actionButtonPressed = true;
                setState(() {});
              } else {
                actionButtonPressed = false;
                setState(() {});
              }
            },
            child: Transform.rotate(
              origin: Offset.zero,
              angle: actionButtonPressed == false ? 0 : 3.14,
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                size: 40,
              ),
            ))
      ],
    );
  }
}
