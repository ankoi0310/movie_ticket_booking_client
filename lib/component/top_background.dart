import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class TopBackground extends StatelessWidget {
  const TopBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: Responsive.isMobile(context) ? 300 : 450,
      child: Image.asset(
        'assets/image/breadcrumb_movie_screen.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
