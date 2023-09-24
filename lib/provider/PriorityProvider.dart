import 'package:flutter/material.dart';

import '../collection/Note.dart';
import '../requiredData.dart';

class PriorityProvider with ChangeNotifier {
  late List<Note> _listNotes;
  late int _priority =1;
  getNotesByPriority(priority) async {
    _priority = priority;
    return _listNotes = await requiredData.db.getNotesByPriority(priority);
  }
  get priority => _priority;
  set set_priority (int value) {
    notifyListeners();
    _priority = value;}

  get listNotes => _listNotes;

  deleteNote(int noteId) {
    _listNotes.removeWhere((getedNote) => getedNote.id == noteId);
    notifyListeners();
  }

  updateNote(Note note) {
    _listNotes[_listNotes.indexWhere((getedNote) => getedNote.id == note.id)] =
        note;
    notifyListeners();
  }
}
