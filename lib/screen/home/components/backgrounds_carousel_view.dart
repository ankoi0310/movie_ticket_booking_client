import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/page_carousel_provider.dart';
import 'package:provider/provider.dart';

class BackgroundsCarouselView extends StatefulWidget {
  const BackgroundsCarouselView({Key? key}) : super(key: key);

  @override
  State<BackgroundsCarouselView> createState() =>
      _BackgroundsCarouselViewState();
}

class _BackgroundsCarouselViewState extends State<BackgroundsCarouselView> {
  Size get size => MediaQuery.of(context).size;
  PageController pageController = PageController(
    viewportFraction: 1,
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<PageCarouselProvider>(
      builder: (context, pageCarouselProvider, child) {
        if (pageController.hasClients) {
          pageController.animateToPage(
            pageCarouselProvider.currentPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
          );
        }
        return SizedBox(
          height: size.height ,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: PageView(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  movies.length,
                  (index) {
                    return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Positioned(
                            left: -size.width / movies.length ,
                            right: -size.width / movies.length ,
                            child: Image(
                              image: movies[index].image.image,
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(.4),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    // black.withOpacity(.9),
                                    Colors.black.withOpacity(.3),
                                    Colors.black.withOpacity(.95)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.5, 0.9]),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ),
        );
      },
    );
  }
}
