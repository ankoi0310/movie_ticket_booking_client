import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class NotificationButton extends StatefulWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            showMenu(
              context: context,
              constraints: const BoxConstraints(minWidth: 400, maxHeight: 500),
              position: const RelativeRect.fromLTRB(121, 62, 120, 0),
              items: [
                PopupMenuItem(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: List.generate(
                      5,
                      (index) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.notifications),
                          SizedBox(width: getProportionateScreenWidth(10)),
                          const Text('Thông báo'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          child: Container(
            margin: EdgeInsets.all(getProportionateScreenWidth(3)),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: accentColor,
              child: Icon(Icons.notifications, color: Colors.black),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
