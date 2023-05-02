import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class MenuItem {
  final String title;
  final String icon;
  final RouteData route;

  const MenuItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}

const List<MenuItem> menuItems = [
  MenuItem(
    title: 'Trang chủ',
    icon: '/icons/home.svg',
    route: PublicRouteData.home,
  ),
  MenuItem(
    title: 'Phim',
    icon: '/icons/movie.svg',
    route: PublicRouteData.movie,
  ),
  MenuItem(
    title: 'Diễn viên',
    icon: '/icons/actor.svg',
    route: PublicRouteData.movie,
  ),
  MenuItem(
    title: 'Rạp/Giá vé',
    icon: '/icons/ticket.svg',
    route: PublicRouteData.ticket,
  ),
  MenuItem(
    title: 'Tài khoản',
    icon: '/icons/user.svg',
    route: AuthRouteData.profile,
  ),
];
