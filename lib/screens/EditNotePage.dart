import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_files/models/styles.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:note_files/requiredData.dart';
import 'package:provider/provider.dart';

import '../collection/Note.dart';
import '../collection/isarCURD.dart';
import '../functions/boolFn.dart';
import '../functions/isRtlTextDirection.dart';
import '../models/AutoDirectionTextField.dart';
import '../models/MyWarningDialog.dart';
import '../models/isRtlBackIcon.dart';
import '../models/priorityMenu.dart';
import '../provider/PriorityProvider.dart';
import '../translations/translations.dart';

class EditNote extends StatelessWidget {
  final Map<String, String> locale = requiredData.locale;
  final IsarService db = requiredData.db;
  final bool isRtl = requiredData.isRtl;

  final titleController = TextEditingController();
  final noteTextController = TextEditingController();
  final int? parentFolderId;

  /// these arguments fore using this page to edit the note
  final String? oldTitle;
  final String? oldContent;
  final int? idOfNote;
  final int? priority;

  final bool? isPriorityPageOpened;

  /// when true this means that the application calls editNote from priority page this for the provider
  EditNote(
      {super.key,
      this.priority,
      this.isPriorityPageOpened,
      this.idOfNote,
      this.oldTitle,
      this.oldContent,
      this.parentFolderId});

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    int get_priority = context.watch<PriorityProvider>().priority;

    if (!isLoaded && priority != null) {
      print("priority is $priority");
      isLoaded = true;
      get_priority = priority!;
    }
    ;
    ListViewProvider provider =
        Provider.of<ListViewProvider>(context, listen: false);

    /// oldTitle and oldContent are the text written in the note
    oldTitle == null ? null : titleController.text = oldTitle!;
    oldContent == null ? null : noteTextController.text = oldContent!;

    /// by doing that we put the old text in the TextFormField
    Future<bool> onPop() async {
      if (titleController.text.isEmpty && noteTextController.text.isEmpty) {
        print("poping edit text");
        Navigator.pop(context);
        return false;
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return MyWarningDialog(
              onWarningPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              translationsWarningButton: locale[TranslationsKeys.discard]!,
              translationsTitle: locale[TranslationsKeys.discardYourNote]!,
              translationsCancelButton: locale[TranslationsKeys.cancel]!,
            );
          },
        );
        return true;
      }
    }

    print("get_Priority = $get_priority");
    return WillPopScope(
      onWillPop: onPop,
      child: Directionality(
        textDirection: isRtlTextDirection(requiredData.isRtl!),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: onPop,
              icon: IsRtlBackIcon(isRtl: isRtl),
            ),
            title: Text(locale[TranslationsKeys.title]!),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () async {
                      if (titleController.text.isNotEmpty ||
                          noteTextController.text.isNotEmpty) {
                        if (idOfNote == null) {
                          var newNote = Note()
                            ..title = titleController.text
                            ..isTitleRtl = isRTL(
                                titleController.text.isEmpty
                                    ? ""
                                    : titleController.text[0],
                                isRtl)
                            ..date = DateTime.now()
                            ..priority = get_priority
                            ..content = noteTextController.text
                            ..isContentRtl = isRTL(
                                noteTextController.text.isEmpty
                                    ? ""
                                    : noteTextController.text[0],
                                isRtl)
                            ..parentFolderId = parentFolderId;

                          db.saveNote(newNote);
                          provider.addNote(newNote);
                        } else {
                          var oldNote = await db.getNote(idOfNote!);
                          oldNote!.title = titleController.text;
                          oldNote.date = DateTime.now();
                          oldNote.content = noteTextController.text;
                          oldNote.priority = get_priority;
                          db.updateNote(oldNote);
                          provider.updateNote(oldNote);
                          isPriorityPageOpened == true
                              ? await context
                                  .read<PriorityProvider>()
                                  .updateNote(oldNote)
                              : null;
                        }

                        Navigator.pop(context);
                      } else {
                        onPop();
                      }
                    },
                    icon: const Icon(Icons.save_rounded)),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)),
                      child: PriorityMenu(
                        priority: priority,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formatDate(DateTime.now(), [
                          yyyy,
                          "-",
                          mm,
                          "-",
                          dd,
                          "   ",
                          hh,
                          ":",
                          nn
                        ]).toString(),
                        style: MediumText(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black12,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AutoDirectionTextField(
                      controller: titleController,
                      locale: locale,
                      isUnderLinedBorder: false,
                      hintText: TranslationsKeys.yourTitle,
                    )),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.all(5),
                    child: ListView(children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoDirectionTextField(
                            controller: noteTextController,
                            locale: locale,
                            hintText: TranslationsKeys.yourNote,
                            maxLines: null,
                            isUnderLinedBorder: false,
                          )),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
