import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';

class AuthenticationProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;
  final AuthenticationService _authentacationService = AuthenticationService.instance;

  Future<HttpResponse> register(UserRegister userRegister) async {
    HttpResponse response = await _apiProvider.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'userRegister': userRegister.toJson(),
      }),
    );

    notifyListeners();
    return response;
  }

  Future<HttpResponse> login(String email, String password) async {
    HttpResponse response = await _apiProvider.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.success) {
      UserLoginResponse userLogin = UserLoginResponse.fromJson(response.data);
      await _authentacationService.saveUser(userLogin.toJson());
    }

    notifyListeners();
    return response;
  }

  Future<void> logout() async {
    await _authentacationService.logout();
    notifyListeners();
  }
}
