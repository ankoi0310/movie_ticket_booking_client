import 'package:flutter/material.dart';

class ScrollingProvider extends ChangeNotifier {
  double _totalScrollDelta = 0;

  double get totalScrollDelta => _totalScrollDelta;

  void scrollToTop() {
    _totalScrollDelta = 0;
    notifyListeners();
  }

  void updateScrollDelta(double delta) {
    _totalScrollDelta = delta;
    notifyListeners();
  }
}
