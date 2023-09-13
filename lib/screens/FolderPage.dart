import 'dart:io';


import 'package:flutter/material.dart';

import 'package:note_files/models/FloatingNewFolderNote.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:note_files/requiredData.dart';
import 'package:note_files/screens/PriorityPage.dart';
import 'package:note_files/screens/randomNotes.dart';
import 'package:provider/provider.dart';

import '../functions/isRtlTextDirection.dart';
import '../models/MyWarningDialog.dart';
import '../models/drawerItem.dart';
import '../models/isRtlBackIcon.dart';
import '../screens/AboutPage.dart';
import '../translations/translations.dart';
import '../isarCURD.dart';
import '../models/ListViewBody.dart';


class FolderPage extends StatelessWidget {
  static const String routeName= "FolderPage";
  final Map<String, String> locale = requiredData.locale;
  final bool isRtl = requiredData.isRtl;
  final IsarService db = requiredData.db;

  final bool modalRoute;


  FolderPage({super.key, this.modalRoute = false  });




  @override
  Widget build(BuildContext context) {
    //print("building folder page");
    final routeArgs =  modalRoute? null:  ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final int? parentFolderId = modalRoute ? null:routeArgs!["parentFolderId"];
    final int? folderId = modalRoute ? null:routeArgs!["folderId"];

    final String? folderName = modalRoute ? null :routeArgs!["folderName"];


    final String title = folderId == null ? locale[TranslationsKeys
        .title]! : folderName!;
    //print('$folderId  folder id');
    Future<bool> onWillPop() async {
      print("poping is ahmaq");
      if (folderId != null){
      await context.read<ListViewProvider>().getFoldersAndNotes(parentFolderId);
      print("poping ");
      print("parent folder is : ${parentFolderId}");
      Navigator.pop(context);}else{
        showDialog(context: context, builder: (context) =>
             MyWarningDialog(
            onWarningPressed: (){
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

      return WillPopScope(
        onWillPop: onWillPop ,
        child: Scaffold(
        appBar: AppBar(
          leading: folderId == null ? null : IconButton(onPressed: () async{
            //print("parint folder id :$parentFolderId");
            await context.read<ListViewProvider>().getFoldersAndNotes(parentFolderId);
            Navigator.pop(context);
          }, icon: IsRtlBackIcon(isRtl: isRtl),),
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

                  DrawerItem(page: priorityScreen(), text: locale[TranslationsKeys.priorityNotes]!),
                  DrawerItem(page: RandomNotes(), text: locale[TranslationsKeys.randomNotes]!),
                  DrawerItem(page: AboutPage(), text: locale[TranslationsKeys.about]!),



                ],
              ),
            ),
          ],
        ),
        body:ListViewBody(parentId: folderId, ),


        floatingActionButton: FloatingNewFolderNote(parentFolderId: folderId),
    ),
      );


    }

  }
//}
/*


TODO in the next version add search for the notes
TODO in the next version add the backup of the notes
TODO in the next version add the widget

TODO using flutter quill
TODO adding google fonts
TODO or adding this fonts rubic cario amiri but i preffer to add google fonts all

TODO adding animations

TODO use lelezar in the images in google play





*/
/// rode adding animations to the open page and to the font changing and to the backup also to the Floating action button
/// backup localy and cloudly using google drive
/// adding google font and save the font name in the db to use it when he reopen the app
/// i prefer to change the main font to rubic font
/// see flutter quill and the ability of using it in this application
/// flutter quill allows the user to underline some word or bold some text like the word app