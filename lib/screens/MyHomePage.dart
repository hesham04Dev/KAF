

import 'package:flutter/material.dart';
import 'package:note_filest1/translations/translations.dart';


import '../models/FolderButton.dart';
import '../models/FolderNameDialog.dart';


import 'SettingPage.dart';
import 'editNote.dart';

class MyHomePage extends StatefulWidget {
  final  Map<String,String> locale;
  final isRtl;
  final db;
  const MyHomePage({super.key, required this.locale,required this.isRtl,required this.db });



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool actionButtonPressed = false;
  bool gridView = true;
  //widget.db.
  /*TODO get it form the db*/

  @override
  Widget build(BuildContext context) {
    //final gridView = widget.db.settings.get(SettingsPage.gridViewId);
    final String title = widget.locale[TranslationsKeys.title]!;
    bool isDark =
        MediaQuery.maybePlatformBrightnessOf(context) == Brightness.dark;
    final folderId = 0;
    final parentFolderId = 0; /*TODO get them*/
    return Scaffold(
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
        title: Text(title,

        ),
        /*actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                  gridView ? Icons.grid_view_rounded : Icons.view_list_rounded),
              onPressed: () {
                if (gridView == true) {
                  gridView = false;
                } else {
                  gridView = true;
                }
                setState(() {});
              },
            ),
          )
        ],*/
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
                      icon: const Icon(Icons.close_rounded,color: Colors.red,)),
                ),
                const Divider(),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {},
                    child:  Padding(
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
                    child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(widget.locale[TranslationsKeys.backup]!,
                          //style:  TextStyle(fontSize: 20,color: !isDark ? Colors.black : Colors.white)
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),

      body: gridView
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return FolderButton(
              parentFolderId: 0,
              id: 0,/*TODO get it from index from the data getted*/
              db: widget.db,
                isRtl: widget.isRtl,
                locale:widget.locale,isDark: isDark, child:Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: 15),
              child: Row(
                children: [
                  Icon(Icons.folder_rounded,
                      size: 50,
                     // color: Theme.of(context).colorScheme.primary
                ),
                  const SizedBox(
                    width: 10,
                  ),
                   FittedBox(
                    child: Text(
                      "hello",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),

                ],
              ),
            ));
          },
          separatorBuilder: (context, index) =>
          const  Divider(color: Colors.white54),
          itemCount: 20/*listLength*/,
        ),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              childAspectRatio: 1.2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20
          ),
          itemBuilder: (context, index) {
            return FolderButton(
              id: 0 /*TODO get it from index data getted*/,
              parentFolderId: 0,
              db:widget.db,
              isRtl: widget.isRtl,
              locale: widget.locale,
              isDark: isDark,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.folder_rounded,
                      size: 70,
                      //color: Theme.of(context).colorScheme.primary
                ),
                  const SizedBox(height: 5,),
                  const FittedBox(child: Text("data is long text"))
                ],
              ),
            );
          },
          itemCount: 50,
        ),
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
                      showDialog(context: context, builder:(context) => FolderNameDialog(
                        db: widget.db,
                        parentFolderId: -1 /*TODO*/,
                        isRtl:  widget.isRtl,
                        onSubmit: (){/*TODO*/},
                      locale: widget.locale,));
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
                        isDark :isDark,
                        folderId: folderId,
                        parentFolderId: parentFolderId
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
}/*
TODO the open page
TODO the show note page
TODO make the app work db
TODO make delete work
TODO make edit work
TODO add about page
TODO make import and export and merge work  make the page of backup
# dynamic colors android 13
# arabic lang
TODO icon of the application that also supports dyanamic colors
 seying avedio about that
# improve the default theme
TODO create my own way to the localization
*/