import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:notes_app/config/routes.dart';
import 'package:notes_app/core/common/constants/constans.dart';
import 'package:notes_app/main.dart';

class AuthServices with ChangeNotifier {
  late Box _box;
  bool isConfirmPattern = false;
  bool showButton = false;
  bool isPatternValidated = false;
  List<int> userPattern = [];
  String message = 'Enter privacy Protection Password';
  final LocalAuthentication _biometrics = LocalAuthentication();
  AuthServices() {
    initPatternBox();
  }

  initPatternBox() async {
    _box = await Hive.openBox(authBox);
    getSwitch(enableAuth);
    getSwitch(enableAuth);
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
    final patter = (_box.get(pattern) as List<dynamic>?)?.cast<int>() ?? [];
    return patter;
  }

  void disableAuth() {
    userPattern.clear();
    _box.put(pattern, null);
    isConfirmPattern = false;
    showButton = false;
    message = 'Enter privacy Protection Password';
  }

  setSwitch(String key, bool value) {
    _box.put(key, value);

    if (key == enableAuth && !value) {
      disableAuth();
    }
    notifyListeners();
  }

  bool getSwitch(String key) {
    final value = _box.get(
      key,
      defaultValue: key == enableBiometrics ? false : true,
    );
    return value;
  }

  void resetPattern(BuildContext context) {
    userPattern.clear();
    isConfirmPattern = false;
    showButton = false;
    message = 'Enter privacy Protection Password';
    notifyListeners();
    navigation.go(Routes.authenticateUser);
  }

  Future<void> patternMatched(BuildContext context) async {
    // pattern matched
    setSwitch(enableAuth, true);

    await setPattern(userPattern);
    navigation.go(Routes.hiddenNotes);
    isConfirmPattern = false;
    showButton = false;
    // userPattern.clear();
    message = 'Enter privacy Protection Password';
    notifyListeners();
  }

  @override
  void dispose() {
    userPattern.clear();
    super.dispose();
  }

  void getPatternCallBack(
    List<int> input,
    BuildContext context,
    bool isChangePattern,
  ) async {
    if (showButton) return;
    if (input.length < 4) {
      message = 'Pattern must be at least 4 points';
      notifyListeners();
      return;
    }
    if (isPatternSet()) {
      // pattern is set
      if (getPattern().isEqualTo(input)) {
        navigation.go(Routes.hiddenNotes);
      } else {
        message = 'Try again';
        notifyListeners();
      }
    } else {
      if (isConfirmPattern) {
        if (!userPattern.isEqualTo(input)) {
          message = 'Patterns do not match';
          notifyListeners();
        } else {
          message = 'Pattern matched press the confirm button';
          showButton = true;
          notifyListeners();
        }
      } else {
        navigation.go(Routes.authenticateUser);
        userPattern.addAll(input);
        message = 'Repeat the pattern';
        isConfirmPattern = true;
        notifyListeners();
      }
    }
  }

  Future<void> forgotPattern(List<int> pattern) async {
    if (pattern.length < 4) {
      message = 'Pattern must be at least 4 points';
      notifyListeners();
      return;
    }
    if (userPattern.isNotEmpty) {
      if (userPattern.isEqualTo(pattern)) {
        await setPattern(pattern);
        navigation.go(Routes.hiddenNotes);
        userPattern.clear();
      } else {
        message = 'Patterns do not match';
      }
    } else {
      userPattern.clear();
      userPattern.addAll(pattern);
      navigation.go(Routes.authenticateUser, {"isForgot": true});
      message = 'Repeat the pattern';
    }
  }

  Future<void> changePattern(List<int> pattern, bool isChangePattern) async {
    if (!isPatternSet()) return;
    if (pattern.length < 4) {
      message = 'Pattern must be at least 4 points';
      notifyListeners();
      return;
    }

    if (isConfirmPattern) {
      if (!userPattern.isEqualTo(pattern)) {
        message = 'Patterns do not match';
        notifyListeners();
      } else {
        await setPattern(pattern);
        message = 'Pattern reset succesfully';
        navigation.go(Routes.notes);
        clearFlags();
        notifyListeners();
      }
    } else if (isPatternValidated) {
      navigation.go(Routes.authenticateUser, {"isChange": true});
      userPattern.addAll(pattern);

      message = 'repeat the pattern';
      isConfirmPattern = true;
      notifyListeners();
    } else {
      if (getPattern().isEqualTo(pattern)) {
        navigation.go(Routes.authenticateUser, {"isChange": true});
        message = 'set new pattern';
        isPatternValidated = true;
        userPattern.clear();
      } else {
        message = 'Try again';
        notifyListeners();
      }
    }
  }

  clearFlags() {
    userPattern.clear();
    isConfirmPattern = false;
    isPatternValidated = false;
    message = 'Enter privacy Protection Password';
  }

  Future<bool> authenticateWithBiometrics() async {
    if (getSwitch(enableBiometrics) == false ||
        isConfirmPattern ||
        isPatternValidated ||
        showButton) {
      return false;
    }
    final isBiometricAvailable = await _biometrics.canCheckBiometrics;
    if (isBiometricAvailable) {
      try {
        final didAuthenticate = await _biometrics.authenticate(
            authMessages: const [
              AndroidAuthMessages(
                // signInTitle: 'Custom Sign-In Title',
                biometricHint: 'Touch sensor to authenticate',
                cancelButton: 'No thanks',
              ),
            ],
            localizedReason: "Enter fingerprint to access hidden notes",
            options: const AuthenticationOptions(
                stickyAuth: true, biometricOnly: true));

        if (didAuthenticate) {
          navigation.go(Routes.hiddenNotes);
          return true;
        } else {
          message = 'Enter privacy Protection Password';
        }
      } catch (e) {
        debugPrint('Error during biometric authentication: $e');
      }
    }
    return false;
  }
}

extension on List<int> {
  bool isEqualTo(List<int> other) {
    if (length != other.length) return false;
    for (int i = 0; i < length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}
