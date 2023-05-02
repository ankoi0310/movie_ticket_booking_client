import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class AuthenticationService {
  AuthenticationService._();

  static final AuthenticationService _instance = AuthenticationService._();

  static final HiveProvider _hiveDataProvider = HiveProvider.instance;

  factory AuthenticationService() => _instance;

  static AuthenticationService get instance => _instance;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<UserLoginResponse>(UserLoginResponseAdapter());
  }

  /// Method to get User
  Future<UserLoginResponse> getUser() async {
    Map<String, dynamic> response = await _hiveDataProvider.read("user");
    return UserLoginResponse.fromJson(response);
  }

  /// Method to check if user is logged in
  Future<bool> isLoggedIn() async {
    String? token = await getToken();
    return (token != null && token.isNotEmpty);
  }

  /// Method to login user
  Future<void> login(UserLoginResponse user) async {
    await _hiveDataProvider.insert("user", user.toJson());
  }

  /// Method to logout user
  Future<void> logout() async {
    await _hiveDataProvider.delete("user");
  }

  Future<int?> getUserId() async {
    Map response = await _hiveDataProvider.read("user");
    return (response.isNotEmpty ? response["id"] : null);
  }

  Future<String?> getToken() async {
    Map response = await _hiveDataProvider.read("user");
    return (response.isNotEmpty ? response["token"] : null);
  }
}
