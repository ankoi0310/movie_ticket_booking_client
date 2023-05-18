import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JWTHeader {
  final String alg;
  final String typ;

  JWTHeader({
    required this.alg,
    required this.typ,
  });

  factory JWTHeader.fromJson(Map<String, dynamic> json) {
    return JWTHeader(
      alg: json['alg'],
      typ: json['typ'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alg': alg,
      'typ': typ,
    };
  }
}

class JWTPayload {
  final String iss;
  final String aud;
  final int iat;
  final String sub;
  final List<String> authorities;
  final int exp;

  JWTPayload({
    required this.iss,
    required this.aud,
    required this.iat,
    required this.sub,
    required this.authorities,
    required this.exp,
  });

  factory JWTPayload.fromJson(Map<String, dynamic> json) {
    return JWTPayload(
      iss: json['iss'],
      aud: json['aud'],
      iat: json['iat'],
      sub: json['sub'],
      authorities: json['authorities'],
      exp: json['exp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iss': iss,
      'aud': aud,
      'iat': iat,
      'sub': sub,
      'authorities': authorities,
      'exp': exp,
    };
  }
}

class JwtService {
  JwtService._();

  static final JwtService _instance = JwtService._();

  static JwtService get instance => _instance;

  JWTPayload getPayload(String token) {
    JWT jwt = JWT.decode(token);
    return JWTPayload.fromJson(jwt.payload);
  }

  Map<String, dynamic>? getHeader(String token) {
    JWT jwt = JWT.decode(token);

    if (jwt.header != null) {
      return JWTHeader.fromJson(jwt.header!).toJson();
    }

    return null;
  }

  bool isExpired(String token) {
    JWTPayload payload = getPayload(token);
    return DateTime.fromMillisecondsSinceEpoch(payload.exp * 1000).isBefore(DateTime.now());
  }
}
