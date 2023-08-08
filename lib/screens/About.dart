import 'package:flutter/material.dart';
import '../functions/isRtlTextDirection.dart';
import '../models/MultiLineText.dart';

import '../translations/translations.dart';

class AboutPage extends StatelessWidget {
  final Map<String, String> locale;
  final bool isRtl;

  const AboutPage({super.key, required this.locale, required this.isRtl});

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
