import 'package:flutter/material.dart';
import 'package:note_files/collection/isarCURD.dart';
import 'package:note_files/requiredData.dart';
import 'package:note_files/homePageData.dart';

import '../collection/Folder.dart';
import '../collection/Note.dart';

enum ListScreenState {
  initial,
  loaded,
  updated,
  updatedFolders,
  updatedNotes,
  addFolder,
  removeFolder,
  addNote,
  removeNote
}

class ListViewProvider with ChangeNotifier {
  final IsarService db = requiredData.db;

  ListScreenState state = ListScreenState.initial;
  List<Folder> _listFolders = homePageFolders;
  List<Note> _listNotes = homePageNotes;

  List<Folder> get listFolders => _listFolders;

  List<Note> get listNotes => _listNotes;
  int? _parentId;
  getFoldersAndNotes(int? parentId) async {
    _parentId = parentId;
    //print(state);
    _listFolders =
        parentId == null ? homePageFolders : await db.getFolders(parentId);
    _listNotes = parentId == null ? homePageNotes : await db.getNotes(parentId);
    state = parentId == null ? ListScreenState.loaded : ListScreenState.updated;
    notifyListeners();
    //print(state);
  }

  addFolder(Folder folder) async {
    _parentId == null ? homePageFolders.add(folder) : _listFolders.add(folder);
    state = ListScreenState.addFolder;
    notifyListeners();
  }

  deleteFolder(Folder folder) async {
    _parentId == null
        ? homePageFolders
            .removeWhere((getedFolder) => getedFolder.id == folder.id)
        : _listFolders
            .removeWhere((getedFolder) => getedFolder.id == folder.id);
    state = ListScreenState.removeFolder;
    //print("deleteFolder called");
    notifyListeners();
  }

  updateFolders(Folder folder) async {
    //_listFolders = await db.getFolders(_parentId);
    //_parentId == null ? homePageFolders[_listFolders.indexWhere((Folder) => Folder.id == folder.id)] = folder:_listFolders[_listFolders.indexWhere((Folder) => Folder.id == folder.id)] = folder;

    homePageFolders = await db.getFolders(null);
    _listFolders = await db.getFolders(null);
    //??
    state = ListScreenState.updatedFolders;
    notifyListeners();
  }

  addNote(Note note) async {
    _parentId == null ? homePageNotes.add(note) : _listNotes.add(note);
    state = ListScreenState.addNote;
    notifyListeners();
  }

  deleteNote(int noteId) async {
    _parentId == null
        ? homePageNotes.removeWhere((getedNote) => getedNote.id == noteId)
        : _listNotes.removeWhere((getedNote) => getedNote.id == noteId);
    //print("note removed");
    state = ListScreenState.removeNote;
    notifyListeners();
  }

  updateNote(Note note) {
    _parentId == null
        ? homePageNotes[homePageNotes
            .indexWhere((getedNote) => getedNote.id == note.id)] = note
        : _listNotes[_listNotes
            .indexWhere((getedNote) => getedNote.id == note.id)] = note;
    state = ListScreenState.updatedNotes;
    notifyListeners();
  }
}
