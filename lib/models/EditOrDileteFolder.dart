import 'package:flutter/material.dart';

import 'FolderNameDialog.dart';
import 'styles.dart';

class EditOrDeleteFolder extends StatelessWidget {
  bool isDark;
  Function onSubmitNewName;
  Function onDelete;

   EditOrDeleteFolder({super.key,required this.isDark, required this.onSubmitNewName,required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(onPressed: (){

            Navigator.pop(context);
            showDialog(context: context, builder:(context) => FolderNameDialog(isDark: isDark,onSubmit: (){onSubmitNewName();},));

          }, child: const SizedBox(
              width:double.infinity ,
              child: Center(child: Text("edit",style: MediumText(),)))),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(onPressed: (){
            onDelete();
            Navigator.pop(context);
          }, child: const SizedBox(
              width: double.infinity,
              child: Center(
                child: Text("delete",style: TextStyle(
                    color: Colors.red,
                    fontSize: 19
                ),),
              ))),
        ),
      ],
    );
  }
}
