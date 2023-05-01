import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';

AppBar buildHeader(BuildContext context, GlobalKey<ScaffoldState> key) {
  return AppBar(
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Home',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        Text(
          'Movie',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        Text(
          'Theater',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        Text(
          'Contact',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        Text(
          'About',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
    actions: [
      Container(
        padding: EdgeInsets.only(right: getProportionateScreenWidth(20)),
        child: IconButton(
          onPressed: () {
            key.currentState!.openEndDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
    ],
  );
}
