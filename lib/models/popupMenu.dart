import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/searchProvider.dart';

class MyPopUpMenu extends StatefulWidget {
  String initialText;
  final List<String> popList;

  MyPopUpMenu({super.key, required this.initialText, required this.popList});

  @override
  State<MyPopUpMenu> createState() => _MyPopUpMenuState();
}

class _MyPopUpMenuState extends State<MyPopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          widget.initialText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      onSelected: (value) {
        widget.initialText = value.toString();
        context.read<SearchProvider>().set_chosenElement =value.toString();
        setState(() {});
      },
      itemBuilder: (BuildContext context) => List.generate(
        widget.popList.length,
        (index) => PopupMenuItem(
          value: widget.popList[index],
          child: Center(
              child: Text(
            widget.popList[index],
          )),
        ),
      ),
    );
    ;
  }
}
