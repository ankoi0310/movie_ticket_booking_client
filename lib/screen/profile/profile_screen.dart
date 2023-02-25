import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/profile/component/body.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoggedIn = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Body(isLoggedIn: isLoggedIn),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    if (isLoggedIn) {
      return AppBar(
        title: const Text(
          'Tài khoản',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return AppBar(
        centerTitle: false,
        title: const Text(
          'Tài khoản',
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Đăng ký',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      );
    }
  }
}
