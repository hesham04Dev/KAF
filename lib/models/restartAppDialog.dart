
import 'package:flutter/material.dart';
import 'package:note_files/requiredData.dart';

import '../translations/translations.dart';

class RestartAppDialog extends StatelessWidget {
   RestartAppDialog({super.key});
  final Map<String,String> locale = requiredData.locale;
  @override
  Widget build(BuildContext context) {
   return   Dialog.fullscreen(
          child: Center(
            child:
            Text(locale[TranslationsKeys.restartAppMsg]!),
          ),
        );
  }
}
