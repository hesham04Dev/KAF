import 'package:note_files/isarCURD.dart';

class RequiredData {
  final IsarService _db = IsarService();
  bool _isRtl = false;
  Map<String, String> _locale = {};
  int _priority = 1;
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
}

RequiredData requiredData = RequiredData();
