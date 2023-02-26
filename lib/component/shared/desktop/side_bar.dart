import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/constants.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';

Drawer getSideBar(BuildContext context) {
  return Drawer(
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(20),
      ),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            child: ClipOval(
              child: Image.network(
                '${defaultImageUrl}avt.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Divider(height: getProportionateScreenWidth(60)),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text('Trang chủ'),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                title: Text('Phim'),
                onTap: () {
                  Navigator.pushNamed(context, '/movie');
                },
              ),
              ListTile(
                title: Text('Liên hệ'),
                onTap: () {
                  Navigator.pushNamed(context, '/contact');
                },
              ),
            ],
          ),
          Divider(height: getProportionateScreenWidth(60)),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Thông tin cá nhân'),
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  ListTile(
                    title: Text('Lịch sử đặt vé'),
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  ListTile(
                    title: Text('Đổi mật khẩu'),
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Đăng xuất',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          )
        ],
      ),
    ),
  );
}
