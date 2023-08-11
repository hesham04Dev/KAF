import 'package:flutter/material.dart';
import 'package:note_files/models/styles.dart';


import '../translations/translations.dart';
import '../screens/editNote.dart';
class PriorityMenu extends StatefulWidget {

  PriorityMenu({super.key});

  @override
  State<PriorityMenu> createState() => _PriorityMenuState();
}

class _PriorityMenuState extends State<PriorityMenu> {


  @override
  Widget build(BuildContext context) {

    return PopupMenuButton(

      child: Text("priority: $priority",style: MediumText(),),
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
    );
  }
}
