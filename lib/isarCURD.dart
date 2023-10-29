import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:isar/isar.dart';
import 'package:note_files/functions/restoreDb.dart';
import 'package:path_provider/path_provider.dart';

import 'collection/Folder.dart';
import 'collection/Note.dart';

class IsarService {
  late Future<Isar> db;
  final _supportDir = getApplicationSupportDirectory();
  final _downloadsDir = getDownloadsDirectory();

  IsarService() {
    db = openDB();
  }

  Future<void> saveFolder(Folder newFolder) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.folders.putSync(newFolder));
  }

  Future<List<Folder>> getAllHomePageFolders() async {
    final isar = await db;
    return await isar.folders.filter().parentIsNull().findAll();
  }

  Future<List<Folder>> getFolders(int? parentId) async {
    final isar = await db;
    return await isar.folders.filter().parentEqualTo(parentId).findAll();
  }

  Future<Folder?> getFolder(int folderId) async {
    final isar = await db;
    return await isar.folders.filter().idEqualTo(folderId).findFirst();
  }

  Stream<List<Folder>> listenToFolders() async* {
    final isar = await db;
    yield* isar.folders.where().watch();
  }

  Future<void> updateFolder(Folder updatedFolder) async {
    final isar = await db;
    final oldFolder = await isar.folders.get(updatedFolder.id);
    //oldFolder!.parent = updatedFolder.parent;
    /*the above is not nesscary since the user cant move the folder right now*/
    oldFolder!.name = updatedFolder.name;
    isar.writeTxn(() => isar.folders.put(oldFolder));
  }

  Future<void> deleteFolder(int folderId) async {
    final isar = await db;
    // this for delete the main folder
    await isar.writeTxn(() => isar.folders.delete(folderId));
    //this for delete the notes inside the main folder whose folder id passed as argument
    isar.writeTxnSync(() =>
        isar.notes.filter().parentFolderIdEqualTo(folderId).deleteAllSync());

    //this for repeat this fn for all folders inside this folder
    List<Folder> allFoldersInThisFolder =
        await isar.folders.filter().parentEqualTo(folderId).findAll();
    for (int i = 0; i < allFoldersInThisFolder.length; i++) {
      deleteFolder(allFoldersInThisFolder[i].id);
    }
  }

  Future<void> saveNote(Note newNote) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.notes.putSync(newNote));
  }

  Future<List<Note>> getAllHomePageNotes() async {
    final isar = await db;
    return await isar.notes.filter().parentFolderIdIsNull().findAll();
  }

  Future<List<Note>> getNotes(int? parentFolderId) async {
    final isar = await db;
    return await isar.notes
        .filter()
        .parentFolderIdEqualTo(parentFolderId)
        .findAll();
  }

  Future<List<Note>> getNotesByPriority(int priority) async {
    final isar = await db;
    return await isar.notes.filter().priorityEqualTo(priority).findAll();
  }

  Future<Note?> getNote(int noteId) async {
    final isar = await db;
    return await isar.notes.filter().idEqualTo(noteId).findFirst();
  }

  Future<void> deleteNote(int noteId) async {
    final isar = await db;
    await isar.writeTxn<bool>(() => isar.notes.delete(noteId));
  }

  Future<void> updateNote(Note updatedNote) async {
    final isar = await db;

    final oldNote = await isar.notes.get(updatedNote.id);
    oldNote!.title = updatedNote.title;
    oldNote.content = updatedNote.content;
    oldNote.priority = updatedNote.priority;
    isar.writeTxn(() => isar.notes.put(oldNote));
  }

  Future<Note?> randomNote() async {
    final isar = await db;

    Note? note = await isar.notes.where().findFirst();
    if (note != null) {
      return await isar.notes
          .where()
          .findAll()
          .then((value) => value[Random().nextInt(value.length)]);
    } else {
      return null;
    }
  }

  Future<void> localBackup(bool isAndroid) async {
    final isar = await db;
    String pathToDownloadsDir;
    if(isAndroid) {
       pathToDownloadsDir = "/storage/emulated/0/Download";
    }else{
    final downloadsDir = await _downloadsDir;
     pathToDownloadsDir = downloadsDir!.path;}

    String date =formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd,]).toString();

    await deleteFileIfExists(pathToDownloadsDir +"/BackupDB_${date}.hcody");
    isar.copyToFile( pathToDownloadsDir + "/BackupDB_${date}.hcody");
  }

  Future<void> copyDbToSupportDir(String sourcePath) async {
    var isar = await db;
    final supportDir = await _supportDir;
    if (isar.isOpen) {
      File sourceFile = File(sourcePath);
      await sourceFile.copySync(supportDir.path + '/restored.isar');
      /* wee need to restart the app to get new db */
    }
  }


  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationSupportDirectory();
      print(dir.path);

      return await Isar.open(
        [FolderSchema, NoteSchema],
        directory: dir.path,
        inspector: false,
      );
    } else
      print("instance is not empty");

    return Future.value(Isar.getInstance());
  }
}
