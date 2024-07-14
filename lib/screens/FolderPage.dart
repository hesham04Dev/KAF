import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_files/models/FloatingNewFolderNote.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:note_files/requiredData.dart';
import 'package:note_files/screens/PriorityPage.dart';
import 'package:note_files/screens/randomNotes.dart';
import 'package:note_files/screens/settings.dart';
import 'package:provider/provider.dart';

import '../collection/isarCURD.dart';
import '../functions/isRtlTextDirection.dart';
import '../models/MyWarningDialog.dart';
import '../models/drawerItem.dart';
import '../models/isRtlBackIcon.dart';
import '../translations/translations.dart';
import './homePageBody.dart';

class FolderPage extends StatelessWidget {
  final Map<String, String> locale = requiredData.locale;
  final bool isRtl = requiredData.isRtl;
  final IsarService db = requiredData.db;
  final int? parentFolderId;
  final int? folderId;
  final String? folderName;

  FolderPage({super.key, this.folderName, this.parentFolderId, this.folderId});

  @override
  Widget build(BuildContext context) {
    final String title =
        folderId == null ? locale[TranslationsKeys.title]! : folderName!;

    Future<bool> onPop() async {
      if (folderId != null) {
        await context
            .read<ListViewProvider>()
            .getFoldersAndNotes(parentFolderId);
        print("parent folder is : ${parentFolderId}");
        Navigator.pop(context);
      } else {
        showDialog(
            context: context,
            builder: (context) => MyWarningDialog(
                  onWarningPressed: () {
                    Navigator.pop(context);
                    exit(0);
                  },
                  translationsWarningButton: locale[TranslationsKeys.exit]!,
                  translationsTitle: locale[TranslationsKeys.exitTheApp]!,
                  translationsCancelButton: locale[TranslationsKeys.cancel]!,
                ));
      }

      return false;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        onPop();
      },
      child: Directionality(
        textDirection: isRtlTextDirection(requiredData.isRtl!),
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
                builder: (context) => IconButton(
                      icon: const Icon(
                        Icons.menu_rounded,
                      ),
                      onPressed: () {
                        return Scaffold.of(context).openDrawer();
                      },
                    )),
            /*leading: folderId == null
                ? null
                : IconButton(
                    onPressed: () async {
                      //print("parint folder id :$parentFolderId");
                      await context
                          .read<ListViewProvider>()
                          .getFoldersAndNotes(parentFolderId);
                      Navigator.pop(context);
                    },
                    icon: IsRtlBackIcon(isRtl: isRtl),
                  ),*/
            title: Text(
              title,
            ),
            actions: folderId == null
                ? null
                : [
                    IconButton(
                      onPressed: () async {
                        //print("parint folder id :$parentFolderId");
                        await context
                            .read<ListViewProvider>()
                            .getFoldersAndNotes(parentFolderId);
                        Navigator.pop(context);
                      },
                      icon: IsRtlBackIcon(isRtl: !isRtl),
                    )
                  ], /*folderId == null
                ?
            requiredData.isDbRestored ? [IconButton(onPressed: () {
              /*
               show a confirmation dialog
                i dont if it done or not
               restart app dialog
                *  then add File restore.default*/

              showDialog(context: context, builder: (context) => MyWarningDialog(
                onWarningPressed: () async{
                  Navigator.pop(context);
                 await createDefRestoreFile();
                  showDialog(context: context, builder: (context) => RestartAppDialog(),);

                },
                translationsCancelButton: locale[TranslationsKeys.cancel]!,
                translationsTitle: locale[TranslationsKeys.restoreOldDbMsg]!,
                translationsWarningButton: locale[TranslationsKeys.restore]!,
              ),);

            }, icon: Icon(Icons.settings_backup_restore))]
                :null
                : [
                    Builder(
                        builder: (context) => IconButton(
                              icon: const Icon(
                                Icons.menu_rounded,
                              ),
                              onPressed: () {
                                return Scaffold.of(context).openDrawer();
                              },
                            ))
                  ],*/
          ),
          drawer: NavigationDrawer(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(locale[TranslationsKeys.title]!,
                            style: TextStyle(fontSize: 20)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                              )),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 30,
                    ),
                    /*
                    TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            locale[TranslationsKeys.backup]!,

                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),*/

                    DrawerItem(
                        page: Directionality(
                            textDirection: isRtlTextDirection(isRtl),
                            child: priorityScreen()),
                        text: locale[TranslationsKeys.priorityNotes]!),
                    DrawerItem(
                        page: SettingsPage(),
                        text: locale[TranslationsKeys.settings]!),
                    DrawerItem(
                        page: Directionality(
                            textDirection: isRtlTextDirection(isRtl),
                            child: RandomNotes()),
                        text: locale[TranslationsKeys.randomNotes]!),

                    /*DrawerItem(
                        page: ChangeNotifierProvider(
                          create: (context) => SearchProvider(),
                            child: SearchPage()),
                        text: locale[TranslationsKeys.search]!),*/
                  ],
                ),
              ),
            ],
          ),
          body: ListViewBody(
            parentId: folderId,
          ),
          floatingActionButton: FloatingNewFolderNote(parentFolderId: folderId),
        ),
      ),
    );
  }
}
//}
/*




TODO in the next version add search for the notes
TODO in the next version add the widget

TODO using flutter quill
TODO adding animations





*/
/// backup localy and cloudly using google drive
/// see flutter quill and the ability of using it in this application
/// flutter quill allows the user to underline some word or bold some text like the word app
