import 'package:flutter/material.dart';
import '../models/GridViewBody.dart';
import '../screens/About.dart';
import '../translations/translations.dart';

import '../collection/Folder.dart';
import '../collection/Note.dart';
import '../functions/boolFn.dart';
import '../isarCURD.dart';
import '../models/FolderButton.dart';
import '../models/FolderNameDialog.dart';
import '../models/ListViewBody.dart';
import 'editNote.dart';

class MyHomePage extends StatefulWidget {
  final Map<String, String> locale;
  final bool isRtl;
  final IsarService db;
  final int? parentFolderId ;
  final String? folderName;

  const MyHomePage(
      {super.key, required this.locale, required this.isRtl, required this.db,this.parentFolderId,this.folderName});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool actionButtonPressed = false;
  bool isGridView = false;

  //widget.db.
  /*TODO get it form the db*/
    List<Folder> listFolders = [];
    List<Note> listNotes = [];

  @override
  Widget build(BuildContext context) {
    //final isGridView = widget.db.settings.get(SettingsPage.isGridViewId);
    final String title = widget.parentFolderId == null ?widget.locale[TranslationsKeys.title]! : widget.folderName!;
    bool isDark = isDarkMode(context);

    /*TODO get them*/
 Future<String>? getBodyData()async{

  listFolders = await widget.db.getFolders(widget.parentFolderId);
  listNotes = await widget.db.getNotes(widget.parentFolderId);


  return "done";
}
print("parentFolderId:  ${widget.parentFolderId}");
    return Scaffold(
      appBar: AppBar(
        leading:widget.parentFolderId == null ? null : IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
        title: Text(
          title,
        ),
        actions: widget.parentFolderId == null ? null : [Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_rounded,
              ),
              onPressed: () {
                return Scaffold.of(context).openDrawer();
              },
            )) ],

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
                        widget.locale[TranslationsKeys.settings]!,
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
                        widget.locale[TranslationsKeys.backup]!,

                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage(locale: widget.locale,isRtl: widget.isRtl),));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        widget.locale[TranslationsKeys.about]!,
                      ),
                    )),


              ],
            ),
          ),
        ],
      ),
      body:FutureBuilder<String>(
        future: getBodyData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Show loading icon
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return isGridView
               ? GridViewBody(db:widget.db ,isRtl: widget.isRtl,locale: widget.locale,isGridView: isGridView)
              : ListViewBody(db:widget.db ,isRtl: widget.isRtl,locale: widget.locale,isGridView: isGridView,listNotes: listNotes,listFolders: listFolders );

          }
        },
      ),


      floatingActionButton: Column(
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
                    //shape: const CircleBorder(),
                    mini: true,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => FolderNameDialog(
                                db: widget.db,
                                parentFolderId: null,
                                isRtl: widget.isRtl,
                                onSubmit: (text) {
                                  final newFolder = Folder()..name = text
                                    ..parent = widget.parentFolderId;
                                  widget.db.saveFolder(newFolder);
                                  setState(() {

                                  });
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
                    //shape: const CircleBorder(),
                    mini: true,
                    onPressed: () {
                      Navigator.pushNamed(context, EditNote.routeName,
                          arguments: {
                            "isDark": isDark,
                            "parentFolderId": widget.parentFolderId
                          });
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
              //shape: const CircleBorder(),
              onPressed: () {
                if (actionButtonPressed == false) {
                  actionButtonPressed = true;
                } else {
                  actionButtonPressed = false;
                }
                setState(() {});
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
      ),
    );
  }
} /*
the open page
the show note page
make the app work db
make delete work
make edit work
add about page
TODO late make import and export and merge work  make the page of backup
# dynamic colors android 13
# arabic lang
TODO late icon of the application that also supports dyanamic colors
 seying avedio about that
# improve the default theme
create my own way to the localization





open note page adding edit in the top re calling the edit note with  title and content argument and put the old text in the note
open folder page reclling the homepage with defferent parentFolderId
  and on the top calling the name of the folder note add argument for the name of the folder
delete all folders inside the deleted folder
TODO sittings page adding
TODO state mangement by bloc


TODO in the next version add search for the notes
adding the direction of the text inside the Note title and content

*/
