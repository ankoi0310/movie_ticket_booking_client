import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/backgrounds_carousel_view.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/movies_carousel_view.dart';

class CarouselHome extends StatefulWidget {
  const CarouselHome({Key? key}) : super(key: key);

  @override
  State<CarouselHome> createState() => _CarouselHomeState();
}

class _CarouselHomeState extends State<CarouselHome> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BackgroundsCarouselView(),
          MoviesCarouselView(),
        ],
      ),
    );
  }
}
