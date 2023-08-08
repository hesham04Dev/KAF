import 'package:flutter/material.dart';
import 'package:note_files/isarCURD.dart';

import '../collection/Folder.dart';
import '../collection/Note.dart';

enum listScreenState { initial, loaded,updated, updatedFolders, updatedNotes, addFolder, removeFolder, addNote,removeNote }

class ListViewProvider with ChangeNotifier {
  final IsarService db;

  ListViewProvider({required this.db});

  listScreenState state = listScreenState.initial;
  List<Folder> _listFolders = [];
  List<Note> _listNotes = [];

  List<Folder> get listFolders => [..._listFolders];

  List<Note> get listNotes => [..._listNotes];

  getFoldersAndNotes(int? parentId) async {
    print(state);
    _listFolders = await db.getFolders(parentId);
    _listNotes = await db.getNotes(parentId);
    state =parentId == null? listScreenState.loaded  :listScreenState.updated;
    notifyListeners();
    print(state);
  }

  addFolder(Folder folder) async {
    //_listFolders = await db.getAllHomePageFolders();
    _listFolders!.add(folder);
    state = listScreenState.addFolder;
    notifyListeners();
  }

  deleteFolder(Folder folder) async {
    _listFolders.remove(folder);
    state = listScreenState.removeFolder;
    print("deleteFolder called");
    notifyListeners();
  }
  updateFolders(int? parentId) async {
    _listFolders = await db.getFolders(parentId);
    state = listScreenState.updatedFolders;
    notifyListeners();
  }

  addNote(Note note) async {
    _listNotes.add(note);
    state = listScreenState.addNote;
    notifyListeners();
  }

  deleteNote(Note note) async {
    _listNotes.remove(note);
    print("note removed");
    state = listScreenState.removeNote;
    notifyListeners();
  }
  updateNotes() async {
    _listNotes = await db.getAllHomePageNotes();
    state = listScreenState.updatedNotes;
    notifyListeners();
  }

}
