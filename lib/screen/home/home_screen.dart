import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/backgrounds_carousel_view.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/carousel_home.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/category_home.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/movies_carousel_view.dart';
import 'package:provider/provider.dart';

import '../../provider/page_carousel_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ChangeNotifierProvider(
        create: (context) => PageCarouselProvider(),
        child: PageView(
          scrollDirection: Axis.vertical,
          children: const [
            CarouselHome(),
            CategoryHome()
          ]
        ),
      ),
    );
  }
}
