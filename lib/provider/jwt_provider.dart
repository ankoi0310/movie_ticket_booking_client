import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class JwtService {
  JwtService._();

  static final JwtService _instance = JwtService._();

  static JwtService get instance => _instance;


//   decode function
  void decode(String token) {
    try {
      final jwt = JWT.decode(token);
      final payload = jwt.payload;
      print('payload: $payload');
    } catch (e) {
      print(e);
    }
  }
}
