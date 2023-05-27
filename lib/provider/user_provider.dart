import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class UserProvider with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;
  final AuthenticationService _authentacationService = AuthenticationService.instance;
  final FirebaseStorageProvider _firebaseStorageProvider = FirebaseStorageProvider();

  Future<HttpResponse> uploadAvatar(Uint8List imageBytes) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String avatarUrl = await _firebaseStorageProvider.uploadImage('user/avatar/$fileName', imageBytes);

    HttpResponse response = await _apiProvider.put(
      Uri.parse('$baseUrl/user/upload-avatar'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${_authentacationService.token}',
      },
      body: jsonEncode({
        'avatarUrl': avatarUrl,
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

    HttpResponse response = await _apiProvider.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${_authentacationService.token}',
      },
    );

    if (response.success) {
      UserInfo userInfo = UserInfo.fromJson(response.data);
      await _authentacationService.saveUser(userInfo.toJson());

      notifyListeners();
      return userInfo;
    }

    throw Exception('Không thể lấy thông tin người dùng');
  }

  Future<HttpResponse> updateProfile(UserInfoRequest userInfoRequest) async {
    userInfoRequest.email = await _authentacationService.getCurrentUserEmail();

    HttpResponse response = await _apiProvider.put(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${_authentacationService.token}',
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
        'Authorization': 'Bearer ${_authentacationService.token}',
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
