import 'package:flutter/material.dart';

import '../features/hidden_notes/view_model/hidden_notes_view_model.dart';
import '../features/notes/view_model/view_notes_view_model.dart';

class MoveNotesViewModel extends ChangeNotifier {
  final HiddenNotesViewModel hiddenNotesViewModel;
  final NotesViewModel notesViewModel;

  MoveNotesViewModel({
    required this.hiddenNotesViewModel,
    required this.notesViewModel,
  });

  moveNotes() {
    hiddenNotesViewModel.moveNotes();
    notesViewModel.getNotes();
  }

  moveNotesToHidden() {
    notesViewModel.moveNotesToHidden();
    hiddenNotesViewModel.fetchHiddenNotes();
  }
}
