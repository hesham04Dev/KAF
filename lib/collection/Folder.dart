import 'package:isar/isar.dart';
part 'Folder.g.dart';

@collection
class Folder {
  Id id = Isar.autoIncrement;
  String? name;
  int? parent;
}
