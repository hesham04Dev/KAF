import 'package:flutter/material.dart';
import 'package:note_files/models/FloatingNewFolderNote.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:note_files/requiredData.dart';
import 'package:provider/provider.dart';

import '../screens/About.dart';
import '../translations/translations.dart';
import '../functions/boolFn.dart';
import '../isarCURD.dart';


import '../models/ListViewBody.dart';


class FolderPage extends StatelessWidget {
  static const String routeName= "FolderPage";
  final Map<String, String> locale = requiredData.locale;
  final bool isRtl = requiredData.isRtl;
  final IsarService db = requiredData.db;

  final bool modalRoute;


  FolderPage({this.modalRoute = false  });




  @override
  Widget build(BuildContext context) {
    print("building folder page");
    final routeArgs =  modalRoute? null:  ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final int? parentFolderId = modalRoute ? null:routeArgs!["parentFolderId"];
    final int? folderId = modalRoute ? null:routeArgs!["folderId"];

    final String? folderName = modalRoute ? null :routeArgs!["folderName"];
    //if(provider == null) print("Please provide a provider");

    final String title = folderId == null ? locale[TranslationsKeys
        .title]! : folderName!;
    print('$folderId  folder id');
    bool isDark = isDarkMode(context);

      return Scaffold(
          //key: scaffoldKey,
      appBar: AppBar(
        leading: folderId == null ? null : IconButton(onPressed: () async{
          print("parint folder id :$parentFolderId");
          await context.read<ListViewProvider>().getFoldersAndNotes(parentFolderId);
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        title: Text(
          title,
        ),
        actions: folderId == null ? null : [Builder(
            builder: (context) =>
                IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                  ),
                  onPressed: () {
                    return Scaffold.of(context).openDrawer();
                  },
                ))
        ],

      ),
      drawer: NavigationDrawer(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const Divider(),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {},
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        locale[TranslationsKeys.settings]!,
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
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
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            AboutPage(locale: locale, isRtl: isRtl),));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        locale[TranslationsKeys.about]!,
                      ),
                    )),


              ],
            ),
          ),
        ],
      ),
      body:ListViewBody(parentId: folderId, ),


      floatingActionButton: FloatingNewFolderNote(parentFolderId: folderId,isDark: isDark),
    );


    }
  }
//}
/*
the open page
the show note page
make the app work db
make delete work
make edit work
add about page
TODO late make import and export and merge work  make the page of backup
# dynamic colors android 13
# arabic lang
TODO late icon of the application that also supports dynamic colors
 seying avedio about that
# improve the default theme
create my own way to the localization





open note page adding edit in the top re calling the edit note with  title and content argument and put the old text in the note
open folder page reclling the homepage with defferent parentFolderId
  and on the top calling the name of the folder note add argument for the name of the folder
delete all folders inside the deleted folder
state mangement by provider


TODO in the next version add search for the notes
TODO in the next version add the backup of the notes
TODO in the next version add the widget
TODO add the proiarity in the notes
adding the direction of the text inside the Note title and content

*/