import 'package:flutter/material.dart';
import 'package:notes_app/features/hidden_notes/view_model/hidden_notes_ui_view_model.dart';

import '../../../core/common/Model/notes_model.dart';
import '../../../services/hive_service.dart';

class HiddenNotesViewModel extends ChangeNotifier {
  final HiddenNotesService hiddenNotesService;
  final HiddenNotesUiViewModel hiddenUiViewModel;
  final HiveService hiveService;
  // final NotesViewModel notesViewModel;
  List<Notes> _hiddenNotes = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<Notes> get hiddenNotes => _hiddenNotes;
  HiddenNotesViewModel(
    this.hiddenNotesService,
    this.hiddenUiViewModel,
    this.hiveService,
    // this.notesViewModel,
  ) {
    fetchHiddenNotes();
  }

  void fetchHiddenNotes() {
    _hiddenNotes = hiddenNotesService.getNotes();
    notifyListeners();
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

    hiddenNotesService.addNotes(note);
    fetchHiddenNotes();
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

    hiddenNotesService.updateNotes(index, note);
    fetchHiddenNotes();
  }

  void deleteNotesByIndex() {
    final selectedItems = hiddenUiViewModel.selectedItems;
    final length = hiddenNotesService.length;
    selectedItems.sort((a, b) => b.compareTo(a));
    for (int index in selectedItems) {
      if (index >= 0 && index < length) {
        hiddenNotesService.deleteNotes(index);
      }
    }
    hiddenUiViewModel.clearSelection();
    fetchHiddenNotes();
  }

  moveNotes() {
    final selectedIndex = hiddenUiViewModel.selectedItems;
    if (selectedIndex.isEmpty) return;
    final List<Notes> notesToMove = <Notes>[];
    for (int index in selectedIndex) {
      final note = hiddenNotesService.getNotesAt(index);
      if (note != null && !hiveService.isNoteAvailable(index)) {
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
    hiveService.moveNotes(notesToMove);
    // notesViewModel.getNotes();
  }
}
