class AppUtil {
  static isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static isValidPhone(String phone) {
    return RegExp(r"^[0-9]{10}$").hasMatch(phone);
  }

  static isShortPassword(String password) {
    return password.length < 6;
  }
}
