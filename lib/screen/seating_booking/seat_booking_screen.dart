import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie/components/breadcrumb.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/seating_booking/components/body_seat.dart';

import '../../model/show_time.dart';

class SeatBookingScreen extends StatefulWidget {
  final String? jsonObject;
  const SeatBookingScreen({Key? key, required this.jsonObject}) : super(key: key);

  @override
  State<SeatBookingScreen> createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  late final ShowTime? showTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showTime = ShowTime.fromJson(jsonDecode(widget.jsonObject!));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Breadcrumb(
            title: "Đặt ghế ngồi",
            imageUrl: "assets/image/breadcrumb_movie_screen.png",
            description:
            "Vui lòng đặt ghế ngồi tại Cinema StarLineX Entertainment",
          ),
        BodySeat(
          showTime: showTime,
        ),
        ],
      ),
    );
  }
}
