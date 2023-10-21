import 'package:flutter/material.dart';


class SearchProvider with ChangeNotifier {

  String _chosenElement = "title contains";
  get chosenElement => _chosenElement;
  set set_chosenElement (var value) {
    notifyListeners();
    _chosenElement = value;}


}
