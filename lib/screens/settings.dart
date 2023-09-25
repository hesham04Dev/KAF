

import 'package:flutter/material.dart';
import 'package:note_files/requiredData.dart';

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
           )
          ],),
      ),
    );
    
  }
}
