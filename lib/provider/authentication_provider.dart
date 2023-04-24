import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class AuthenticationProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;
  final AuthenticationService _authentacationService = AuthenticationService.instance;

  Future<bool> login(String email, String password) async {
    await _apiProvider.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (_apiProvider.success) {
      UserLoginResponse userLogin = UserLoginResponse.fromJson(_apiProvider.data);
      await _authentacationService.login(userLogin);

      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }
}
