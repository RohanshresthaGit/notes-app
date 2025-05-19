import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/core/common/Model/notes_model.dart';

class ViewNotesViewModel with ChangeNotifier {
  final Box<Notes>? box;
  List<Notes> _notes = [];
  List<Notes> get notes => _notes;

  ViewNotesViewModel(this.box) {
    getNotes();
  }

  getNotes() {
    _notes = box!.values.toList();
    notifyListeners();
  }

  deleteNotesByIndex(List<int> indexes) {
    final keys = box!.keys.toList();
    indexes.sort((a, b) => b.compareTo(a));
    for (int index in indexes) {
      box!.delete(keys[index]);
    }
    getNotes();
  }
}
