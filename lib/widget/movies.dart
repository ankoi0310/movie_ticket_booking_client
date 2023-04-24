import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie_model.dart';

class Movies extends StatefulWidget {
  final List<Movie> movies;
  final Map<String, Uint8List> images;

  const Movies({Key? key, required this.movies, required this.images}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // late MovieProvider _movieProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0, animationDuration: const Duration(milliseconds: 500));
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
                color: Theme.of(context).textTheme.bodyMedium!.color?.withOpacity(0.5),
                fontWeight: FontWeight.bold,
              ),
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              unselectedLabelColor: Theme.of(context).textTheme.bodyMedium!.color?.withOpacity(0.5),
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
                        left: 20,
                        right: 20,
                      ),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.start,
                        children: [
                          ...List.generate(
                            widget.movies.length,
                            (index) => InkWell(
                              onTap: () {
                                scrollingProvider.scrollToTop();
                                AppRouterDelegate().setPathName("${RouteData.movie.name}/${widget.movies[index].slug}");
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
                                        image: Image.memory(
                                          widget.images[widget.movies[index].imageHorizontal]!,
                                        ).image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      widget.movies[index].name,
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.bodyMedium!.color,
                                        fontSize: getProportionateScreenWidth(28),
                                        fontWeight: FontWeight.bold,
                                      ),
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
                            widget.movies.length,
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
                                      image: Image.memory(
                                        widget.images[widget.movies[index].imageHorizontal]!,
                                      ).image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.movies[index].name,
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyMedium!.color,
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
