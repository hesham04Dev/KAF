
import 'package:date_format/date_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:note_filest1/models/DiscardNoteDialog.dart';
import 'package:note_filest1/models/styles.dart';

import '../translations/locale_keys.g.dart';
import '../models/AutoDirection.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key});

  static String routeName = "EditNote";

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  var titleController = TextEditingController();
  var noteTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as List<bool>;
    bool isDark = routeArgs[0];
    print(formatDate(DateTime.now(), [yy, "/", mm, "/", dd, "   ", hh, ":", nn])
        .toString(),);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DiscardNoteDialog(isDark:isDark);
              },
            );
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
            formatDate(DateTime.now(), [yy, "/", mm, "/", dd, "   ", hh, ":", nn])
                .toString(),

         // style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //TODO SAVE THE DATA IN DB
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
                            return LocaleKeys.titleError.tr();
                          }
                          return null;
                        },
                        decoration:  InputDecoration(
                          hintText: LocaleKeys.yourTitle.tr(),
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
                            return LocaleKeys.noteError.tr();
                          }
                          return null;
                        },
                        controller: noteTextController,
                        autocorrect: true,
                        style: const MediumText(),
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                          hintText: LocaleKeys.yourNote.tr(),
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
