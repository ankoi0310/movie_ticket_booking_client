import 'package:flutter/material.dart';

class SearchingProvider extends ChangeNotifier {
  bool _isSearching = false;
  bool get isSearching => _isSearching;

  void startSearching() {
    _isSearching = true;
    notifyListeners();
  }

  void stopSearching() {
    _isSearching = false;
    notifyListeners();
  }
}
