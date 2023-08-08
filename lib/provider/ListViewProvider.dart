import 'package:flutter/material.dart';
import 'package:note_files/isarCURD.dart';
import 'package:note_files/requiredData.dart';
import 'package:note_files/homePageData.dart';

import '../collection/Folder.dart';
import '../collection/Note.dart';

enum listScreenState { initial, loaded,updated, updatedFolders, updatedNotes, addFolder, removeFolder, addNote,removeNote }

class ListViewProvider with ChangeNotifier {
  final IsarService db = requiredData.db;



  listScreenState state = listScreenState.initial;
  List<Folder> _listFolders = homePageFolders;
  List<Note> _listNotes = homePageNotes;

  List<Folder> get listFolders => [..._listFolders];

  List<Note> get listNotes => [..._listNotes];
  int? _parentId;
  getFoldersAndNotes(int? parentId) async {
    _parentId = parentId;
    print(state);
    _listFolders = parentId == null? homePageFolders: await db.getFolders(parentId);
    _listNotes = parentId == null? homePageNotes: await db.getNotes(parentId);
    state =parentId == null? listScreenState.loaded  :listScreenState.updated;
    notifyListeners();
    print(state);
  }

  addFolder(Folder folder) async {
    //_listFolders = await db.getAllHomePageFolders();


    _parentId == null ? homePageFolders.add(folder) :_listFolders.add(folder);
    state = listScreenState.addFolder;
    notifyListeners();
  }

  deleteFolder(Folder folder) async {
    _parentId == null ? homePageFolders.removeWhere((Folder) => Folder.id == folder.id) :_listFolders.removeWhere((Folder) => Folder.id == folder.id);
    state = listScreenState.removeFolder;
    print("deleteFolder called");
    notifyListeners();
  }
  updateFolders(Folder folder) async {
    //_listFolders = await db.getFolders(_parentId);
    //_parentId == null ? homePageFolders[_listFolders.indexWhere((Folder) => Folder.id == folder.id)] = folder:_listFolders[_listFolders.indexWhere((Folder) => Folder.id == folder.id)] = folder;

    homePageFolders =  await db.getFolders(null);
    _listFolders = await db.getFolders(null);
    state = listScreenState.updatedFolders;
    notifyListeners();
  }

  addNote(Note note) async {
    _parentId ==null ? homePageNotes.add(note): _listNotes.add(note);
    state = listScreenState.addNote;
    notifyListeners();
  }

  deleteNote(int noteId) async {
    _parentId == null ? homePageNotes.removeWhere((Note) => Note.id == noteId):_listNotes.removeWhere((Note) => Note.id == noteId);
    print("note removed");
    state = listScreenState.removeNote;
    notifyListeners();
  }
  updateNote(Note note) async {
    _parentId == null ? homePageNotes[homePageNotes.indexWhere((Note) => Note.id == note.id)] = note:_listNotes[_listNotes.indexWhere((Note) => Note.id == note.id)] = note;
    state = listScreenState.updatedNotes;
    notifyListeners();
  }

}
