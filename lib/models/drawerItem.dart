import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final page;
  final String text;
  const DrawerItem({super.key, required this.page, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                 page,));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text ),
            )),
        SizedBox(height: 10,)
      ],
    );
  }
}
