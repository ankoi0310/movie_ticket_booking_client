import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';

class ShowTimeProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<HttpResponse> getAllShowTime(ShowTimeSearch search) async {
    try {
      HttpResponse response = await _apiProvider.post(
        Uri.parse('$baseUrl/showtime/search'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(search.toJson()),
      );

      print('response: $response');

      notifyListeners();
      return response;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
