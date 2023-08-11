import 'package:flutter/material.dart';
import 'package:note_files/models/styles.dart';
import 'package:note_files/requiredData.dart';
import '../models/FolderOrNoteButton.dart';
import '../prioityColors.dart';
import '../screens/NotePage.dart';

import '../isarCURD.dart';
import 'MultiLineText.dart';

class NoteButton extends StatelessWidget {

  final bool isRtl =requiredData.isRtl;
  final Map<String, String> locale =requiredData.locale;

  final String noteTitle;
  final String noteTime;
  final String noteContent;
  final int noteId;
  final IsarService db = requiredData.db;
  final TextDirection titleDirection;
  final TextDirection contentDirection;
  final int? parentFolderId;
  final int? priority;
   NoteButton({super.key,required this.priority, required this.noteTitle,required this.noteTime,required this.noteContent,required this.noteId,this.parentFolderId,required this.titleDirection,required this.contentDirection,});

  @override
  Widget build(BuildContext context) {
    return FolderOrNoteButton(
        withBackground: true,
        onLongPressed: (){},
        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NotePage(
          titleDirection: titleDirection,
          contentDirection: contentDirection,
          priority: priority,
          date: noteTime, title: noteTitle,content: noteContent , id:noteId, parentFolderId: parentFolderId ,),));},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(noteTime,overflow: TextOverflow.ellipsis),

                 priority==null ? SizedBox() : Container(
                   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                   margin: EdgeInsets.symmetric(horizontal: 10),
                   decoration: BoxDecoration(
                       color: priorityColors[priority! -1],
                     borderRadius: BorderRadius.circular(15)
                   ),
                   child: Text("$priority",),
                 )
                ],
              ),
              MultiLineText(margin: 92,maxLines: 1,text: noteTitle, bold:true,textDirection: titleDirection),

              const SizedBox(height: 5,),
              MultiLineText(margin:92,maxLines: 3,text: noteContent,textDirection: contentDirection,),


            ],
          ),
        ));
  }
}
