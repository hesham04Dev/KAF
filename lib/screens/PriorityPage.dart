import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_files/models/NoteButton.dart';
import 'package:note_files/requiredData.dart';
import 'package:provider/provider.dart';

import '../collection/Note.dart';
import '../functions/isRtlTextDirection.dart';
import '../provider/PriorityProvider.dart';
import '../translations/translations.dart';

int priority = 10;

class priorityScreen extends StatefulWidget {
  const priorityScreen({super.key});

  @override
  State<priorityScreen> createState() => _priorityScreenState();
}

class _priorityScreenState extends State<priorityScreen> {
  bool isRtl = requiredData.isRtl;
  late List<Note> _listNotes;
  Map<String, String> locale = requiredData.locale;

  @override
  Widget build(BuildContext context) {
    /* _getPriorityData() async{
      _listNotes = await context.watch<PriorityProvider>().getNotesByPriority(priority);

      return true;
    }*/
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: PopupMenuButton(
          child: Text("${locale[TranslationsKeys.priority]}: $priority"),
          onSelected: (value) {
            //print(value);
            priority = value;
            setState(() {});
            //print(value);
          },
          itemBuilder: (BuildContext context) => List.generate(
            10,
            (index) => PopupMenuItem(
              value: index + 1,
              child: Center(
                  child: Text(
                      "${locale[TranslationsKeys.priority]} ${index + 1}")),
            ),
          ),
        ), /*TODO move it to models and use it in edit note page*/
      ),
      body: FutureBuilder(
        future: context
            .read<PriorityProvider>()
            .getNotesByPriority(priority), //_getPriorityData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            _listNotes = context.watch<PriorityProvider>().listNotes;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (context, index) => NoteButton(
                    isPriorityPageOpened: true,
                    priority: priority,
                    contentDirection: isRtlTextDirection(_listNotes[index]
                        .isContentRtl! /*snapshot.data[index].isContentRtl ?? isRtl*/),
                    titleDirection: isRtlTextDirection(
                        /*_listNotes[index].isTitleRtl*/ snapshot
                                .data[index].isTitleRtl ??
                            isRtl),
                    parentFolderId: /*_listNotes[index].parentFolderId*/
                        snapshot.data[index].parentFolderId,
                    noteContent: _listNotes[index]
                        .content! /*snapshot.data[index].content*/,
                    noteId: /*_listNotes[index].id*/
                        snapshot.data[index].id,
                    noteTitle: _listNotes[index]
                        .title! /*snapshot.data[index].title,*/,
                    noteTime: formatDate(
                        /*_listNotes[index].date!*/ snapshot.data[index].date,
                        [yy, "/", mm, "/", dd, "   ", hh, ":", nn])),
                itemCount: /*_listNotes.length*/ snapshot.data.length,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
