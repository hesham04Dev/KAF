
import 'package:flutter/material.dart';
import 'package:note_files/models/AutoDirectionTextFormField.dart';
import 'package:note_files/models/popupMenu.dart';
import 'package:note_files/provider/searchProvider.dart';
import 'package:note_files/requiredData.dart';
import 'package:provider/provider.dart';

import '../translations/translations.dart';

class SearchPage extends StatelessWidget {
   SearchPage({super.key});
  final Map<String, String> locale = requiredData.locale;
   static const searchingList = ["title contains", "content contains","date is"];
  var searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(locale[TranslationsKeys.search]!),

      ),
      body: ListView(
        children: [
          Form(child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                MyPopUpMenu(initialText: context.watch<SearchProvider>().chosenElement, popList:searchingList ),
                context.read<SearchProvider>().chosenElement == searchingList[2] ? DatePickerDialog(initialDate: DateTime.now(),  lastDate: DateTime.now(), firstDate: DateTime(2023),) : SizedBox(),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    context.read<SearchProvider>().chosenElement == searchingList[2] ?SizedBox(): Flexible(child:AutoDirectionTextFormField(
                      controller: searchController,
                      locale: locale,
                      errMessage: "please enter something"/*TODO add to localization*/,
                      hintText: context.read<SearchProvider>().chosenElement == searchingList[0] ? "title contains" : "content contains" /*TODO add to localization*/), ),
                  MaterialButton(onPressed: (){},child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("search"),

                  ),),
                  SizedBox(width: 10,),

                ],),

              ],
            ),
          ))
        ],
      ),
    );
  }
}
