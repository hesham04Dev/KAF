import 'package:note_files/isarCURD.dart';

class RequiredData{
  final IsarService _db =IsarService();
  bool _isRtl =false;
  Map<String, String> _locale = {};

  set set_isRtl(bool value) {_isRtl = value;}
  get isRtl => _isRtl;

  get db => _db;

  get locale => _locale;
  set set_locale(Map<String,String> value) {_locale = value;}
}
RequiredData requiredData = RequiredData();
