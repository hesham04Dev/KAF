import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:note_files/requiredData.dart';
import 'package:provider/provider.dart';


import '../collection/Note.dart';
import '../functions/boolFn.dart';
import '../isarCURD.dart';
import '../models/AutoDirectionTextFormField.dart';
import '../models/MyWarningDialog.dart';
import '../models/priorityMenu.dart';
import '../translations/translations.dart';
int priority =1;
class EditNote extends StatelessWidget {
  final Map<String, String> locale = requiredData.locale;
  final IsarService db = requiredData.db;
  final bool isRtl = requiredData.isRtl;
  static const String routeName = "EditNote";

  final titleController = TextEditingController();
  final noteTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ListViewProvider provider = Provider.of<ListViewProvider>(context,listen:false);
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
                return MyWarningDialog(
                  TranslationsWarningButton: locale[TranslationsKeys.discard]!,
                  onWarningPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  TranslationsTitle: locale[TranslationsKeys.discardYourNote]!,
                  TranslationsCancelButton: locale[TranslationsKeys.cancel]!,
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
                        ..isTitleRtl= isRTL(titleController.text[0],isRtl)
                        ..date = DateTime.now()
                        ..priority = priority
                        ..content = noteTextController.text
                        ..isContentRtl = isRTL(titleController.text[0],isRtl)
                        ..parentFolderId =
                        parentFolderId != null ? parentFolderId : null;

                      db.saveNote(newNote);
                      provider.addNote(newNote);
                    } else {
                      var oldNote = await db.getNote(idOfNote);
                      oldNote!.title = titleController.text;
                      oldNote.date = DateTime.now();
                      oldNote.content = noteTextController.text;
                      db.updateNote(oldNote);
                      provider.updateNote(oldNote);
                    }

                    Navigator.pop(context);



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
            color: isDark == true ? Colors.white10 : Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Center(child:PriorityMenu()),
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
