import 'package:isar/isar.dart';

part 'Note.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;
  late DateTime? date;
  late String? title;
  late bool? isTitleRtl;
  late String? content;
  late bool? isContentRtl;
  late int? parentFolderId;
  late bool? isDone; //  null is not a task 0 is not done 1 is done
  late int? priority;
}
