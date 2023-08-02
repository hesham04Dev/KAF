import 'package:flutter/material.dart';

import 'FolderButton.dart';

class ListViewBody extends StatelessWidget {
  final db;
  final isRtl;
  final locale;
  final isDark;
  const ListViewBody({super.key,required this.db,required this.isRtl,required this.isDark,required this.locale});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            childAspectRatio: 1.2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return FolderButton(
            id: 0 /*TODO get it from index data getted*/,
            parentFolderId: 0,
            db: db,
            isRtl:isRtl,
            locale: locale,
            isDark: isDark,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.folder_rounded,
                  size: 70,
                  //color: Theme.of(context).colorScheme.primary
                ),
                const SizedBox(
                  height: 5,
                ),
                const FittedBox(child: Text("data is long text"))
              ],
            ),
          );
        },
        itemCount: 50,
      ),
    );
  }
}
