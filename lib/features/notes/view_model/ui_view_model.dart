import 'package:flutter/widgets.dart';

import '../../../config/routes.dart';
import '../../../main.dart';
import '../widgets/base_class.dart';

class UiViewModel with ChangeNotifier implements BaseUiViewModel {
  @override
  bool isSelectedMode = false;
  final List<int> _selectedItems = [];
  @override
  List<int> get selectedItems => _selectedItems;
  UiViewModel();

  navigateToAdd() {
    navigation.push(Routes.addNotes);
  }

  navigateToEdit(Map<String, dynamic>? args) {
    navigation.push(Routes.updateNotes, args);
  }

  @override
  onLongPress(int index) {
    if (isSelectedMode) return;
    isSelectedMode = true;
    _selectedItems.add(index);
    notifyListeners();
  }

  @override
  onTap(int index) {
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

  @override
  clearSelection() {
    isSelectedMode = false;
    _selectedItems.clear();
    notifyListeners();
  }

  // Future<void> deleteNotes() async {
  //   await notesViewModel.deleteNotesByIndex();
  //   clearSelection();
  // }
}
