import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class JwtService {
  JwtService._();

  static final JwtService _instance = JwtService._();

  static JwtService get instance => _instance;

  JWT decode(String token) {
      return JWT.decode(token);
  }

  Map<String, dynamic> getPayload(String token) {
    JWT jwt = decode(token);
    return jwt.payload;
  }

  Map<String, dynamic>? getHeader(String token) {
    JWT jwt = decode(token);
    return jwt.header;
  }
}
