import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_files/models/NoteButton.dart';
import 'package:note_files/requiredData.dart';

import '../collection/Note.dart';
import '../functions/isRtlTextDirection.dart';
import '../translations/translations.dart';

int priority =10;
class priorityScreen extends StatefulWidget {
  const priorityScreen({super.key});

  @override
  State<priorityScreen> createState() => _priorityScreenState();
}

class _priorityScreenState extends State<priorityScreen> {
  bool isRtl = requiredData.isRtl;
  late List<Note> _listNotes;

  _getPriorityData() async{
    _listNotes = await requiredData.db.getNotesByPriority(priority);
    print("we get the data");
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  PopupMenuButton(
          child: Text("priority: $priority"),
          onSelected: (value) {
            print(value);
            priority = value;
            setState(() {});
            print(value);
          },
          itemBuilder: (BuildContext context) => List.generate(
            10,
                (index) => PopupMenuItem(
              value: index + 1,
              child: Text("${TranslationsKeys.priority} ${index + 1}"),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _getPriorityData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {

            return ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  NoteButton(
                      priority: priority,
                      contentDirection: isRtlTextDirection(_listNotes[index].isContentRtl ?? isRtl),
                      titleDirection:   isRtlTextDirection(_listNotes[index].isTitleRtl ?? isRtl),

                      parentFolderId:_listNotes[index].parentFolderId,

                      noteContent: _listNotes[index].content!,
                      noteId: _listNotes[index].id,
                      noteTitle: _listNotes[index].title!,
                      noteTime: formatDate(_listNotes[index].date!,
                          [yy, "/", mm, "/", dd, "   ", hh, ":", nn])),
                  Divider(color: Colors.white54),
                ],
              ),
              itemCount: _listNotes.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
