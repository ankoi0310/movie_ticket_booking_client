import 'package:hive/hive.dart';

part 'user_info.g.dart';

class UserInfoRequest {
  String? email;
  String fullName;
  bool isMale;
  String avatar;
  String dateOfBirth;

  UserInfoRequest({
    this.email,
    required this.fullName,
    required this.isMale,
    required this.avatar,
    required this.dateOfBirth,
  });

  factory UserInfoRequest.fromJson(Map<String, dynamic> json) {
    return UserInfoRequest(
      email: json['email'],
      fullName: json['fullName'],
      isMale: json['isMale'],
      avatar: json['avatar'],
      dateOfBirth: json['dateOfBirth'],
    );
  }

  factory UserInfoRequest.fromCurrent(UserInfo userInfo) {
    return UserInfoRequest(
      fullName: userInfo.fullName,
      isMale: userInfo.isMale,
      avatar: userInfo.avatar,
      dateOfBirth: userInfo.dateOfBirth,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'isMale': isMale,
      'avatar': avatar,
      'dateOfBirth': dateOfBirth,
    };
  }
}

@HiveType(typeId: 1)
class UserInfo {
  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final bool isMale;

  @HiveField(3)
  final String avatar;

  @HiveField(4)
  final String dateOfBirth;

  UserInfo({
    required this.fullName,
    required this.isMale,
    required this.avatar,
    required this.dateOfBirth,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      fullName: json['fullName'],
      isMale: json['isMale'],
      avatar: json['avatar'],
      dateOfBirth: json['dateOfBirth'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'isMale': isMale,
      'avatar': avatar,
      'dateOfBirth': dateOfBirth,
    };
  }
}
