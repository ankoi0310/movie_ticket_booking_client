import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/component/login_widget.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/component/profile_list.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.isLoggedIn}) : super(key: key);

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? const ProfileList() : const LoginWidget();
  }
}
