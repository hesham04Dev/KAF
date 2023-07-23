

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Note Files'),
      routes: {
      EditNote.routeName:(_)=>const EditNote(),
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

  bool actionButtonPressed=false;
  bool gridView=false;
  bool menuPressed =false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: NavigationDrawer(
        children: [],

      ),
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Builder(builder: (context) =>  IconButton(
          icon: Icon(menuPressed == false?Icons.menu_rounded : Icons.close_rounded),
          onPressed: (){
            if(menuPressed == true){menuPressed = false ;}

            else {
              menuPressed = true;

            }
    setState(() {

    });
            return Scaffold.of(context).openDrawer();

          },

        )),
        title: Text(widget.title),
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(icon: Icon(gridView ? Icons.grid_view_rounded: Icons.view_list_rounded),onPressed: (){
            if(gridView == true) {
              gridView =false;
            } else {
              gridView = true;
            }
            setState(() {

            });
          },),
        )],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(itemBuilder: (context, index) {
          return MaterialButton(
            onPressed: (){
              //TODO open the page of this folder that can contains files and folders
              // TODO open the page of the note allow to edit it and show the count of the words

            },
            child:   const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 15),
              child: Row(
                children: [
                  Icon(Icons.folder_rounded,size: 50,color:Colors.brown ),
                  SizedBox(width: 10,),
                  FittedBox(
                    child: Text("hello",style: TextStyle(
                      fontSize: 20
                    ),),
                  ),
                ],
                ),
            )
          );
        },itemCount: 20,),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
         if(actionButtonPressed) Column(
           mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  shape: const OvalBorder(),
                  mini: true,
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>  Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(height: 10,),
                               Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:  Container(
                                  width: 200,


                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                        /*TODO controller*/
                                    decoration: InputDecoration(hintText: " Folder Name",
                                        border: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(50),

                                    ),
                                    ),

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
                              const SizedBox(height: 10,)
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
                 shape: const OvalBorder(),
                 mini: true,
                 onPressed: (){
                  Navigator.pushNamed(context, EditNote.routeName);
                 },
                 child: const Icon(Icons.note_add),
               ),
             ) ,
             const SizedBox(height: 10,)
           ],
         ),
          FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: (){
                if(actionButtonPressed==false){
                  actionButtonPressed=true;

                }else{
                  actionButtonPressed=false;
                }
                setState(() {

                });
              },
              tooltip: 'Increment',
              child:  Transform.rotate(origin: Offset.zero,angle:actionButtonPressed == false ? 0:3.14,child: const Icon(Icons.keyboard_arrow_up_rounded,size: 40,),)
          )
        ],
      ),

    );
  }
}
