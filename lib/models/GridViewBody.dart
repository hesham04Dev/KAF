import 'package:flutter/material.dart';

import 'FolderButton.dart';

class GridViewBody extends StatelessWidget {
  final db;
  final isRtl;
  final locale;
  final isDark;
  const GridViewBody({super.key,required this.db,required this.isRtl,required this.isDark,required this.locale});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return FolderButton(
              parentFolderId: 0,
              id: 0,
              /*TODO get it from index from the data getted*/
              db: db,
              isRtl: isRtl,
              locale: locale,
              isDark: isDark,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.folder_rounded,
                      size: 50,
                      // color: Theme.of(context).colorScheme.primary
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FittedBox(
                      child: Text(
                        "hello",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ));
        },
        separatorBuilder: (context, index) =>
        const Divider(color: Colors.white54),
        itemCount: 20 /*listLength*/,
      ),
    );
  }
}
