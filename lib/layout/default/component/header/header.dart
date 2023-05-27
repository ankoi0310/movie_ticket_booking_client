import 'package:movie_ticket_booking_flutter_nlu/component/custom_search_bar.dart';
import 'package:movie_ticket_booking_flutter_nlu/component/list_menu.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/layout/default/component/header/component/avatar.dart';
import 'package:movie_ticket_booking_flutter_nlu/layout/default/component/header/component/notification_button.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate.instance;
  final double _seacrhBarHeight = 90;

  late final AuthenticationProvider _authenticationProvider = Provider.of<AuthenticationProvider>(context);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      toolbarHeight: _seacrhBarHeight,
      centerTitle: true,
      title: const CustomSearchBar(),
      bottom: const ListMenu(),
      leadingWidth: SizeConfig.screenWidth * 0.1,
      leading: LogoButton(
        path: 'image/logo.png',
        onPressed: () => _appRouterDelegate.setPathName(PublicRouteData.home.name),
      ),
      actions: [
        FutureBuilder(
          future: _authenticationProvider.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return Row(
                children: [
                  const NotificationButton(),
                  SizedBox(width: getProportionateScreenWidth(20)),
                  const Avatar(),
                ],
              );
            }

            return TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => _appRouterDelegate.setPathName(PublicRouteData.login.name),
              child: const Text(
                'Đăng nhập',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.02),
      ],
    );
  }
}
