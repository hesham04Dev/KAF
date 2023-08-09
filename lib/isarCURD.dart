import 'dart:async';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'collection/Folder.dart';
import 'collection/Note.dart';


class IsarService {
  late Future<Isar> db;

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
  Future<Folder?> getFolder(int FolderId) async {
    final isar = await db;
    return await isar.folders.filter().idEqualTo(FolderId).findFirst();
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
    isar.writeTxn(() =>  isar.folders.put(oldFolder));

  }

  Future<void> deleteFolder(int folderId) async {
    final isar = await db;
    await isar.writeTxn(() =>  isar.folders.delete(folderId));
    await isar.writeTxnSync(()  =>  isar.notes.filter().parentFolderIdEqualTo(folderId).deleteAllSync());
   await isar.writeTxnSync(() => isar.folders.filter().parentEqualTo(folderId).deleteAllSync(),);
   print("delete folder is done");
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
  Future<Note?> getNote(int NoteId) async {
    final isar = await db;
    return await isar.notes.filter().idEqualTo(NoteId).findFirst();
  }
  Future<void> deleteNote(int noteId) async {
    final isar = await db;
    isar.writeTxn<bool>(() =>isar.notes.delete(noteId));
  }

  Future<void> updateNote(Note updatedNote) async {
    final isar = await db;
    final oldNote = await isar.notes.get(updatedNote.id);
    oldNote!.title = updatedNote.title;
    oldNote.content = updatedNote.content;
    isar.writeTxn(() =>  isar.notes.put(oldNote));
  }



  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationSupportDirectory();
      return await Isar.open(
        [FolderSchema, NoteSchema],
        directory: dir.path,
        inspector: true, /*TODO make it false after end*/
      );
    }

    return Future.value(Isar.getInstance());
  }
}
