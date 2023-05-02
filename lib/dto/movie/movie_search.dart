import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';

class MovieSearch {
  String? name;
  int? duration;
  MovieFormat? movieFormat;
  MovieState? movieState;

  MovieSearch({
    this.name,
    this.duration,
    this.movieFormat,
    this.movieState,
  });

  MovieSearch.empty()
      : name = null,
        duration = null,
        movieFormat = null,
        movieState = null;

  MovieSearch.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    duration = json['duration'];
    movieFormat = json['movieFormat'];
    movieState = json['movieState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if(name != null) {
      data['name'] = name;
    }
    if(duration != null) {
      data['duration'] = duration;
    }
    if(movieFormat != null) {
      data['movieFormat'] = movieFormat;
    }
    if(movieState != null) {
      data['movieState'] = movieState!.value;
    }

    return data;
  }
}
