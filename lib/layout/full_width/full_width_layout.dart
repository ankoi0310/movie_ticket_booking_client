import 'package:movie_ticket_booking_flutter_nlu/core.dart';

class FullWidthLayout extends StatefulWidget {
  const FullWidthLayout({
    Key? key,
    required this.routeName,
    required this.parameters,
  }) : super(key: key);

  final String? routeName;
  final Map<String, String>? parameters;

  @override
  State<FullWidthLayout> createState() => _FullWidthLayoutState();
}

class _FullWidthLayoutState extends State<FullWidthLayout> {
  final RouteHandler _routeHandler = RouteHandler.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        // margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: FutureBuilder(
          future: _routeHandler.getRouteWidget(widget.routeName, queryParameters: widget.parameters),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data as Widget;
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
