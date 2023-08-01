import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:note_filest1/translations/locale_keys.g.dart';

class FolderNameDialog extends StatelessWidget {
  //final bool isDark;
  final Function onSubmit;

  FolderNameDialog({super.key, /*required this.isDark,*/ required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onSubmitted: (value) {
                      onSubmit();
                    },
                    decoration: InputDecoration(
                        hintText: LocaleKeys.folderName.tr(),
                        border: const UnderlineInputBorder(),
                        filled: true,
                        //fillColor:  isDark == true ? Colors.black12 : null
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () {
                  /*TODO */
                  Navigator.pop(context);
                },
                child:  Text(LocaleKeys.done,
                  style: TextStyle(
                 // color: isDark ?Theme.of(context).primaryColor : Colors.black,
                 // fontFamily: "Cairo"
                    fontSize: 15
               ),
              ).tr(),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        )
    );
  }
}
