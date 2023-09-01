import 'package:flutter/material.dart';
import 'package:note_files/models/styles.dart';
import 'package:note_files/requiredData.dart';


import '../translations/translations.dart';
import '../screens/EditNotePage.dart';
class PriorityMenu extends StatefulWidget {

  const PriorityMenu({super.key, });

  @override
  State<PriorityMenu> createState() => _PriorityMenuState();
}

class _PriorityMenuState extends State<PriorityMenu> {
  Map<String,String> locale = requiredData.locale;

  @override
  Widget build(BuildContext context) {

    return PopupMenuButton(

      child: Text("${locale[TranslationsKeys.priority]!}: $priority",style: const MediumText(),),
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
          child: Text("${locale[TranslationsKeys.priority]} ${index + 1}"),
        ),
      ),
    );
  }
}
