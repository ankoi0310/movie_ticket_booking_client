class UserRegister {
  String name;
  String email;
  String password;
  String phone;
  DateTime birthday;

  UserRegister({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.birthday,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) {
    return UserRegister(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      birthday: DateTime.parse(json['birthday']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'birthday': birthday.toIso8601String(),
    };
  }
}
