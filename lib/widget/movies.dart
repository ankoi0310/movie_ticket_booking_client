import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';

class Movies extends StatefulWidget {
  final List<Movie> movies;
  final Map<String, Uint8List> images;

  const Movies({
    Key? key,
    required this.movies,
    required this.images,
  }) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // late MovieProvider _movieProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appRouterDelegate = AppRouterDelegate.instance;

    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight * 0.1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            indicator: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2),
              ),
            ),
            dividerColor: Colors.transparent,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.grey[500],
            labelColor: Colors.black,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            labelPadding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(10),
            ),
            tabs: [
              Tab(text: "Phim đang chiếu".toUpperCase()),
              Tab(text: "Phim sắp chiếu".toUpperCase()),
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
                              appRouterDelegate.setPathName("${PublicRouteData.movie.name}/${widget.movies[index].slug}");
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
                                Text(
                                  widget.movies[index].name,
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyMedium!.color,
                                    fontSize: getProportionateScreenWidth(22),
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
    );
  }
}
