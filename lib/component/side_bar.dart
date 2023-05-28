import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/menu_item.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      width: Responsive.isDesktop(context) ? 250 : 150,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState!.closeDrawer(),
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
                LogoButton(path: 'image/logo.png', onPressed: () => {}),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...menuItems.map(
            (item) => MenuButton(
              label: item.label,
              color: Theme.of(context).brightness == Brightness.light ? LightTheme.textColor : DarkTheme.textColor,
              hoverColor: accentColor,
              onPressed: () => AppRouterDelegate.instance.setPathName(item.route.name),
            ),
          ),
        ],
      ),
    );
  }
}
