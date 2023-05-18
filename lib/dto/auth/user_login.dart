import 'package:hive/hive.dart';

part 'user_login.g.dart';

class UserLoginRequest {
  String email;

  String password;

  UserLoginRequest({
    required this.email,
    required this.password,
  });

  factory UserLoginRequest.fromJson(Map<String, dynamic> json) {
    return UserLoginRequest(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

@HiveType(typeId: 0)
class UserLoginResponse {
  @HiveField(0)
  int id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String token;

  UserLoginResponse({
    required this.id,
    required this.email,
    required this.token,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      id: json['userId'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'token': token,
    };
  }
}
