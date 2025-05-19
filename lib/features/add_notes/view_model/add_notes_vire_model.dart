import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/common/Model/notes_model.dart';
import 'package:notes_app/services/hive_service.dart';

import '../../notes/view_model/view_notes_view_model.dart';

class AddNotesViewModel with ChangeNotifier {
  final DatabaseServiceInterface hiveService;
  final ViewNotesViewModel viewNotes;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime currentDateTime = DateTime.now();
  int currentCharectersCount = 0;
  Timer? _timer;

  AddNotesViewModel(this.hiveService, this.viewNotes) {
    titleController.addListener(updateCharecterCount);
    descriptionController.addListener(updateCharecterCount);
  }

  void updateCharecterCount() {
    currentCharectersCount = descriptionController.text.length;
    notifyListeners();
  }

  void loadNoteForUpdate(Notes note) {
    titleController.text = note.title;
    descriptionController.text = note.description;
    currentDateTime = note.createdAt;
    updateCharecterCount();
  }

  void onTextChanged(int? index) {
    _timer?.cancel();
    _timer = Timer(
      const Duration(seconds: 3),
      index == null ? saveNotes : () => updateNotes(index),
    );
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
    viewNotes.getNotes();
    notifyListeners();
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
    viewNotes.getNotes();
    notifyListeners(); 
  }

  @override
  void dispose() {
    titleController.removeListener(updateCharecterCount);
    descriptionController.removeListener(updateCharecterCount);
    titleController.dispose();
    descriptionController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String formattedDate() {
    return DateFormat('d MMMM h:mm a').format(currentDateTime);
  }
}
