import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/booking/components/filter_movie_ticket.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/booking/components/list_show_time_movie.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie/components/breadcrumb.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Breadcrumb(
            title: "Đặt vé",
            imageUrl: "assets/image/breadcrumb_movie_screen.png",
            description: "Nơi đặt vé xem phim tại rạp phim Cinema StarLineX Entertainment",
          ),
          FilterMovieTicket(),
          ListShowTimeMovie(),
        ],
      ),
    );
  }
}
