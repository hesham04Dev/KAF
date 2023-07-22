


import 'dart:ffi';

import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key});
static String routeName ="EditNote";
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your note"),

      ),
     body:  Padding(
       padding: EdgeInsets.all(8.0),
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           TextField(
             decoration: InputDecoration(hintText: "Title",border: InputBorder.none
             ),
           ),
           Text("the time"),//TODO add the time
           Expanded(
             child: TextField(
               keyboardType: TextInputType.multiline,
               expands: true,

               autocorrect: true,
               decoration: InputDecoration(
                 border: OutlineInputBorder(

                 ),

               ),

             ),
           )

         ],
       ),
     ),

    );
  }
}
