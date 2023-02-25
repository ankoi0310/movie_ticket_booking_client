import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/screen/home/components/category_home.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryHome(),

    );
  }
}
