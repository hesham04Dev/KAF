import 'package:flutter/material.dart';
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
  final bool? isPriorityPageOpened;
   NoteButton({super.key,required this.priority,this.isPriorityPageOpened, required this.noteTitle,required this.noteTime,required this.noteContent,required this.noteId,this.parentFolderId,required this.titleDirection,required this.contentDirection,});

  @override
  Widget build(BuildContext context) {
    return FolderOrNoteButton(
        withBackground: true,
        onLongPressed: (){},
        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NotePage(
          isPriorityPageOpened: isPriorityPageOpened ?? false,
          titleDirection: titleDirection,
          contentDirection: contentDirection,
          priority: priority,
          date: noteTime, title: noteTitle,content: noteContent , id:noteId, parentFolderId: parentFolderId ,),));},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [

              Center(
                child: Row(
                  children: [
                    Text(noteTime,overflow: TextOverflow.ellipsis),

                   priority==null ? const SizedBox() : Container(
                     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                     margin: const EdgeInsets.symmetric(horizontal: 10),
                     decoration: BoxDecoration(
                         color: priorityColors[priority! -1],
                       borderRadius: BorderRadius.circular(15)
                     ),
                     child: Text("$priority",),
                   )
                  ],
                ),
              ),
              noteTitle== null ? SizedBox(): MultiLineText(margin: 92,maxLines: 1,text: noteTitle, bold:true,textDirection: titleDirection,fontSize: 19),
              SizedBox(height:noteTitle == null ?0: 5,),
              noteContent== null ? SizedBox(): MultiLineText(margin:92,maxLines: 3,text: noteContent,textDirection: contentDirection,),


            ],
          ),
        ));
  }
}
