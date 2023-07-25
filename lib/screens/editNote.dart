import 'package:auto_direction/auto_direction.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note_filest1/models/styles.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key});

  static String routeName = "EditNote";

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  String titleOfNote = "";
  String noteText = "";

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as List<bool>;
    bool isDark =routeArgs[0];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            /*TODO if there is data show dialog ask the user if he need to return without save*/
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title:  Center(
            child: Text(
                formatDate(DateTime.now(), [
                  yy,
                  "/",
                  mm,
                  "/",
                  dd,
                  "   ",
                  hh,
                  ":",
                  mm
                ]).toString(),
                style: const SmallText())),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {}, icon: const Icon(Icons.save_rounded)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: isDark == true ? Colors.white10:Colors.grey[300], borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: " Your Title", ),
                    style: MediumText(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoDirection(
                    text: noteText,
                    child: const TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: 20,
                      autocorrect: true,
                      style: MediumText(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Your note",
                      ),
                    ),
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
