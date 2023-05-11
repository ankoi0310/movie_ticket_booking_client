import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/showtime/show_time_search.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/branch.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/movie.dart';
import 'package:movie_ticket_booking_flutter_nlu/provider/api/show_time_provider.dart';
import 'package:movie_ticket_booking_flutter_nlu/widget/hover_builder.dart';

class ListShowTimeMovie extends StatefulWidget {
  const ListShowTimeMovie({Key? key}) : super(key: key);

  @override
  State<ListShowTimeMovie> createState() => _ListShowTimeMovieState();
}

class _ListShowTimeMovieState extends State<ListShowTimeMovie> {
  @override
  Widget build(BuildContext context) {
    final showTimeProvider = Provider.of<ShowTimeProvider>(context, listen: false);
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    final appRouterDelegate = AppRouterDelegate.instance;

    return Consumer<InformationTicketSelectedProvider>(builder: (context, informationProvider, child) {
      return FutureBuilder(
        future: showTimeProvider.getAllShowTime(ShowTimeSearch(
          movie: informationProvider.selectedMovie,
          branch: informationProvider.selectedBranch,
          startTime: informationProvider.selectedDate,
        )),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Future.delayed(Duration.zero, () {
              loadingProvider.setLoading(false);
            });

            List<Movie?> movies = showTimeProvider.showTimes.map((e) => e.movie).toSet().toList();
            List<Branch> branchList = showTimeProvider.showTimes.map((e) => e.room!.branch).toSet().toList();

            return Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(100),
                vertical: getProportionateScreenWidth(25),
              ),
              child: Column(
                children: List.generate(branchList.length, (branchIndex) {
                  return Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: SizeConfig.screenWidth * 0.2,
                        height: 40,
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: getProportionateScreenWidth(15),
                        ),
                        margin: EdgeInsets.only(
                          top: getProportionateScreenWidth(20),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: const Border(
                            left: BorderSide(
                              color: Colors.black,
                              width: 10,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          branchList[branchIndex].name,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(22),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(movies.length, (movieIndex) {
                        return showTimeProvider.showTimes
                                .where((showtime) => showtime.movie == movies[movieIndex] && showtime.room!.branch == branchList[branchIndex])
                                .isNotEmpty
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(30),
                                  vertical: getProportionateScreenWidth(30),
                                ),
                                margin: EdgeInsets.only(
                                  bottom: getProportionateScreenWidth(20),
                                ),
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        movies[movieIndex]!.name,
                                        style: TextStyle(
                                          fontSize: getProportionateScreenWidth(30),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        showTimeProvider.showTimes[movieIndex].movieFormat.value,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: getProportionateScreenWidth(24),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Wrap(
                                          alignment: WrapAlignment.start,
                                          children: showTimeProvider.showTimes
                                              .where((showtime) =>
                                                  showtime.movie?.id == movies[movieIndex]?.id &&
                                                  showtime.room?.branch.id == branchList[branchIndex].id)
                                              .map(
                                                (showtime) => HoverBuilder(builder: (isHovering) {
                                                  return InkWell(
                                                    onTap: () {
                                                      appRouterDelegate.setPathName(PublicRouteData.seat.name,
                                                          json: jsonEncode({
                                                            'showtime': showtime.toJson(),
                                                            'listSeatSelected': [],
                                                          }));
                                                    },
                                                    child: Container(
                                                        margin: EdgeInsets.only(right: getProportionateScreenWidth(20)),
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: getProportionateScreenWidth(20),
                                                          vertical: getProportionateScreenWidth(10),
                                                        ),
                                                        width: getProportionateScreenWidth(150),
                                                        decoration: BoxDecoration(
                                                          color: isHovering ? Theme.of(context).primaryColor : Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                          border: Border.all(
                                                            color: Colors.black,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          DateFormat('HH : mm').format(showtime.startTime!),
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: isHovering ? Colors.white : Colors.black,
                                                            fontSize: getProportionateScreenWidth(24),
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        )),
                                                  );
                                                }),
                                              )
                                              .toList()),
                                    )
                                  ],
                                ),
                              )
                            : Container();
                      }),
                    ),
                  ]);
                }),
              ),
            );
          } else {
            Future.delayed(Duration.zero, () {
              loadingProvider.setLoading(true);
            });
            return Container();
          }
        },
      );
    });
  }
}
