import 'package:flutter/material.dart';

import 'EditOrDileteFolder.dart';

class FolderButton extends StatelessWidget {
  final bool isDark;
  final Widget child;
   FolderButton({super.key, required this.isDark,required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onLongPress: (){
      showModalBottomSheet(context: context, builder: (context){
        return EditOrDeleteFolder(/*isDark: isDark,*/onDelete: (){/*TODO*/},onSubmitNewName: (){/*TODO*/},);
      });
    },
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20)),
    onPressed: () {
    //TODO open the page of this folder that can contains files and folders
    // TODO open the page of the note allow to edit it and show the count of the words
    },
    child: child);
  }
}
