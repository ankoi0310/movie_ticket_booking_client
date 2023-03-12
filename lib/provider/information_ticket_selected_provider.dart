import 'package:flutter/material.dart';

class InformationTicketSelectedProvider extends ChangeNotifier {
  int _selectedCinema = 0;
  int _selectedMovie = 0;
  DateTime? _selectedDate;

  int get selectedCinema => selectedCinema;

  int get selectedMovie => selectedMovie;

  DateTime? get selectedDate => selectedDate;

  void setSelectedCinema(int index) {
    _selectedCinema = index;
    notifyListeners();
  }

  void setSelectedMovie(int index) {
    _selectedMovie = index;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

}