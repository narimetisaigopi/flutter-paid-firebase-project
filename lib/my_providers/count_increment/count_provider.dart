import 'package:flutter/material.dart';

class CountProvider extends ChangeNotifier {
  int count = 0;

  updateCount() {
    count++;
    //notifyListeners();
  }
}
