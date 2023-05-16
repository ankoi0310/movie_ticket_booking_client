import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/service/jwt_service.dart';

class AuthenticationService {
  AuthenticationService._();

  static final AuthenticationService _instance = AuthenticationService._();

  static final HiveProvider _hiveDataProvider = HiveProvider.instance;
  static final JwtService _jwtService = JwtService.instance;

  factory AuthenticationService() => _instance;

  static AuthenticationService get instance => _instance;

  String? _token;

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
    _token = user.token;
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
    _token = (response.isNotEmpty ? response["token"] : null);
    return (response.isNotEmpty ? response["token"] : null);
  }

  Future<Map<String, dynamic>?> getProfile() async {
    String? token = await getToken();

    if (token != null) {
      Map<String, dynamic> payload = _jwtService.getPayload(token);
      print('payload: $payload');
      return payload;
    }

    return null;
  }

}
