import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/page_carousel_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/carousel_home.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/category_home.dart';
import 'package:provider/provider.dart';


class MobileLayout extends StatefulWidget {
  const MobileLayout({
    super.key,
  });

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ChangeNotifierProvider(
        create: (context) => PageCarouselProvider(),
        child: PageView(
            scrollDirection: Axis.vertical,
            onPageChanged: (index) {
              FocusScope.of(context).unfocus();
            },
            children: const [
              CarouselHome(),
              CategoryHome()
            ]
        ),
      ),
    );
  }
}
