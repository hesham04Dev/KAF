import 'package:flutter/material.dart';
import '../models/FolderOrNoteButton.dart';
import '../screens/NotePage.dart';

import '../isarCURD.dart';
import 'MultiLineText.dart';

class NoteButton extends StatelessWidget {
  final bool isRtl;
  final Map<String, String> locale;

  final String noteTitle;
  final String noteTime;
  final String noteContent;
  final int noteId;
  final IsarService db;
  final TextDirection titleDirection;
  final TextDirection contentDirection;
  final int? parentFolderId;
  const NoteButton({super.key,required this.locale, required this.noteTitle,required this.noteTime,required this.db,required this.noteContent,required this.noteId,this.parentFolderId,required this.titleDirection,required this.contentDirection,required this.isRtl});

  @override
  Widget build(BuildContext context) {
    return FolderOrNoteButton(
        isRtl: isRtl,

        withBackground: true,
        onLongPressed: (){},
        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NotePage(
          titleDirection: titleDirection,
          contentDirection: contentDirection,
          locale: locale,
          date: noteTime, title: noteTitle, db:db,content: noteContent , id:noteId, parentFolderId: parentFolderId ,),));},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(noteTime,overflow: TextOverflow.ellipsis),
              MultiLineText(margin: 82,maxLines: 1,text: noteTitle, bold:true,textDirection: titleDirection),

              const SizedBox(height: 5,),
              MultiLineText(margin:82,maxLines: 3,text: noteContent,textDirection: contentDirection,),


            ],
          ),
        ));
  }
}
