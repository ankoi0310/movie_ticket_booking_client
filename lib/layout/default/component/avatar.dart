import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/user/user_info.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/user_provider.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    final AuthenticationProvider authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    final AppRouterDelegate appRouterDelegate = AppRouterDelegate.instance;

    return FutureBuilder(
      future: userProvider.getProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserInfo userInfo = snapshot.data!;
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
                    onTap: () async {
                      await authenticationProvider.logout();
                      await appRouterDelegate.setPathName(PublicRouteData.home.name);
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
                backgroundImage: NetworkImage(userInfo.avatar),
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
