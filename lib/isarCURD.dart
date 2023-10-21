import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'collection/Folder.dart';
import 'collection/Note.dart';

class IsarService {
  late Future<Isar> db;
  final _supportDir = getApplicationSupportDirectory();
  final _tempDir = getTemporaryDirectory();
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

  Future<void> localBackup() async {
    final isar = await db;
    final downloadsDir = await _downloadsDir;
    /*TODO add time naming*/
    getApplicationSupportDirectory().then((value) => print(value.path));

    isar.copyToFile( await downloadsDir!.path + "/default.isar");
  }
  Future<void> copyDbToSupportDir(String sourcePath) async {
    var isar = await db;
    final supportDir = await _supportDir;
    if (isar.isOpen) {

      //var baseDir = await getDownloadsDirectory();
      File sourceFile = File(sourcePath);
      // TODO remove base dir and source file since we need to get it from the


      await sourceFile.copySync(supportDir.path + '/restored.isar');
      /* wee need to restart the app to get new db */

    }
  }
  Future<void> localRestoreDbIfRestoreButtonClicked() async{
    final supportDir = await _supportDir;
    File needToRestoreOldDb = File(supportDir.path + "/default.restore");
    File restoredDb = File(supportDir.path + "/restored.isar");
    if (await restoredDb.exists()) {
      _localRestoreNewDb(restoredDb);
    }else if(await needToRestoreOldDb.exists()){
      _localRestoreOldDb();
       needToRestoreOldDb.delete();
       /*This part done in the code but still not active since tell now we dont add
       * the code that will create the default.restore file */
    }
  }
  Future<void> _localRestoreNewDb(File restoredDb) async{
  final supportDir = await _supportDir;
  final temp = await _tempDir;

    File oldDb = File(supportDir.path + "/default.isar");
    await oldDb.copy(temp.path + "/default.isar");
    await oldDb.delete();

    restoredDb.rename(supportDir.path + "/default.isar");
  }

  Future<void> _localRestoreOldDb() async{
    final temp = await _tempDir;
    final supportDir = await _supportDir;

    File db = File(supportDir.path + "/default.isar");
    await db.delete();

    final oldDb = File(temp.path + "/default.isar");
    await oldDb.copy(supportDir.path + "/default.isar");
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationSupportDirectory();
      print(dir.path);
      /*File file= File(dir.path + "/default.isar");
      print(await file.exists());*/
      return await Isar.open(
        [FolderSchema, NoteSchema],
        directory: dir.path,
        inspector: true,
      );
    } else
      print("instance is not empty");

    return Future.value(Isar.getInstance());
  }
}
