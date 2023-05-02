import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/showtime/show_time_search.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/show_time.dart';
import 'package:http/http.dart' as http;

class ShowTimeProvider extends ChangeNotifier {
  List<ShowTime> _showTimes = [];

  ShowTime? _showTime;

  List<ShowTime> get showTimes => _showTimes;

  ShowTime get getShowTime => _showTime!;

  Future<List<ShowTime>> getAllShowTime(ShowTimeSearch search) async {
    try {
      final response = await http.post(
          Uri.parse('http://localhost:8081/api/v1/showtime/search'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(search.toJson())
      );

      Map jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final data = jsonResponse['data'] as List;
        _showTimes = data.map((e) => ShowTime.fromJson(e)).toList();
      } else if(response.statusCode == 400) {
        throw Exception(jsonResponse['message']);
      }

      return _showTimes;
    } catch (error) {
      print('error: $error');
      rethrow;
    }
  }

}