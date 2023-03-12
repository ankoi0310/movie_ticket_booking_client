import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_flutter_nlu/config/size_config.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/scrolling_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/routing/movie_router_delegate.dart';
import 'package:movie_ticket_booking_flutter_nlu/routing/route_handler.dart';
import 'package:provider/provider.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2,
        vsync: this, initialIndex: 0,
      animationDuration: const Duration(milliseconds: 500)
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollingProvider = Provider.of<ScrollingProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.only(top: 20),
      child: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              unselectedLabelStyle: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color
                    ?.withOpacity(0.5),
                fontWeight: FontWeight.bold,
              ),
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              unselectedLabelColor: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .color
                  ?.withOpacity(0.5),
              tabs: [
                Tab(
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.5,
                    child: Text("Phim đang chiếu".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.5,
                    child: Text("Phim sắp chiếu".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                return true;
              },
              child: SizedBox(
                height: 600,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          ...List.generate(
                            6,
                            (index) => InkWell(
                              onTap: () {
                                scrollingProvider.scrollToTop();
                                MovieRouterDelegate().setPathName("${RouteData.movie.name}/${movies[index].id}");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth * 0.31,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: movies[index].imageDesktop.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    movies[index].name,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color,
                                      fontSize: getProportionateScreenWidth(28),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          ...List.generate(
                            6,
                            (index) => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth * 0.31,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: movies[index].imageDesktop.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  movies[index].name,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color,
                                    fontSize: getProportionateScreenWidth(28),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
