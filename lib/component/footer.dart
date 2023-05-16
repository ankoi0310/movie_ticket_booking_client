import 'package:movie_ticket_booking_flutter_nlu/component/footer/social_network.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/footer/web_info.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isDesktop = Responsive.isDesktop(context);

    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 0 : width / 10,
        vertical: isMobile ? 0 : 20,
      ),
      padding: EdgeInsets.all(isMobile ? 5 : 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isMobile
            ? const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )
            : BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SocialNetwork(isDesktop: isDesktop),
                WebInfo(isMobile: isMobile),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SocialNetwork(isDesktop: isDesktop),
                WebInfo(isMobile: isMobile),
              ],
            ),
    );
  }
}
