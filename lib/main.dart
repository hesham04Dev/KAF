import 'package:flutter/material.dart';
import 'package:note_filest1/screens/editNote.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Note Files'),
      routes: {
        EditNote.routeName: (_) => const EditNote(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool actionButtonPressed = false;
  bool gridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Builder(
            builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                  ),
                  onPressed: () {
                    return Scaffold.of(context).openDrawer();
                  },
                )),
        title: Text(widget.title),
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
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Setting",
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("backup", style: TextStyle(fontSize: 20)),
                    ))
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  //TODO open the page of this folder that can contains files and folders
                  // TODO open the page of the note allow to edit it and show the count of the words
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Row(
                    children: [
                      Icon(Icons.folder_rounded, size: 50, color: Colors.brown),
                      SizedBox(
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
          itemCount: 20,
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
                    shape: const OvalBorder(),
                    mini: true,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 200,
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      /*TODO controller*/
                                      onSubmitted: (value) {
                                        /*TODO */
                                      },
                                      decoration: const InputDecoration(
                                          hintText: " Folder Name",
                                          /*  border: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(20)
                                        ),*/

                                          filled: true,
                                          fillColor: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    /*TODO */
                                    Navigator.pop(context);
                                  },
                                  child: const Text('done'),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.create_new_folder),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    heroTag: null,
                    shape: const OvalBorder(),
                    mini: true,
                    onPressed: () {
                      Navigator.pushNamed(context, EditNote.routeName);
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
              tooltip: 'Increment',
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
}
