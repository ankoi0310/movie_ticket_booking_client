import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationService authenticationService = AuthenticationService.instance;
    final AppRouterDelegate appRouterDelegate = AppRouterDelegate.instance;

    return FutureBuilder(
      future: authenticationService.getAvatar(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              showMenu(
                context: context,
                constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
                position: const RelativeRect.fromLTRB(21, 64, 20, 0),
                items: [
                  PopupMenuItem(
                    onTap: () {
                      Navigator.pop(context);
                      appRouterDelegate.setPathName(AuthRouteData.profile.name);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.person),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        const Text('Thông tin cá nhân'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      authenticationService.logout().then((_) {
                        Navigator.pop(context);
                        appRouterDelegate.setPathName(PublicRouteData.home.name);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        const Text('Đăng xuất'),
                      ],
                    ),
                  ),
                ],
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: accentColor,
                backgroundImage: NetworkImage(snapshot.data.toString()),
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}