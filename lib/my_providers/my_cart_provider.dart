import 'package:flutter/material.dart';

class MyCartProvider extends ChangeNotifier {
  List myCartItems = [];

  addToCart(String item) {
    myCartItems.add(item);
    notifyListeners();
  }

  removeFromCart(String item) {
    myCartItems.remove(item);
    notifyListeners();
  }
}
