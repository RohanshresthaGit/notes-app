import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../config/routes.dart';
import '../../../core/common/Model/notes_model.dart';
import 'view_notes_view_model.dart';

class DeleteNotesViewModel with ChangeNotifier {
  final Box<Notes>? box;
  bool isSelectedMode = false;
  int selectedIndex = 0;
  final List<int> _selectedItems = [];
  final ViewNotesViewModel viewNotesViewModel;
  List<int> get selectedItems => _selectedItems;
  DeleteNotesViewModel(this.viewNotesViewModel, {required this.box});

  onLongPress(int index) {
    if (isSelectedMode) return;
    isSelectedMode = true;
    _selectedItems.add(index);
    notifyListeners();
  }

  onTap(int index, BuildContext context) {
    if (isSelectedMode) {
      if (_selectedItems.contains(index)) {
        _selectedItems.remove(index);
      } else {
        _selectedItems.add(index);
      }
      notifyListeners();
    } else {
      Navigator.pushNamed(
        context,
        Routes.updateNotes,
        arguments: {'index': index},
      );
    }
  }

  clearSelection() {
    isSelectedMode = false;
    _selectedItems.clear();
    notifyListeners();
  }

  deleteNotes() {
    viewNotesViewModel.deleteNotesByIndex(_selectedItems);
    clearSelection();
  }
}
