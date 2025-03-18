import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/core/common/constants/constans.dart';

class HiveService {
 static Future<void> initializeHive() async {
    await Hive.initFlutter();
  }
 static Future<void> openHive() async {
     await Hive.openBox(boxName);
  }
}
