import 'dart:io';

import 'package:note_files/collection/isarCURD.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequiredData {
  RequiredData() {


  }
  final IsarService _db = IsarService();
  final Future<SharedPreferences> prefs =  SharedPreferences.getInstance();
  bool _isRtl = false;
  bool restoreDb= false;
  Map<String, String> _locale = {};
  bool isDbRestored =false;
  late bool _isAmiri ;
  Future<bool> getDefaultFont() async{
    final _prefs = await prefs;
    _isAmiri =  _prefs.getBool("isAmiri") ?? false;
    print(" is Amiri stored $_isAmiri");
    return Future.value(_isAmiri);
  }
  Future<void> setDefaultFont() async{
    final _prefs = await prefs;
    _prefs.setBool("isAmiri", _isAmiri);



  }
  get isAmiri => _isAmiri;
  set set_isAmiri (bool value) {
    _isAmiri = value;
    /*TODO store it in the db*/
  }
  set set_isRtl(bool value) {
    _isRtl = value;
  }

  get isRtl => _isRtl;

  get db => _db;
/*
  get priority => _priority;
  set set_priority (int value) => _priority = value;*/

  get locale => _locale;
  set set_locale(Map<String, String> value) {
    _locale = value;
  }
/*
  static const searchingList = ["title contains", "content contains","date is"];
  String _chosenElement = searchingList[0];
  get chosenElement => _chosenElement;
  set set_chosenElement (String value) {
    _chosenElement = value;}/*TODO remove this block*/*/



}

RequiredData requiredData = RequiredData();
