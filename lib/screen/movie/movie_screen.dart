import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/movie/components/breadcrumb.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/movies.dart';

class MovieScreen extends StatefulWidget {

  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return  const SingleChildScrollView(
      child: Column(
        children: [
          Breadcrumb(
            title: "Phim",
            imageUrl: "assets/image/breadcrumb_movie_screen.png",
            description:
                "Tất cả các phim đang chiếu và sắp chiếu tại rạp phim Cinema StarLineX Entertainment",
          ),
          Movies(
          ),
        ],
      ),
    );
  }
}
