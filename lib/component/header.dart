import 'package:movie_ticket_booking_flutter_nlu/component/custom_search_bar.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.isLoggedIn,
  }) : super(key: key);

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const CustomSearchBar();
  }
}
