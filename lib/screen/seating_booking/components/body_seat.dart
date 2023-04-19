import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/seating_booking/components/list_seat.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/seating_booking/components/showtime_info.dart';

class BodySeat extends StatefulWidget {
  const BodySeat({Key? key}) : super(key: key);

  @override
  State<BodySeat> createState() => _BodySeatState();
}

class _BodySeatState extends State<BodySeat> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(100),
          vertical: getProportionateScreenWidth(25),
        ),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: Color.fromRGBO(1, 18, 45, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShowtimeInfo(),
            Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.only(
                top: 10,
                bottom: 40,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  "Màn hình".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(30),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 10,
              ),
              width: 250,
              height: 1,
              color: Colors.grey,
            ),
            Container(
              width: SizeConfig.screenWidth,
              child: Center(
                child: Text(
                  "Ghế thường".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(24),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              width: 300,
              height: 1,
              color: Colors.grey,
            ),
            ListSeat(),
          ],
        ));
  }
}
