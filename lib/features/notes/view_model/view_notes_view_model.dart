import 'package:flutter/material.dart';
import 'package:notes_app/core/common/Model/notes_model.dart';
import 'package:notes_app/services/hive_service.dart';

import 'ui_view_model.dart';

class NotesViewModel with ChangeNotifier {
  final HiveService hiveService;
  final UiViewModel uiViewModel;
  // final HiddenNotesViewModel hiddenNotesViewModel;
  final HiddenNotesService _hiddenNotesService;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Notes> _notes = [];
  List<Notes> get notes => _notes;

  NotesViewModel(
    this.hiveService,
    this.uiViewModel,
    // this.hiddenNotesViewModel,
    this._hiddenNotesService,
  ) {
    getNotes();
  }

  getNotes() {
    _notes = hiveService.getNotes();
    notifyListeners();
  }

  Notes? getNotesAt(int index) {
    return hiveService.getNotesAt(index);
  }

  void deleteNotesByIndex() {
    final length = hiveService.length;
    final selectedItems = uiViewModel.selectedItems;
    selectedItems.sort((a, b) => b.compareTo(a));
    for (int index in selectedItems) {
      if (index >= 0 && index < length) {
        hiveService.deleteNotes(index);
      }
    }
    uiViewModel.clearSelection();
    getNotes();
  }



  void saveNotes() {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();

    if (title.isEmpty && description.isEmpty) {
      return;
    }
    Notes note = Notes(
      title: title,
      description: description,
      createdAt: DateTime.now(),
      //  formattedDate(),
    );

    hiveService.addNotes(note);
    getNotes();
  }

  void updateNotes(int index) {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();

    if (title.isEmpty && description.isEmpty) {
      return;
    }
    Notes note = Notes(
      title: title,
      description: description,
      createdAt: DateTime.now(),
      //  formattedDate(),
    );

    hiveService.updateNotes(index, note);
    getNotes();
  }

  moveNotesToHidden() {
    final selectedIndex = uiViewModel.selectedItems;
    if (selectedIndex.isEmpty) return;
    final List<Notes> notesToMove = <Notes>[];
    print(selectedIndex);
    for (int index in selectedIndex) {
      print(index);
      final note = getNotesAt(index);
      if (note != null && !_hiddenNotesService.isNoteAvailable(index)) {
        notesToMove.add(
          Notes(
            title: note.title,
            description: note.description,
            createdAt: note.createdAt,
          ),
        );
      }
    }
    if (notesToMove.isEmpty) return;
    deleteNotesByIndex();
    _hiddenNotesService.moveNotes(notesToMove);
    // hiddenNotesViewModel.fetchHiddenNotes();
  }
}
