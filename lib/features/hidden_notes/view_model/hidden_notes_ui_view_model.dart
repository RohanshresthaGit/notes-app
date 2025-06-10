import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';

import '../../../config/routes.dart';
import '../../notes/widgets/base_class.dart';

class HiddenNotesUiViewModel extends ChangeNotifier implements BaseUiViewModel {
  HiddenNotesUiViewModel();

  final List<int> _selectedItems = [];
  @override
  List<int> get selectedItems => _selectedItems;
  @override
  bool isSelectedMode = false;

  @override
  void onTap(int index) {
    if (isSelectedMode) {
      if (_selectedItems.contains(index)) {
        _selectedItems.remove(index);
      } else {
        _selectedItems.add(index);
      }
      notifyListeners();
    } else {
      navigateToEdit({'index': index});
    }
  }

  navigateToEdit(Map<String, dynamic>? args) {
    navigation.push(Routes.updateHiddenNotes, args);
  }

  @override
  void onLongPress(int index) {
    if (isSelectedMode) return;
    isSelectedMode = true;
    _selectedItems.add(index);
    notifyListeners();
  }

  @override
  clearSelection() {
    isSelectedMode = false;
    _selectedItems.clear();
    notifyListeners();
  }

  movesNotes() {
    if (_selectedItems.isEmpty) return;
  }
}
