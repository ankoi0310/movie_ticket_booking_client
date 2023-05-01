import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';

class Breadcrumb extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String description;

  const Breadcrumb(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.description})
      : super(key: key);

  @override
  State<Breadcrumb> createState() => _BreadcrumbState();
}

class _BreadcrumbState extends State<Breadcrumb> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 400,
      child: Stack(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
            height: 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(50),
                vertical: getProportionateScreenWidth(50)),
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.movie_filter_sharp,
                      color: Colors.white,
                      size: getProportionateScreenWidth(60),
                      weight: IconThemeData().weight,
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(20),
                    ),
                    Text(
                      widget.title.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(60),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenWidth(30),
                      height: getProportionateScreenHeight(1.8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
