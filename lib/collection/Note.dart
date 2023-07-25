import 'package:isar/isar.dart';

import 'Folder.dart';

part 'Note.g.dart';



@collection
class Note {
  Id id = Isar.autoIncrement;
  late DateTime? date;
  late String? title;
  late String? content;
  final parentFolder = IsarLink<Folder>();
}