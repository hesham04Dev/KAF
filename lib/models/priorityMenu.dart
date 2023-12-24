import 'package:flutter/material.dart';
import 'package:note_files/models/styles.dart';
import 'package:note_files/requiredData.dart';
import 'package:provider/provider.dart';

import '../provider/PriorityProvider.dart';
import '../translations/translations.dart';

class PriorityMenu extends StatefulWidget {
  final int? priority;
  const PriorityMenu({
    this.priority,
    super.key,
  });

  @override
  State<PriorityMenu> createState() => _PriorityMenuState();
}

class _PriorityMenuState extends State<PriorityMenu> {
  Map<String, String> locale = requiredData.locale;
  int getPriority = 1;
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.priority == null) {
      print("is null in pm");
      getPriority = context.read<PriorityProvider>().priority;
    } else if (!isLoaded) {
      getPriority = widget.priority!;
      isLoaded = true;
    }
    print("priority:  ${getPriority}");

    return PopupMenuButton(
      elevation: 0,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            width: 0,
          )),
      child: Text(
        "${locale[TranslationsKeys.priority]!}: ${getPriority}",
        style: const MediumText(),
      ),
      onSelected: (value) {
        //print(value);
        getPriority = value;
        context.read<PriorityProvider>().set_priority = value;
        setState(() {});
        //print(value);
      },
      itemBuilder: (BuildContext context) => List.generate(
        10,
        (index) => PopupMenuItem(
          value: index + 1,
          child: Center(
              child: Text(
            "${locale[TranslationsKeys.priority]} ${index + 1}",
          )),
        ),
      ),
    );
  }
}
