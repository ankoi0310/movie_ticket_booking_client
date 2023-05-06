import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/menu_item.dart';

class ListMenu extends StatelessWidget implements PreferredSizeWidget {
  const ListMenu({Key? key}) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final appRouterDelegate = AppRouterDelegate.instance;

    return Container(
      color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * 0.1,
        vertical: 10,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          menuItems.length,
          (index) => Expanded(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: MenuButton(
                      label: menuItems[index].label,
                      color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                      hoverColor: primaryColor,
                      onPressed: () => appRouterDelegate.setPathName(menuItems[index].route.name),
                    ),
                  ),
                  if (index != menuItems.length - 1)
                    VerticalDivider(
                      color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
