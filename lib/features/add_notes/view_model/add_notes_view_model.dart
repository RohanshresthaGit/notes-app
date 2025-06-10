import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/common/Model/notes_model.dart';
import 'package:notes_app/services/hive_service.dart';

import '../../notes/view_model/view_notes_view_model.dart';

class AddNotesViewModel with ChangeNotifier {
  final HiveService hiveService;
  final NotesViewModel viewNotes;
  DateTime currentDateTime = DateTime.now();
  int currentCharectersCount = 0;
  Timer? _timer;

  AddNotesViewModel(this.hiveService, this.viewNotes) {
    viewNotes.titleController.addListener(updateCharecterCount);
    viewNotes.descriptionController.addListener(updateCharecterCount);
  }

  void updateCharecterCount() {
    currentCharectersCount = viewNotes.descriptionController.text.length;
    notifyListeners();
  }

  void loadNoteForUpdate(Notes note) {
    viewNotes.titleController.text = note.title;
    viewNotes.descriptionController.text = note.description;
    currentDateTime = note.createdAt;
    updateCharecterCount();
  }

  void onTextChanged(int? index) {
    _timer?.cancel();
    _timer = Timer(
      const Duration(seconds: 3),
      index == null ? viewNotes.saveNotes : () => viewNotes.updateNotes(index),
    );
  }





  @override
  void dispose() {
    viewNotes.titleController.removeListener(updateCharecterCount);
    viewNotes.descriptionController.removeListener(updateCharecterCount);
    viewNotes.titleController.dispose();
    viewNotes.descriptionController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String formattedDate() {
    return DateFormat('d MMMM h:mm a').format(currentDateTime);
  }
}
