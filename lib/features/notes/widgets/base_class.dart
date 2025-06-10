import 'package:flutter/material.dart';

abstract class BaseUiViewModel extends ChangeNotifier {
  bool get isSelectedMode;
  List<int> get selectedItems;
  void onTap(int index);
  void onLongPress(int index);
  void clearSelection();
}
