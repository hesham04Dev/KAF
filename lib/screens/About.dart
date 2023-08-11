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
      appBar: AppBar(title: Text(locale[TranslationsKeys.title]!)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            MultiLineText(
                margin: 40,
                fontSize: 18,
                maxLines: 10,
                text: locale[TranslationsKeys.aboutContent]!,
                textDirection: isRtlTextDirection(isRtl)),
          ],
        ),
      ),
    );
  }
}
