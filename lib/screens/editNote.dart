import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_filest1/models/DiscardNoteDialog.dart';

import 'package:note_filest1/screens/MyHomePage.dart';

import '../collection/Note.dart';
import '../functions/isDark.dart';
import '../isarCURD.dart';
import '../models/AutoDirectionTextFormField.dart';
import '../translations/translations.dart';

class EditNote extends StatelessWidget {
  final Map<String, String> locale;
  final IsarService db;
  final bool isRtl;

  EditNote(
      {super.key, required this.locale, required this.db, required this.isRtl});

  static const String routeName = "EditNote";

  final titleController = TextEditingController();
  final noteTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    bool isDark = routeArgs["isDark"] ?? isDarkMode(context);

    final int? parentFolderId = routeArgs['parentFolderId'];

    /// these arguments fore using this page to edit the note
    final String? oldTitle = routeArgs['title'];
    final String? oldContent = routeArgs['content'];
    final int? idOfNote = routeArgs['id'];

    /// oldTitle and oldContent are the text written in the note
    oldTitle == null ? null : titleController.text = oldTitle;
    oldContent == null ? null : noteTextController.text = oldContent;

    /// by doing that we put the old text in the TextFormField
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DiscardNoteDialog(
                  locale: locale,
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
                    if (idOfNote == null) {
                      var newNote = Note()
                        ..title = titleController.text
                        ..date = DateTime.now()
                        ..content = noteTextController.text
                        ..parentFolderId =
                            parentFolderId != null ? parentFolderId : null;

                      db.saveNote(newNote);
                    } else {
                      var oldNote = await db.getNote(idOfNote);
                      oldNote!.title = titleController.text;
                      oldNote.date = DateTime.now();
                      oldNote.content = noteTextController.text;
                      db.updateNote(oldNote);
                    }

                    Navigator.pop(context);

                    /*TODO use another way this way*/
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(locale: locale, isRtl: isRtl, db: db)),
                    );
                  }
                },
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
                      child:  AutoDirectionTextFormField(
                        controller: titleController,
                        locale: locale,
                        errMessage: TranslationsKeys.titleError,
                        hintText: TranslationsKeys.yourTitle,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  AutoDirectionTextFormField(
                      controller: noteTextController,
                      locale: locale,
                      errMessage: TranslationsKeys.noteError,
                      hintText: TranslationsKeys.yourNote,
                      maxLines: null,
                      isUnderLinedBorder: false,

                    )
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
