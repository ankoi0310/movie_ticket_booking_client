import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie/components/breadcrumb.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/ticket_booking/components/filter_movie_ticket.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/ticket_booking/components/list_show_time_movie.dart';

class TicketBookingScreen extends StatefulWidget {
  const TicketBookingScreen({Key? key}) : super(key: key);

  @override
  State<TicketBookingScreen> createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<TicketBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Breadcrumb(
            title: "Đặt vé",
            imageUrl: "assets/image/breadcrumb_movie_screen.png",
            description:
                "Nơi đặt vé xem phim tại rạp phim Cinema StarLineX Entertainment",
          ),
          FilterMovieTicket(),
          ListShowTimeMovie(),
        ],
      ),
    );
  }
}
