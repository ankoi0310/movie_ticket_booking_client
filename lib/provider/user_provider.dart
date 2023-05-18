import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/user/user_info.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';

class UserProvider with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;
  final AuthenticationService _authentacationService = AuthenticationService.instance;

  Future<HttpResponse> updateAvatar(String avatar) async {
    String email = await _authentacationService.getCurrentUserEmail();
    HttpResponse response = await _apiProvider.put(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'avatar': avatar,
      }),
    );

    notifyListeners();
    return response;
  }

  Future<UserInfo> getProfile() async {
    bool isLoggedIn = await _authentacationService.isLoggedIn();
    if (!isLoggedIn) {
      throw Exception('Chưa đăng nhập');
    }

    String token = _authentacationService.token!;

    HttpResponse response = await _apiProvider.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.success) {
      UserInfo userInfo = UserInfo.fromJson(response.data);
      await _authentacationService.saveUser(userInfo.toJson());

      return userInfo;
    }

    throw Exception('Không thể lấy thông tin người dùng');
  }

  Future<HttpResponse> updateProfile(UserInfoRequest userInfoRequest) async {
    HttpResponse response = await _apiProvider.put(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userInfoRequest.toJson()),
    );

    notifyListeners();
    return response;
  }

  Future<HttpResponse> changePassword(String password, String newPassword) async {
    String email = await _authentacationService.getCurrentUserEmail();
    HttpResponse response = await _apiProvider.put(
      Uri.parse('$baseUrl/user/change-password'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'newPassword': newPassword,
      }),
    );

    notifyListeners();
    return response;
  }

  Future<HttpResponse> getBookingHistory() async {
    HttpResponse response = await _apiProvider.get(
      Uri.parse('$baseUrl/user/booking-history'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    notifyListeners();
    return response;
  }

  Future<HttpResponse> getBookingHistoryDetail(int bookingId) async {
    HttpResponse response = await _apiProvider.get(
      Uri.parse('$baseUrl/user/booking-history/$bookingId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    notifyListeners();
    return response;
  }
}
