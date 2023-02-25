import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedLabelStyle: TextStyle(
        fontSize: getProportionateScreenWidth(12),
        fontWeight: FontWeight.bold,
      ),
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        buildBottomNavigationBarItem(
          context: context,
          icon: Icons.home,
          label: 'Home',
        ),
        buildBottomNavigationBarItem(
          context: context,
          icon: const IconData(0xf916, fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage),
          label: 'Tickets',
        ),
        buildBottomNavigationBarItem(
          context: context,
          icon: Icons.notifications,
          label: 'Notifications',
        ),
        buildBottomNavigationBarItem(
          context: context,
          icon: Icons.person,
          label: 'Profile',
        ),
      ],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required IconData icon,
    required BuildContext context,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Theme.of(context).textTheme.titleMedium!.color,
      ),
      activeIcon: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      label: label,
    );
  }
}
