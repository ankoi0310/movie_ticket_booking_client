import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class CustomLoadingScreen extends StatefulWidget {
  const CustomLoadingScreen({Key? key}) : super(key: key);

  @override
  State<CustomLoadingScreen> createState() => _CustomLoadingScreenState();
}

class _CustomLoadingScreenState extends State<CustomLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      color: Colors.black26,
      child: const Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
    );
  }
}
