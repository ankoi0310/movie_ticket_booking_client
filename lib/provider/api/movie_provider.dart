import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';

class MovieProvider extends ChangeNotifier {
  Movie? _movie;

  List<Movie> _movies = [];

  Movie? get movie => _movie;

  List<Movie> get movies => _movies;

  Future<Movie> getMovie(int id) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8081/api/v1/movie/$id'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _movie = Movie.fromJson(jsonResponse['data']);
      }
      notifyListeners();
      return _movie!;
    } catch (_) {
      rethrow;
    }
  }

  Future<Movie> getMovieBySlug(String slug) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8081/api/v1/movie/slug/$slug'));

      Map jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        _movie = Movie.fromJson(jsonResponse['data']);
      } else if (response.statusCode == 404) {
        throw Exception('Movie not found');
      }
      notifyListeners();
      return _movie!;
    } catch (_) {
      print('error: $_');
      rethrow;
    }
  }

  Future<List<Movie>> getMoviesSearch(int id) async {
    try {
      final response = await http.post(Uri.parse('http://localhost:8081/api/v1/movie/search'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({}));

      Map jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final data = jsonResponse['data'] as List;
        _movies = data.map((e) => Movie.fromJson(e)).toList();
      }
      notifyListeners();
      return _movies;
    } catch (_) {
      print('error: $_');
      rethrow;
    }
  }
}
