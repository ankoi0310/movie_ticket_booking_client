import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class AuthenticationService with ChangeNotifier {
  AuthenticationService._();

  static final AuthenticationService _instance = AuthenticationService._();

  static final HiveProvider _hiveDataProvider = HiveProvider.instance;

  factory AuthenticationService() => _instance;

  static AuthenticationService get instance => _instance;

  String? _token;

  String? get token => _token;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<UserLoginResponse>(UserLoginResponseAdapter());
    Hive.registerAdapter<UserInfo>(UserInfoAdapter());
  }

  Future<void> loadToken() async {
    Map response = await _hiveDataProvider.read("user");
    _token = (response.isNotEmpty ? response["token"] : null);
  }

  /// Method to check if user is logged in
  Future<bool> isLoggedIn() async {
    await loadToken();
    return (_token != null && _token!.isNotEmpty);
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    await _hiveDataProvider.insert("user", user);
    notifyListeners();
  }

  Future<void> saveCurrentAvatar(String avatar) async {
    await _hiveDataProvider.update("user", {"avatar": avatar});
    notifyListeners();
  }

  Future<void> saveToken(String token) async {
    await _hiveDataProvider.insert("user", {"token": token});
  }

  /// Method to logout user
  Future<void> logout() async {
    _token = null;
    await _hiveDataProvider.delete("user");
  }

  Future<int?> getUserId() async {
    Map response = await _hiveDataProvider.read("user");
    return (response.isNotEmpty ? response["id"] : null);
  }

  Future<String> getCurrentUserEmail() async {
    Map response = await _hiveDataProvider.read("user");
    return (response.isNotEmpty ? response["email"] : null);
  }

  Future<String> getCurrentAvatar() async {
    Map response = await _hiveDataProvider.read("user");
    print(response);
    notifyListeners();
    return (response.isNotEmpty ? response["avatar"] : null);
  }
}
