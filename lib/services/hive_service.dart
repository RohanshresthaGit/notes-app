import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/core/common/Model/notes_model.dart';
import 'package:notes_app/core/common/constants/constans.dart';

abstract class DatabaseServiceInterface {
  List<Notes> getNotes();
  void addNotes(Notes note);
  void updateNotes(int index, Notes note);
  void deleteNotes(int index);
}

class DataBaseManager {
  static String get _boxName => boxName;
  static Future<Box<Notes>> initialize() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NotesAdapter());
    }
    return await Hive.openBox<Notes>(_boxName);
  }
}

class HiveService implements DatabaseServiceInterface {
  final Box<Notes> _box;
  HiveService(this._box);

  @override
  List<Notes> getNotes() {
    return _box.values.toList();
  }

  @override
  void addNotes(Notes note) {
    _box.add(note);
  }

  @override
  void updateNotes(int index, Notes note) async {
    await _box.putAt(index, note);
  }

  @override
  void deleteNotes(int index) async {
    await _box.deleteAt(index);
  }
}
