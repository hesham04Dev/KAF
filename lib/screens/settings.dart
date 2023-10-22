

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:note_files/requiredData.dart';

import 'package:path_provider/path_provider.dart';

import '../models/styles.dart';

class SettingsPage extends StatefulWidget {


   SettingsPage({super.key,});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}
const fonts =["Amiri","Noto"];
const ar_fonts =["اميري","نوتو"];
class _SettingsPageState extends State<SettingsPage> {
  bool isAmiri = requiredData.isAmiri;
  bool isArabic = requiredData.isRtl;
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Text("settings"),/*TODO transilation*/
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 50,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text("font family:",style: MediumText()),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextButton(onPressed: (){
                   if(isAmiri) isAmiri = false;
                   else isAmiri = true;
                   setState(() {

                   });
                 }, child: Text(isArabic ==true ? ar_fonts[isAmiri ?1:0]:fonts[isAmiri ? 1:0])),
               )

             ],
           ),
            Row(
              children: [
                TextButton(onPressed: () async{
                  //var allowStorage = await Permission.storage.request();
                  requiredData.db.backup();
                  /*if (allowStorage.isGranted) {
                        requiredData.db.backup();
                      // Permission granted, you can access the external storage.
                      } else {
                        print("99999999999999999");
                      // Permission denied.
                      }*/
                    /*TODO 1 add tost the file in the downloads*/
                    /*TODO 2 add permission */
                  Navigator.pop(context);
                }, child: Text("backup")),
                TextButton(onPressed: () async{
                  //var allowStorage = await Permission.storage.request();
                  var downloadsDir = await getDownloadsDirectory();
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    allowedExtensions: ['isar'],
                    initialDirectory: downloadsDir!.path,
                  );
                  if (result != null ) {
                    if(result.files.single.path!.endsWith(".isar")){
                    requiredData.db.copyDbToSupportDir(result.files.single.path);

                      /*TODO restart the app */
                      showDialog(context: context, builder: (context) => Dialog.fullscreen(
                        child: Center(child: Text("you need to restart the app"),),
                      ),);
                    }
                    else {
                      showDialog(context: context, builder: (context) => Dialog(
                        backgroundColor: Colors.red.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("wrong file",textAlign: TextAlign.center,),
                        ),
                      ),);

                    }


                    print("done");
                  } else {
                    // TODO
                    // User canceled the picker
                  }


                  /*TODO add the isGranted permission of the storage and rutern
                        err if he dont acsept the permission*/
                  /*if (allowStorage.isGranted) {
                        requiredData.db.backup();
                      // Permission granted, you can access the external storage.
                      } else {
                        print("99999999999999999");
                      // Permission denied.
                      }*/

                  //Navigator.pop(context);
                }, child: Text("restore")),
              ],
            )
          ],),
      ),
    );
    
  }
}
