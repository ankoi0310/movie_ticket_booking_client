import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/page_carousel_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/movie_carousel_card.dart';
import 'package:provider/provider.dart';

class MoviesCarouselView extends StatefulWidget {
  const MoviesCarouselView({Key? key}) : super(key: key);

  @override
  State<MoviesCarouselView> createState() => _MoviesCarouselViewState();
}

class _MoviesCarouselViewState extends State<MoviesCarouselView> {
  PageController pageController =
      PageController(viewportFraction: 0.8, initialPage: 0
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height ,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return true;
        },
        child: Consumer<PageCarouselProvider>(
          builder: (context, pageCarouselProvider, child) => PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: List.generate(
                movies.length, (index) => MovieCarouselCard(index: index, movie: movies[index],)),
            onPageChanged: (currentPage) {
              pageCarouselProvider.changeCurrentPage(currentPage);
            },
          ),
        ),
      ),
    );
  }
}
