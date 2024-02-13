import 'package:flutter/material.dart';

class CounterNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;

  void incrementValue() {
    _value++;
    notifyListeners();
  }
}

class CounterViewModel extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}
