import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/branch.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';

class InformationTicketSelectedProvider extends ChangeNotifier {
  Branch? _selectBranch;
  Movie? _selectedMovie;
  DateTime? _selectedDate;

  Branch? get selectedBranch => _selectBranch;

  Movie? get selectedMovie => _selectedMovie;

  DateTime? get selectedDate => _selectedDate;

  void setSelectedBranch(Branch? selectedCinema) {
    _selectBranch = selectedCinema;
    notifyListeners();
  }

  void setSelectedMovie(Movie? selectedMovie) {
    _selectedMovie = selectedMovie;
    notifyListeners();
  }

  void setSelectedDate(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

}