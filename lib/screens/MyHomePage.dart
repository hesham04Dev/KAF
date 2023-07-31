
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


import '../models/FolderButton.dart';
import '../models/FolderNameDialog.dart';

import '../translations/locale_keys.g.dart';
import 'editNote.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key });



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool actionButtonPressed = false;
  bool gridView = true;
  final String title = LocaleKeys.title.tr();
  /*TODO get it form the db*/

  @override
  Widget build(BuildContext context) {
    bool isDark =
        MediaQuery.maybePlatformBrightnessOf(context) == Brightness.dark;
   // context.setLocale(Locale("ar"));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_rounded,
              ),
              onPressed: () {
                return Scaffold.of(context).openDrawer();
              },
            )),
        title: Text(title,style: TextStyle(
            color: isDark ?Colors.white: Colors.black
        )),
        actions: [
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
                      icon: const Icon(Icons.close_rounded)),
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
                        LocaleKeys.settings,
                        style: TextStyle(fontSize: 20,color: !isDark ? Colors.black : Colors.white)
                      ).tr(),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {},
                    child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(LocaleKeys.backup, style: TextStyle(fontSize: 20,color: !isDark ? Colors.black : Colors.white)).tr(),
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
            return FolderButton(isDark: isDark, child:Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: 15),
              child: Row(
                children: [
                  Icon(Icons.folder_rounded,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary),
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
              isDark: isDark,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.folder_rounded,
                      size: 70,
                      color: Theme.of(context).colorScheme.primary),
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
                    shape: const CircleBorder(),
                    mini: true,
                    onPressed: () {
                      showDialog(context: context, builder:(context) => FolderNameDialog(isDark: isDark,onSubmit: (){/*TODO*/},));
                    },
                    child: const Icon(Icons.create_new_folder),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    heroTag: null,
                    shape: const CircleBorder(),
                    mini: true,
                    onPressed: () {
                      Navigator.pushNamed(context, EditNote.routeName,
                          arguments: [isDark]);
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
              shape: const CircleBorder(),
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
TODO arabic lang
TODO icon of the application that also supports dyanamic colors
*/