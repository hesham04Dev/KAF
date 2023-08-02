import 'dart:async';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'collection/Folder.dart';
import 'collection/Note.dart';
import 'collection/Setting.dart';

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

  Future<List<Folder>> getAllSubFolders(int parentId) async {
    final isar = await db;
    return await isar.folders.filter().parentEqualTo(parentId).findAll();
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
    await isar.folders.put(oldFolder!);
  }

  Future<void> deleteFolder(int folderId) async {
    final isar = await db;
    isar.folders.delete(folderId);
    isar.notes.filter().parentFolderIdEqualTo(folderId).deleteAll();
  }

  Future<void> saveNote(Note newNote) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.notes.putSync(newNote));
  }

  Future<List<Note>> getAllHomePageNotes() async {
    final isar = await db;
    return await isar.notes.filter().parentFolderIdIsNull().findAll();
  }

  Future<List<Note>> getAllSubNotes(int parentFolderId) async {
    final isar = await db;
    return await isar.notes
        .filter()
        .parentFolderIdEqualTo(parentFolderId)
        .findAll();
  }

  Future<void> deleteNote(int noteId) async {
    final isar = await db;
    isar.folders.delete(noteId);
  }

  Future<void> updateNote(Note updatedNote) async {
    final isar = await db;
    final oldNote = await isar.notes.get(updatedNote.id);
    oldNote!.title = updatedNote.title;
    oldNote!.content = updatedNote.content;
    await isar.notes.put(oldNote!);
  }

  Future<void> saveSetting(Setting newSetting) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.settings.putSync(newSetting));
  }
  Future<Setting?> getSetting(int SettingId) async {
    final isar = await db;
    return await isar.settings.filter().idEqualTo(SettingId).findFirst();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationSupportDirectory();
      return await Isar.open(
        [FolderSchema, NoteSchema, SettingSchema],
        directory: dir.path,
        inspector: true, /*TODO make it false after end*/
      );
    }

    return Future.value(Isar.getInstance());
  }
}
