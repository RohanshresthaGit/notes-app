import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/core/common/Model/notes_model.dart';
import 'package:notes_app/core/common/constants/constans.dart';

class HiveService {
  
  static late Box<Notes> _box;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NotesAdapter());
    _box = await Hive.openBox(boxName);
  }

  List<Notes> getNotes() {
    return _box.values.toList();
  }

  void addNotes(Notes note) {
    _box.add(note);
  }

  void updateNotes(int index, Notes note) async {
    await _box.putAt(index, note);
  }

  void deleteNotes(int index) async {
    await _box.deleteAt(index);
  }
}
