import 'package:isar/isar.dart';
part "Setting.g.dart";
@collection
class Setting {
  Id id = Isar.autoIncrement;
  String? name;
  String? value;
}