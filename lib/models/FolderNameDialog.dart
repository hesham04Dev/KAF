import 'package:flutter/material.dart';

class FolderNameDialog extends StatelessWidget {
  bool isDark;
  Function onSubmit;

  FolderNameDialog({super.key, required this.isDark, required this.onSubmit});

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
                        hintText: " Folder Name",
                        border: const UnderlineInputBorder(),
                        filled: true,
                        fillColor:
                            isDark == true ? Colors.black12 : Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () {
                  /*TODO */
                  Navigator.pop(context);
                },
                child: const Text('done'),
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
