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

class EditNote extends StatefulWidget {
  final int? parentFolderId;

  /// these arguments fore using this page to edit the note
  final String? oldTitle;
  final String? oldContent;
  final int? idOfNote;
  final int? priority;

  final bool? isPriorityPageOpened;

  EditNote(
      {super.key,
      this.priority,
      this.isPriorityPageOpened,
      this.idOfNote,
      this.oldTitle,
      this.oldContent,
      this.parentFolderId});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> with WidgetsBindingObserver {
  final Map<String, String> locale = requiredData.locale;

  final IsarService db = requiredData.db;

  final bool isRtl = requiredData.isRtl;

  final titleController = TextEditingController();

  final noteTextController = TextEditingController();

  bool isLoaded = false;
  late int get_priority;
  late ListViewProvider provider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void save() async {
    if (titleController.text.isNotEmpty || noteTextController.text.isNotEmpty) {
      if (widget.idOfNote == null) {
        var newNote = Note()
          ..title = titleController.text
          ..isTitleRtl = isRTL(
              titleController.text.isEmpty ? "" : titleController.text[0],
              isRtl)
          ..date = DateTime.now()
          ..priority = get_priority
          ..content = noteTextController.text
          ..isContentRtl = isRTL(
              noteTextController.text.isEmpty ? "" : noteTextController.text[0],
              isRtl)
          ..parentFolderId = widget.parentFolderId;

        db.saveNote(newNote);
        provider.addNote(newNote);
      } else {
        var oldNote = await db.getNote(widget.idOfNote!);
        oldNote!.title = titleController.text;
        oldNote.date = DateTime.now();
        oldNote.content = noteTextController.text;
        oldNote.priority = get_priority;
        db.updateNote(oldNote);
        provider.updateNote(oldNote);
        if (widget.isPriorityPageOpened == true) {
          await context.read<PriorityProvider>().updateNote(oldNote);
        }
      }

      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    get_priority = context.watch<PriorityProvider>().priority;

    if (!isLoaded && widget.priority != null) {
      print("priority is ${widget.priority}");
      isLoaded = true;
      get_priority = widget.priority!;
    }
    ;
    provider = Provider.of<ListViewProvider>(context, listen: false);

    /// oldTitle and oldContent are the text written in the note
    widget.oldTitle == null ? null : titleController.text = widget.oldTitle!;
    widget.oldContent == null
        ? null
        : noteTextController.text = widget.oldContent!;

    /// by doing that we put the old text in the TextFormField
    Future<bool> onPop() async {
      if (titleController.text.isEmpty && noteTextController.text.isEmpty) {
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
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        onPop();
      },
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
                    onPressed: save, icon: const Icon(Icons.save_rounded)),
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
                          borderRadius: BorderRadius.circular(50)),
                      child: PriorityMenu(
                        priority: widget.priority,
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

  @override
  void dispose() {
    print("Widget is being disposed");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      save();
      print("App is closing");
      // Add your cleanup code here
    }
  }
}
