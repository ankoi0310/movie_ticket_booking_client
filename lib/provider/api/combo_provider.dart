import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/combo.dart';

class ComboProvider extends ChangeNotifier {
  final apiProvider = ApiProvider.instance;
  Combo? _combo;

  List<Combo> _combos = [];

  Combo? get combo => _combo;

  List<Combo> get combos => _combos;

  Future<HttpResponse> getCombos() async {
    HttpResponse response = await apiProvider.get(
      Uri.parse('$baseUrl/combo/search'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    try {
      _combos = response.data.map<Combo>((e) => Combo.fromJson(e)).toList();
    }catch(e) {
      print(e);
    }

    notifyListeners();
    return response;
  }
}