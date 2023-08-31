import 'package:flutter/material.dart';
import 'package:note_files/requiredData.dart';
import '../functions/isRtlTextDirection.dart';
import '../models/MultiLineText.dart';

import '../translations/translations.dart';

class AboutPage extends StatelessWidget {
  final Map<String, String> locale = requiredData.locale;
  final bool isRtl = requiredData.isRtl;

   AboutPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
          title: Text(locale[TranslationsKeys.title]!)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            MultiLineText(
                margin: 40,
                fontSize: 18,
                maxLines: 1000,
                text: locale[TranslationsKeys.aboutContent]!,
                textDirection: isRtlTextDirection(isRtl)),
          ],
        ),
      ),
    );
  }
}
