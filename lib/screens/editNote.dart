import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_filest1/models/DiscardNoteDialog.dart';
import 'package:note_filest1/models/styles.dart';
import 'package:note_filest1/screens/MyHomePage.dart';
import '../collection/Note.dart';
import '../functions/isDark.dart';
import '../isarCURD.dart';
import '../models/AutoDirection.dart';
import '../translations/translations.dart';

class EditNote extends StatefulWidget {
  final Map<String, String> locale;
  final IsarService db;
  final bool isRtl;
   final int? parentFolderId;
   final String? oldTitle;
   final String? oldContent;
   final int? idOfNote;


  const EditNote({super.key, required this.locale, required this.db,required this.isRtl,this.parentFolderId,this.oldTitle,this.oldContent,this.idOfNote});

  static const String routeName = "EditNote";

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  var titleController = TextEditingController();
  var noteTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  late final bool isDark;

  @override
  void initState() {
    super.initState();
    //final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
     isDark = /*routeArgs["isDark"] ??*/ isDarkMode(context);

     //parentFolderId = routeArgs['parentFolderId'];

    /// these arguments fore using this page to edit the note
     /*oldTitle = routeArgs['title'];
     oldContent = routeArgs['content'];
     widget.idOfNote = routeArgs['id'];*/

    /// oldTitle and oldContent are the text written in the note
    widget.oldTitle == null ? null :titleController.text = widget.oldTitle!;
    widget.oldContent == null ? null :noteTextController.text = widget.oldContent!;
    /// by doing that we put the old text in the TextFormField

  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    isDark = routeArgs["isDark"] ?? isDarkMode(context);


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DiscardNoteDialog(
                  locale: widget.locale,
                );
              },
            );
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          formatDate(DateTime.now(), [yy, "/", mm, "/", dd, "   ", hh, ":", nn])
              .toString(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if(widget.idOfNote == null){
                    var newNote = Note()
                      ..title = titleController.text
                      ..date = DateTime.now()
                      ..content = noteTextController.text
                      ..parentFolderId = widget.parentFolderId != null ? widget.parentFolderId: null;


                    widget.db.saveNote(newNote);}
                    else {
                      var oldNote = await widget.db.getNote(widget.idOfNote!);
                      oldNote!.title = titleController.text;
                      oldNote!.date = DateTime.now();
                      oldNote!.content = noteTextController.text;
                      widget.db.updateNote(oldNote);
                    }

                    Navigator.pop(context);


                    /*TODO use another way this way*/
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  MyHomePage(locale: widget.locale, isRtl: widget.isRtl, db: widget.db)),
                    );


                }},
                icon: const Icon(Icons.save_rounded)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: isDark == true ? Colors.white10 : Colors.black12,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoDirection(
                      text: titleController.text != ''
                          ? titleController.text[0]
                          : titleController.text,
                      child: TextFormField(

                        controller: titleController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return widget.locale[TranslationsKeys.titleError]!;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: widget.locale[TranslationsKeys.yourTitle]!,
                        ),
                        style: const MediumText(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoDirection(
                      text: noteTextController.text != ''
                          ? noteTextController.text[0]
                          : noteTextController.text,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: null,
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return widget.locale[TranslationsKeys.noteError]!;
                          }
                          return null;
                        },
                        controller: noteTextController,
                        autocorrect: true,
                        style: const MediumText(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.locale[TranslationsKeys.yourNote]!,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
