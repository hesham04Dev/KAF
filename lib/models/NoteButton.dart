import 'package:flutter/material.dart';
import 'package:note_filest1/models/FolderOrNoteButton.dart';
import 'package:note_filest1/screens/NotePage.dart';

import '../isarCURD.dart';
import 'MultiLineText.dart';

class NoteButton extends StatelessWidget {

  final bool isGridView;
  final String noteTitle;
  final String noteTime;
  final String noteContent;
  final int noteId;
  final IsarService db;
  final int? parentFolderId;
  final locale;
  final bool isRtl;
  const NoteButton({super.key,required this.isGridView,required this.noteTitle,required this.noteTime,required this.db,required this.noteContent,required this.noteId,this.parentFolderId, required this.locale, required this.isRtl});

  @override
  Widget build(BuildContext context) {
    return FolderOrNoteButton(
        isGridView: isGridView,
        //icon: Icon(Icons.note_rounded,size: 70),
        onLongPressed: (){},
        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NotePage(date: noteTime, title: noteTitle, db:db,content: noteContent , id:noteId, parentFolderId: parentFolderId ,locale: locale,isRtl: isRtl),));},
        child: isGridView ?FittedBox(child: Text(noteTitle,overflow: TextOverflow.ellipsis,)):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(noteTime,overflow: TextOverflow.ellipsis),
            MultiLineText(margin: 82,maxLines: 1,text: noteTitle, bold:true),

            SizedBox(height: 5,),
            MultiLineText(margin:82,maxLines: 3,text: noteContent)


          ],
        ));
  }
}
