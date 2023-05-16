import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/movie/movie_search.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';

class MovieProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<HttpResponse> getMovie(int id) async {
    try {
      HttpResponse response = await _apiProvider.get(Uri.parse('http://localhost:8081/api/v1/movie/$id'));

      if (response.httpStatusCode == 200) {
        notifyListeners();
        return response;
      }

      notifyListeners();
      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<HttpResponse> getMovieBySlug(String slug) async {
    try {
      HttpResponse response = await _apiProvider.get(Uri.parse('http://localhost:8081/api/v1/movie/slug/$slug'));

      notifyListeners();
      return response;
    } catch (_) {
      print('error: $_');
      rethrow;
    }
  }

  Future<HttpResponse> getMoviesSearch(MovieSearch search) async {
    try {
      HttpResponse response = await _apiProvider.post(
        Uri.parse('$baseUrl/movie/search'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(search.toJson()),
      );

      notifyListeners();
      return response;
    } catch (_) {
      print('error: $_');
      rethrow;
    }
  }
}
