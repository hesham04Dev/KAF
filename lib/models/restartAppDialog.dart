
import 'package:flutter/material.dart';
import 'package:note_files/requiredData.dart';

import '../translations/translations.dart';

class RestartAppDialog extends StatelessWidget {
   RestartAppDialog({super.key});
  final Map<String,String> locale = requiredData.locale;
  @override
  Widget build(BuildContext context) {
   return   Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(locale[TranslationsKeys.restartAppMsg]!,textAlign: TextAlign.center,),
          ),
        );
  }
}
