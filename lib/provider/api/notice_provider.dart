import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';

class NoticeProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<HttpResponse> getNoticeSearch(String email) async {
    HttpResponse response = await _apiProvider.post(Uri.parse('$baseUrl/notice/search'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email}));

    notifyListeners();
    return response;
  }
  Future<HttpResponse> readAllNotice(String email) async {
    HttpResponse response = await _apiProvider.post(Uri.parse('$baseUrl/notice/read'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email}));

    notifyListeners();
    return response;
  }
}
