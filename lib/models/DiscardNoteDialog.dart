import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../translations/locale_keys.g.dart';
import 'styles.dart';

class DiscardNoteDialog extends StatelessWidget {
  final bool isDark;
  const DiscardNoteDialog({super.key ,required this.isDark});

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
           Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(LocaleKeys.discardYourNote, style: MediumText()).tr(),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      LocaleKeys.discard,
                      style: TextStyle(
                          color: Colors.red, fontSize: 19),
                    ).tr()),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child:  Text(
                      LocaleKeys.cancel,
                      style: TextStyle(
                          color: isDark ?Theme.of(context).primaryColor :Colors.black
                      ),
                    ).tr())
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
