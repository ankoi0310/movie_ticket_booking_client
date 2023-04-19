import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie/components/breadcrumb.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/seating_booking/components/body_seat.dart';

class SeatBookingScreen extends StatefulWidget {
  const SeatBookingScreen({Key? key}) : super(key: key);

  @override
  State<SeatBookingScreen> createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Breadcrumb(
            title: "Đặt ghế ngồi",
            imageUrl: "assets/image/breadcrumb_movie_screen.png",
            description:
            "Vui lòng đặt ghế ngồi tại Cinema StarLineX Entertainment",
          ),
        BodySeat(),
        ],
      ),
    );
  }
}
