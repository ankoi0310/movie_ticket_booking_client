import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class MenuItem {
  final String label;
  final String icon;
  final RouteData route;

  const MenuItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}

const List<MenuItem> menuItems = [
  MenuItem(
    label: 'Trang chủ',
    icon: '/icons/home.svg',
    route: PublicRouteData.home,
  ),
  MenuItem(
    label: 'Phim',
    icon: '/icons/movie.svg',
    route: PublicRouteData.movie,
  ),
  MenuItem(
    label: 'Diễn viên',
    icon: '/icons/actor.svg',
    route: PublicRouteData.movie,
  ),
  MenuItem(
    label: 'Rạp/Giá vé',
    icon: '/icons/ticket.svg',
    route: PublicRouteData.ticket,
  ),
];
