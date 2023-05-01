import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/hover_builder.dart';

class CustomNavBarTile extends StatelessWidget {
  const CustomNavBarTile({
    super.key,
    required this.title,
    required this.route,
    required this.onTap,
  });

  final String title;
  final String route;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final scrollingProvider = Provider.of<ScrollingProvider>(context);

    return Expanded(
      flex: 5,
      child: HoverBuilder(
        builder: (isHovering) => InkWell(
          hoverColor: Colors.transparent,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () => onTap,
          child: Center(
            heightFactor: 1.5,
            child: Text(title.toUpperCase(),
                style: TextStyle(
                  color: (isHovering ? Theme.of(context).primaryColor : (scrollingProvider.totalScrollDelta <= 50 ? Colors.white : Colors.black)),
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ),
    );
  }
}
