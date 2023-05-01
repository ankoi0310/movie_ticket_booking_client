class MovieSearch {
  late String? name;
  late int? duration;
  late String? movieFormat;
  late String? movieState;

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
}
