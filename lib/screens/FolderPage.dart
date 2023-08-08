import 'package:flutter/material.dart';
import 'package:note_files/models/FloatingNewFolderNote.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:provider/provider.dart';

import '../screens/About.dart';
import '../translations/translations.dart';

import '../collection/Folder.dart';
import '../collection/Note.dart';
import '../functions/boolFn.dart';
import '../isarCURD.dart';


import '../models/ListViewBody.dart';


class FolderPage extends StatelessWidget {
  final Map<String, String> locale;
  final bool isRtl;
  final IsarService db;
  final bool modalRoute;
 /* final int? parentFolderId;
  final String? folderName;*/

  FolderPage(
      {super.key, required this.locale, required this.isRtl, required this.db,this.modalRoute = false  });
  static const String routeName= "FolderPage";
  //bool actionButtonPressed = false;

    //List<Folder> oldListFolders =[];
    //List<Note> oldListNotes =[];



  @override
  Widget build(BuildContext context) {
    print("building folder page");
    final routeArgs =  modalRoute? null:  ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //ListViewProvider provider = Provider.of<ListViewProvider>(context);
    final int? parentFolderId = modalRoute ? null:routeArgs!["parentFolderId"];
    final String? folderName = modalRoute ? null :routeArgs!["folderName"];
    //if(provider == null) print("Please provide a provider");

    final String title = parentFolderId == null ? locale[TranslationsKeys
        .title]! : folderName!;
    bool isDark = isDarkMode(context);
   // print(provider.state);
    /*if(provider.state == listScreenState.initial && provider!.listFolders!.isEmpty){
      //print("listFolders :${provider.listFolders}");
      print("first if");
      //provider.getFoldersAndNotes(parentFolderId);


      return Container(
        child: Center(child: SizedBox(child: CircularProgressIndicator(), width: 30, height: 30,))
      );
    }*//*else*///{
     // oldListFolders = provider.listFolders ?? [];
      //oldListNotes = provider.listNotes ?? [];
     // if (oldListFolders.length == 0) print("failed");
      //else print("success");
    //  if(provider.listFolders!.length  > oldListFolders.length  && oldListFolders.length > 0) provider.updateFolders();
      //if(provider.listFolders!.isNotEmpty && oldListFolders.isNotEmpty){
     // if(provider.listNotes!.length  > oldListNotes.length && oldListNotes.length >0) provider.updateNotes();//}
      //print("listFolders :${provider.listFolders}");
      return Scaffold(
      appBar: AppBar(
        leading: parentFolderId == null ? null : IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        title: Text(
          title,
        ),
        actions: parentFolderId == null ? null : [Builder(
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
      body:ListViewBody(db: db, isRtl: isRtl, locale: locale,parentId: parentFolderId, ),


      floatingActionButton: FloatingNewFolderNote(db: db, isRtl: isRtl,locale: locale,parentFolderId: parentFolderId,isDark: isDark),
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
TODO state mangement by bloc


TODO in the next version add search for the notes
TODO in the next version add the backup of the notes
adding the direction of the text inside the Note title and content

*/
