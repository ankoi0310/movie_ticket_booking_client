import 'package:intl/intl.dart';

class AppUtil {
  static isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static isValidPhone(String phone) {
    return RegExp(r"^[0-9]{10}$").hasMatch(phone);
  }

  static bool isValidBirthday(String birthday) {
    try {
      return DateFormat('dd/MM/yyyy').parse(birthday).isBefore(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  static isShortPassword(String password) {
    return password.length < 6;
  }

  static String formatDuration(int duration) {
    return duration < 60 ? '$duration phút' : '${duration ~/ 60} tiếng ${duration % 60} phút';
  }
}
