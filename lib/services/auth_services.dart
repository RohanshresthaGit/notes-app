import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/config/routes.dart';
import 'package:notes_app/core/common/constants/constans.dart';

class AuthServices with ChangeNotifier {
  late Box _box;
  String message = 'Enter privacy Protection Password';
  AuthServices() {
    initPatternBox();
  }

  initPatternBox() async {
    _box = await Hive.openBox(authBox);
  }

  // var box = Hive.box(authBox);
  bool isPatternSet() {
    final isset = _box.get(pattern) != null;
    return isset;
  }

  setPattern(List<int> input) {
    _box.put(pattern, input);
    notifyListeners();
  }

  List<int> getPattern() {
    final patter = _box.get(pattern)?.cast<int>();
    print('pattern: $patter');
    return patter;
  }

  chagnePattern(List<int> input) {
    _box.put(pattern, input);
    notifyListeners();
  }

  getPatternCallBack(List<int> input, BuildContext context) {
    if (isPatternSet()) {
      if (getPattern().isEqualTo(input)) {
        Navigator.pushReplacementNamed(context, Routes.hiddenNotes);
        print("Authenicate succesfull");
      } else {
        message = 'Try again';
        notifyListeners();
        print("Authenicate failed");
      }
    } else {
      setPattern(input);
      message = 'pattern set successfully';
      notifyListeners();
    }
  }
}

extension on List<int> {
  bool isEqualTo(List<int> other) {
    if (this.length != other.length) return false;
    for (int i = 0; i < this.length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}
