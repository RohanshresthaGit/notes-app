import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/common/Model/notes_model.dart';
import 'package:notes_app/services/hive_service.dart';

import '../../hidden_notes/view_model/hidden_notes_view_model.dart';

class AddHiddenNotesViewModel with ChangeNotifier {
  final HiddenNotesService hiddenNotesService;
  final HiddenNotesViewModel hiddenNotesViewModel;
  DateTime currentDateTime = DateTime.now();
  int currentCharectersCount = 0;
  Timer? _timer;

  AddHiddenNotesViewModel(this.hiddenNotesService, this.hiddenNotesViewModel) {
    hiddenNotesViewModel.titleController.addListener(updateCharecterCount);
    hiddenNotesViewModel.descriptionController.addListener(
      updateCharecterCount,
    );
  }

  void updateCharecterCount() {
    currentCharectersCount =
        hiddenNotesViewModel.descriptionController.text.length;
    notifyListeners();
  }

  void loadNoteForUpdate(Notes note) {
    hiddenNotesViewModel.titleController.text = note.title;
    hiddenNotesViewModel.descriptionController.text = note.description;
    currentDateTime = note.createdAt;
    updateCharecterCount();
  }

  void onTextChanged(int? index) {
    _timer?.cancel();
    _timer = Timer(
      const Duration(seconds: 3),
      index == null ? hiddenNotesViewModel.saveNotes : () => hiddenNotesViewModel.updateNotes(index),
    );
  }

  @override
  void dispose() {
    hiddenNotesViewModel.titleController.removeListener(updateCharecterCount);
    hiddenNotesViewModel.descriptionController.removeListener(
      updateCharecterCount,
    );
    hiddenNotesViewModel.titleController.dispose();
    hiddenNotesViewModel.descriptionController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String formattedDate() {
    return DateFormat('d MMMM h:mm a').format(currentDateTime);
  }
}
