import 'package:movie_ticket_booking_flutter_nlu/core.dart';

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
        'userRegister': {
          'email': userRegister.email,
          'phone': userRegister.phone,
          'password': userRegister.password,
          'userInfo': {
            'fullName': userRegister.name,
            'dateOfBirth': DateFormat("dd-MM-yyyy").format(userRegister.birthday!),
          }
        }
      }),
    );

    notifyListeners();
    return response;
  }

  Future<HttpResponse> resendVerifyMail(String email) async {
    HttpResponse response = await _apiProvider.post(
      Uri.parse('$baseUrl/auth/resend-email/register'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
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

  Future<HttpResponse> loginGoogle(final accessToken) async {
    HttpResponse response = await _apiProvider.post(
      Uri.parse('$baseUrl/auth/login/google?access-token=$accessToken'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}),
    );

    if (response.success) {
      UserLoginResponse userLogin = UserLoginResponse.fromJson(response.data);
      await _authentacationService.saveUser(userLogin.toJson());
    }

    notifyListeners();
    return response;
  }

  Future<bool> isLoggedIn() async {
    return await _authentacationService.isLoggedIn();
  }

  Future<HttpResponse> forgotPassword(String email) async {
    HttpResponse response = await _apiProvider.post(
      Uri.parse('$baseUrl/auth/forgot-password'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    notifyListeners();
    return response;
  }

  Future<HttpResponse> resetPassword({required String token, required String password}) async {
    HttpResponse response = await _apiProvider.put(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'token': token,
        'password': password,
      }),
    );

    notifyListeners();
    return response;
  }
}
