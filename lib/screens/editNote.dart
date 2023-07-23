



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
        leading: IconButton(onPressed: (){
          /*TODO if there is data show dialog ask the user if he need to return without save*/
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back_rounded),),
        title: Center(child: const Text("Your note")),
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(onPressed: (){}, icon: Icon(Icons.save_rounded)),
        )],
      ),
     body:   Padding(
       padding: EdgeInsets.all(8.0),
       child: Container(
         decoration: BoxDecoration(
           color: Colors.grey[300],
           borderRadius: BorderRadius.circular(10)
         ),
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               TextField(
                 decoration: InputDecoration(hintText: "Title",border: InputBorder.none
                 ),
               ),
               Text("the time"),//TODO add the time
               TextField(
                 keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 20,
                 autocorrect: true,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                     hintText: "your note"    ),

               )

             ],
           ),
         ),
       ),
     ),

    );
  }
}
