import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/showtime/show_time_search.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/show_time.dart';
import 'package:http/http.dart' as http;

class ShowTimeProvider extends ChangeNotifier {
  final apiProvider = ApiProvider.instance;
  List<ShowTime> _showTimes = [];

  ShowTime? _showTime;

  List<ShowTime> get showTimes => _showTimes;

  ShowTime get getShowTime => _showTime!;

  Future<HttpResponse> getAllShowTime(ShowTimeSearch search) async {
    HttpResponse response = await apiProvider.post(Uri.parse('$baseUrl/showtime/search'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(search.toJson()));

    try {
      _showTimes = response.data.map<ShowTime>((e) => ShowTime.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }

    return response;
  }

}