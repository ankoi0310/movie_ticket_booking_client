import 'package:flutter/cupertino.dart';

class PageCarouselProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

   void changeCurrentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }
}