import 'package:flutter/material.dart';
import 'package:note_files/isarCURD.dart';

import '../collection/Folder.dart';
import '../collection/Note.dart';

enum listScreenState { initial, loaded }

class ListViewProvider with ChangeNotifier {
  final IsarService db;

  ListViewProvider({required this.db});



  listScreenState state = listScreenState.initial;

  List<Folder>? _listFolders;
  List<Note>? _listNotes;

  List<Folder>? get listFolders => _listFolders;

  List<Note>? get listNotes => _listNotes;

  getFoldersAndNotes() async {
    _listFolders = await db.getAllHomePageFolders();
    _listNotes = await db.getAllHomePageNotes();
    state = listScreenState.loaded;
    notifyListeners();
  }
}
