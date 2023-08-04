import 'package:flutter/material.dart';
import 'package:note_filest1/models/styles.dart';

import '../isarCURD.dart';
import 'editNote.dart';

class NotePage extends StatelessWidget {
  final String date;
  final String title;
  final String content;
  final IsarService db;
  final int id;
  final locale;
  final bool isRtl;
  final int? parentFolderId;
  const NotePage({super.key,required this.date,required this.title,required this.db,required this.id,required this.content,required this.parentFolderId,required this.locale,required this.isRtl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(date.toString()),
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context);
            Navigator.push(context,MaterialPageRoute(builder: (context) =>
                EditNote(locale: locale, db: db, isRtl: isRtl,parentFolderId: parentFolderId,idOfNote: id,oldContent: content,oldTitle: title,)
            ));
          }, icon: Icon(Icons.edit)),
          IconButton(onPressed: (){
            db.deleteNote(id);
            Navigator.pop(context);
          }, icon: Icon(Icons.delete))
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        child: ListView(
          children: [
            SizedBox( height: 15,),
            SizedBox(width: double.infinity,
                child: Text(title,style: BigText(),)),
            Divider(),
            SizedBox(width:double.infinity, child: Text(content,style: MediumText(),)),
            SizedBox( height: 15,),
          ],
        ),
      ),
    );
  }
}
